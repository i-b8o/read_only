import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:read_only/library/tts_client/tts_settings.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class TtsClient {
  Future<bool>? checkLanguage(String locale);
  Future<List<String>>? getVoices(String locale);
  Future<bool> setVoice(String name);
  Future<bool> setPitch(double pitch);
  Future<bool> setSpeechRate(double rate);
  Future<bool> setVolume(double volume);
  Future<bool> speak(String text);
  Future<bool> stop();
  Future<bool> pause();
}

class DefaultTtsClient implements TtsClient {
  static final _plugin = FlutterTts();
  TtsSettings ttsSettings = const TtsSettings();

  DefaultTtsClient() {
    asyncInit();
  }

  asyncInit() async {
    try {
      await _plugin.awaitSpeakCompletion(true);
    } catch (e) {
      throw PlatformException(code: 'init_error', message: e.toString());
    }
  }

  @override
  Future<bool>? checkLanguage(String locale) async {
    if (locale.isEmpty) {
      throw UnsupportedError('The language name can not be empty');
    }
    try {
      List<String>? languages = List<String>.from(await _plugin.getLanguages);
      if (!languages.contains(locale)) {
        return false;
      }
      return true;
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'check_language_error',
          message: 'error while check language $locale',
          details: exception,
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<List<String>> getVoices(String locale) async {
    List<String>? result = [];
    try {
      var voices = await _plugin.getVoices;
      for (var v in voices) {
        if (v['locale'] == locale) {
          result.add(v['name'] ?? "");
        }
      }
      return result;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return [];
    }
  }

  @override
  Future<bool> setVoice(String name) async {
    try {
      Map<String, String>? voice;
      List voices = await _plugin.getVoices;
      for (var v in voices) {
        if (v['name'] == name) {
          voice = {"name": name, "locale": v["locale"] ?? "ru-RU"};
        }
      }
      if (voice == null) {
        return false;
      }
      ttsSettings = ttsSettings.copyWith(voice: voice["name"] ?? "");
      await _plugin.setVoice(voice);
      return true;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<bool> setPitch(double pitch) async {
    try {
      // ranges from .5 to 2.0
      pitch = pitch * 1.5 + 0.5;
      ttsSettings = ttsSettings.copyWith(pitch: pitch);
      await _plugin.setPitch(pitch);
      return true;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<bool> setSpeechRate(double rate) async {
    try {
      ttsSettings = ttsSettings.copyWith(speechRate: rate);
      await _plugin.setSpeechRate(rate);
      return true;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<bool> setVolume(double volume) async {
    try {
      ttsSettings = ttsSettings.copyWith(volume: volume);
      await _plugin.setVolume(volume);
      return true;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<bool> speak(String text) {
    // TODO: implement speak
    throw UnimplementedError();
  }

  @override
  Future stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }

  @override
  Future<bool> pause() {
    // TODO: implement pause
    throw UnimplementedError();
  }
}
