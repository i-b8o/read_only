import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

class LanguageIsNotSelected implements Exception {
  const LanguageIsNotSelected();
}

abstract class ChapterDataProvider {
  const ChapterDataProvider();
  Future<ReadOnlyChapter> getOne(int id);
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

  const ChapterService({
    required this.chapterDataProvider,
    required this.ttsSettingsDataProvider,
  });

  @override
  Future<ReadOnlyChapter> getOne(int id) async {
    return await chapterDataProvider.getOne(id);
  }
}
