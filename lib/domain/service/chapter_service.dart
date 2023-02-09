import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class ChapterDataProvider {
  const ChapterDataProvider();
  Future<ReadOnlyChapter?> getChapter(int id);
}

abstract class ChapterServiceLocalDocDataProvider {
  Future<void> updateLastAccess(int id);
}

abstract class ChapterServiceLocalChapterDataProvider {
  Future<ReadOnlyChapter?> getChapter(int id);
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
  final ChapterServiceLocalDocDataProvider chapterServiceLocalDocDataProvider;
  final ChapterServiceLocalChapterDataProvider
      chapterServiceLocalChapterDataProvider;

  const ChapterService({
    required this.chapterDataProvider,
    required this.ttsSettingsDataProvider,
    required this.chapterServiceLocalDocDataProvider,
    required this.chapterServiceLocalChapterDataProvider,
  });

  @override
  Future<ReadOnlyChapter?> getOne(int id) async {
    // first look in a local database
    final chapters =
        await chapterServiceLocalChapterDataProvider.getChapter(id);
    if (chapters != null) {
      // In order to delete unused documents from a local database
      // store the date of last use
      await chapterServiceLocalDocDataProvider.updateLastAccess(id);
      return chapters;
    }

    // if not get from a server
    return await chapterDataProvider.getChapter(id);
  }
}
