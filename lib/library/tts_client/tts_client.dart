import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:read_only/library/tts_client/tts_settings.dart';

abstract class TtsClient {
  Future<bool>? checkLanguage(String locale);
  Future<List<String>>? getVoices(String locale);
  Future<void> setVoice(String name);
  Future<void> setPitch(double pitch);
  Future<void> setSpeechRate(double rate);
  Future<void> setVolume(double volume);
  Future<void> speak(String text);
  Future<void> stop();
  Future<void> pause();
  TtsSettings getSettings();
}

class DefaultTtsClient implements TtsClient {
  static final _plugin = FlutterTts();
  TtsSettings _ttsSettings = const TtsSettings();
  @override
  TtsSettings getSettings() => _ttsSettings;
  DefaultTtsClient() {
    asyncInit();
  }

  asyncInit() async {
    try {
      await _plugin.awaitSpeakCompletion(true);
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'init_error',
          message: exception.toString(),
          details: stackTrace.toString());
    }
  }

  @override
  Future<bool>? checkLanguage(String locale) async {
    if (locale.isEmpty) {
      throw UnsupportedError('the language name can not be empty');
    }
    try {
      List<String>? languages = List<String>.from(await _plugin.getLanguages);
      if (!languages.contains(locale)) {
        return false;
      }
      return true;
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'get_languages_error',
          message: 'error for $locale',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<List<String>> getVoices(String locale) async {
    List<String> result = [];
    try {
      var voices = await _plugin.getVoices;
      for (var v in voices) {
        if (v['locale'] == locale) {
          result.add(v['name'] ?? "");
        }
      }
      return result;
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'get_voices_error',
          message: 'error for $locale',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<void> setVoice(String voiceName) async {
    if (voiceName.isEmpty) {
      throw UnsupportedError('the voice name can not be empty');
    }
    try {
      Map<String, String>? voice;
      List voices = await _plugin.getVoices;
      for (var v in voices) {
        if (v['name'] == voiceName) {
          voice = {"name": voiceName, "locale": v["locale"] ?? "ru-RU"};
        }
      }
      if (voice == null) {
        throw UnsupportedError('the voice $voiceName does not exist');
      }
      _ttsSettings = _ttsSettings.copyWith(voice: voice["name"] ?? "");
      await _plugin.setVoice(voice);
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'set_voice_error',
          message: 'error for $voiceName',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<void> setPitch(double pitch) async {
    if (pitch < 0) {
      throw UnsupportedError('pitch must be positive');
    }
    if (pitch > 1) {
      throw UnsupportedError('pitch must be less than 1');
    }
    try {
      // ranges from .5 to 2.0
      pitch = pitch * 1.5 + 0.5;
      _ttsSettings = _ttsSettings.copyWith(pitch: pitch);
      await _plugin.setPitch(pitch);
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'set_pitch_error',
          message: 'error for $pitch',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<void> setSpeechRate(double rate) async {
    if (rate < 0) {
      throw UnsupportedError('rate must be positive');
    }
    if (rate > 1) {
      throw UnsupportedError('rate must be less than 1');
    }
    try {
      _ttsSettings = _ttsSettings.copyWith(speechRate: rate);
      await _plugin.setSpeechRate(rate);
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'set_speech_rate_error',
          message: 'error for $rate',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<void> setVolume(double volume) async {
    if (volume < 0) {
      throw UnsupportedError('volume must be positive');
    }
    if (volume > 1) {
      throw UnsupportedError('volume must be less than 1');
    }
    try {
      _ttsSettings = _ttsSettings.copyWith(volume: volume);
      await _plugin.setVolume(volume);
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'set_volume_error',
          message: 'error for $volume',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<void> speak(String text) async {
    if (text.isEmpty) {
      return;
    }
    try {
      await _plugin.speak(text);
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'speek_error',
          message: 'error for $text',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _plugin.stop();
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'stop_error',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<void> pause() async {
    try {
      await _plugin.pause();
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'pause_error',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }
}
