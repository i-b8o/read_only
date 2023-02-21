import 'dart:async';
import 'dart:isolate';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class ChapterDataProvider {
  const ChapterDataProvider();
  Future<Chapter?> getChapter(int id);
}

abstract class ParagraphServiceLocalChapterDataProvider {
  Future<List<Paragraph>?> getParagraphs(int id);
}

abstract class ChapterServiceLocalChapterDataProvider {
  Future<Chapter?> getChapter(int id);
}

abstract class ChapterServiceLocalDocDataProvider {
  Future<bool> contains(int id);
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
  final ParagraphServiceLocalChapterDataProvider
      paragraphServiceLocalChapterDataProvider;
  final ChapterServiceLocalChapterDataProvider localChapterDataProvider;
  final ChapterServiceLocalDocDataProvider localDocDataProvider;

  const ChapterService(
      {required this.chapterDataProvider,
      required this.ttsSettingsDataProvider,
      required this.paragraphServiceLocalChapterDataProvider,
      required this.localChapterDataProvider,
      required this.localDocDataProvider});

  @override
  Future<Chapter?> getOne(int id) async {
    // first look in a local database
    final saved = await localDocDataProvider.contains(id);
    Chapter? chapter;
    if (saved) {
      chapter = await localChapterDataProvider.getChapter(id);
      if (chapter == null) {
        return null;
      }
    }
    // TODO chapters

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    // final isolate = await Isolate.spawn(
    // isolateFunction,
    // AddDocIsolateMessage(
    // sendPort: sendPort,
    // chaptersIds: chaptersIDs,
    // ));

    // receivePort.listen((message) {
    //   print('main isolate: $message');
    //   isolate.kill(priority: Isolate.immediate);
    // });

    // then look at a server
    // chapter = await chapterDataProvider.getChapter(id);
    // if (chapter == null) {
    //   return null;
    // }
  }
}

Future<void> isolateFunction(AddDocIsolateMessage message) async {
  for (final id in message.chaptersIds) {
    print('received id: $id');
  }

  message.sendPort.send('Hello from the isolate!');
}

class AddDocIsolateMessage {
  final SendPort sendPort;
  final List<int> chaptersIds;

  AddDocIsolateMessage({
    required this.sendPort,
    required this.chaptersIds,
  });
}
