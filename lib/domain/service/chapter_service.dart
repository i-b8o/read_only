import 'dart:async';
import 'dart:isolate';

import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class ChapterDataProvider {
  const ChapterDataProvider();
  Future<Chapter?> getChapter(int id);
}

abstract class ChapterServiceLocalChapterDataProvider {
  Future<Chapter?> getChapter(int id);
}

abstract class ChapterServiceLocalDocDataProvider {
  Future<bool> saved(int id);
  Future<List<int>?> getAllChaptersIDs(int docID);
}

abstract class TtsSettingsDataProvider {
  const TtsSettingsDataProvider();
  Future<void> saveVolume(double value);
  Future<void> saveVoice(String value);
  Future<String?> readCurrentLanguage();
}

class ChapterService implements ChapterViewModelService {
  final ChapterDataProvider chapterDataProvider;
  final TtsSettingsDataProvider ttsSettingsDataProvider;
  final ChapterServiceLocalChapterDataProvider localChapterDataProvider;
  final ChapterServiceLocalDocDataProvider localDocDataProvider;

  const ChapterService(
      {required this.chapterDataProvider,
      required this.ttsSettingsDataProvider,
      required this.localChapterDataProvider,
      required this.localDocDataProvider});

  @override
  Future<Chapter?> getOne(int id) async {
    // first look in a local database
    final saved = await localDocDataProvider.saved(id);
    Chapter? chapter;
    if (saved) {
      chapter = await localChapterDataProvider.getChapter(id);
      L.info(
          "Chapter service ${chapter == null} ${chapter!.paragraphs!.length} ");
      if (chapter != null) {
        return chapter;
      }
    }
    // then look at a server
    chapter = await chapterDataProvider.getChapter(id);
    if (chapter == null) {
      return null;
    }

    // complete with the missing
    final ids = await localDocDataProvider.getAllChaptersIDs(id);
    for (final id in ids!) {
      getChapterInIsolate(id);
    }
  }

  Future<Chapter?> getChapterInIsolate(int chapterId) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      _getChapterIsolate,
      _IsolateMessage(receivePort.sendPort, chapterId),
    );
    final completer = Completer<Chapter?>();
    receivePort.listen((data) {
      if (data is Chapter) {
        completer.complete(data);
      } else {
        completer.complete(null);
      }
      receivePort.close();
    });
    return completer.future;
  }

  void _getChapterIsolate(_IsolateMessage message) async {
    final chapter = await chapterDataProvider.getChapter(message.chapterId);
    print("chapter: $chapter");
    message.sendPort.send(chapter);
  }

  // void backgroundTask(SendPort sendPort) {
  //   // Perform a time-consuming task in the background
  //   int result = 0;
  //   for (int i = 0; i < _; i++) {
  //     result += i;
  //   }
  //   sendPort.send(result);
  // }

  // void launchInBackground() {
  //   ReceivePort receivePort = ReceivePort();
  //   Isolate.spawn(backgroundTask, receivePort.sendPort);

  //   receivePort.listen((data) {
  //     print('Result of the background task: $data');
  //   });
  // }
}

class _IsolateMessage {
  final SendPort sendPort;
  final int chapterId;

  _IsolateMessage(this.sendPort, this.chapterId);
}
