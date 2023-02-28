import 'package:read_only/domain/entity/tts_position.dart';
import 'package:read_only/library/text/text.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class TtsDataProvider {
  Future<bool> speak(String text);
  Future<bool> stop();
  Future<bool> pause();
  Future<bool> resume();
  Future<bool> highlighting();
  // Stream<TtsPosition>? positionStream();
}

abstract class TtsSettingsDataProvider {
  Future<bool> setVolume(double value);
  Future<bool> setRate(double value);
  Future<bool> setPitch(double value);
  Future<List<String>?> getVoices();
  Future<bool> setVoice(String voice);
}

class TtsService
    implements ChapterViewModelTtsService, DrawerViewModelTtsSettingService {
  final TtsDataProvider ttsDataProvider;
  final TtsSettingsDataProvider ttsSettingsDataProvider;
  List<String>? currentTexts;
  int currentParagraphIndex = 0;
  bool paused = false;
  bool stoped = false;
  TtsService(
      {required this.ttsDataProvider, required this.ttsSettingsDataProvider});

  Future<bool> _speak(List<String> texts, {bool multiple = true}) async {
    stoped = false;
    currentTexts = texts;

    for (var i = 0; i < texts.length; i++) {
      if (paused || stoped) {
        break;
      }
      if (multiple && (i <= currentParagraphIndex)) {
        continue;
      }

      currentParagraphIndex = i;
      final text = parseHtmlString(texts[i].replaceAll("\n", " "));
      await ttsDataProvider.speak(text);
    }
    return true;
  }

  @override
  Future<bool> speakList(List<String> texts) async {
    if (texts.isEmpty) {
      return false;
    }
    return await _speak(texts);
  }

  @override
  Future<bool> speakOne(String text) async {
    if (text.isEmpty) {
      return false;
    }
    return await _speak([text], multiple: false);
  }

  @override
  Future<bool> resumeSpeak() async {
    paused = false;
    final ok = await ttsDataProvider.resume();
    if (!ok || currentTexts == null) {
      return false;
    }

    return await _speak(currentTexts!);
  }

  @override
  Future<void> pauseSpeak() async {
    paused = true;
    ttsDataProvider.pause();
  }

  @override
  Future<bool> stopSpeak() async {
    stoped = true;
    currentParagraphIndex = 0;
    final ok = await ttsDataProvider.stop();
    if (!ok) {
      return false;
    }
    return true;
  }

  // @override
  // Future<dynamic> getLanguages() async {
  //   final languages = await ttsChannel.invokeMethod('getLanguages');
  //   return languages;
  // }

  Future<bool> highlighting() async {
    // return await ttsChannel.invokeMethod("highlighting") as bool;
    return await ttsDataProvider.highlighting();
  }

  // @override
  // Stream<TtsPosition>? positionEvent() {
  //   return ttsDataProvider.positionStream();
  // }

  // @override
  // Future<List<String>?> getVoices() async {
  //   final voices = await ttsChannel.invokeMethod('getVoices') as List<dynamic>?;
  //   if (voices != null) {
  //     return List<String>.from(voices);
  //   }
  //   return null;
  // }

  // @override
  // Future<bool> setLanguage(String language) async {
  //   return await ttsChannel.invokeMethod('setLanguage', language) as bool;
  // }

  // Future<bool> setVoice(String voice) async =>
  //     await ttsChannel.invokeMethod('setVoice', voice) as bool;

  @override
  Future<bool> setVolume(double volume) async =>
      await ttsSettingsDataProvider.setVolume(volume);

  // Future<bool> setPitch(double pitch) async =>
  //     await ttsChannel.invokeMethod('setPitch', pitch) as bool;

  @override
  Future<bool> setRate(double volume) async =>
      await ttsSettingsDataProvider.setRate(volume);

  @override
  Future<bool> setPitch(double volume) async =>
      await ttsSettingsDataProvider.setPitch(volume);
  @override
  Future<List<String>?> getVoices() async =>
      await ttsSettingsDataProvider.getVoices();

  Future<bool> setVoice(String voice) async =>
      await ttsSettingsDataProvider.setVoice(voice);
}
