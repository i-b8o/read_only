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
    final chaptersIDs = await localDocDataProvider.getAllChaptersIDs(id);
    if (chaptersIDs == null) {
      return null;
    }

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    final isolate = await Isolate.spawn(
        isolateFunction, _IsolateMessage(sendPort, chaptersIDs));

    receivePort.listen((message) {
      print('main isolate: $message');
      isolate.kill(priority: Isolate.immediate);
    });

    // then look at a server
    // chapter = await chapterDataProvider.getChapter(id);
    // if (chapter == null) {
    //   return null;
    // }
  }
}

void isolateFunction(_IsolateMessage message) {
  for (final id in message.messageData) {
    print('received id: $id');
  }

  message.sendPort.send('Hello from the isolate!');
}

class _IsolateMessage {
  final SendPort sendPort;
  final List<int> messageData;

  _IsolateMessage(this.sendPort, this.messageData);
}
