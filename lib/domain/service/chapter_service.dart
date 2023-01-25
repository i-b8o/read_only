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

abstract class TtsClient {
  const TtsClient();
  Future<void> speak(String text);
  Future<void> stop();
  Future<void> pause();
  Future<bool> checkLanguage(String locale);
}

class ChapterService implements ChapterViewModelService {
  final ChapterDataProvider chapterDataProvider;
  final TtsSettingsDataProvider ttsSettingsDataProvider;
  final TtsClient ttsClient;

  const ChapterService(
      {required this.chapterDataProvider,
      required this.ttsSettingsDataProvider,
      required this.ttsClient});

  @override
  Future<ReadOnlyChapter> getOne(int id) async {
    return await chapterDataProvider.getOne(id);
  }

  @override
  Future<void> pauseSpeak() async {
    return await ttsClient.pause();
  }

  @override
  Future<void> startSpeak(String text) async {
    // _currentLanguage ??= await ttsSettingsDataProvider.readCurrentLanguage();
    // if (currentLanguage == null) {
    //   throw const LanguageIsNotSelected();
    // }
    // await ttsClient.checkLanguage(currentLanguage);
    return await ttsClient.speak(text);
  }

  @override
  Future<void> stopSpeak() async {
    return await ttsClient.stop();
  }
}
