import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class ChapterDataProvider {
  const ChapterDataProvider();
  Future<Chapter?> getChapter(int id);
}

abstract class ChapterServiceLocalChapterDataProvider {
  Future<Chapter?> getChapter(int id);
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
  final ChapterServiceLocalChapterDataProvider
      chapterServiceLocalChapterDataProvider;

  const ChapterService({
    required this.chapterDataProvider,
    required this.ttsSettingsDataProvider,
    required this.chapterServiceLocalChapterDataProvider,
  });

  @override
  Future<Chapter?> getOne(int id) async {
    // first look in a local database
    final chapter = await chapterServiceLocalChapterDataProvider.getChapter(id);
    if (chapter != null) {
      // when a user selects a chapter on the `ChapterListWidget` - save all paragaraphs for a entire doc
      // get all chapters ids for
      return chapter;
    }

    // the `getOne` function was launched not from the `ChapterListWidget` - get from a server
    return await chapterDataProvider.getChapter(id);
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
