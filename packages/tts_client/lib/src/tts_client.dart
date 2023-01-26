import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

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

  // isLanguageAvailable
  // isLanguageInstalled
}

class TtsClientDefault implements TtsClient {
  final FlutterTts _plugin;
  VoidCallback? completionHandler;
  TtsClientDefault({required FlutterTts plugin}) : _plugin = plugin;
  // _init();

  // _init() async {
  //   await _plugin.awaitSpeakCompletion(true);
  // }

  Future platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case "speak.onComplete":
        print("speak.onComplete");
        if (completionHandler != null) {
          completionHandler!();
        }
        break;

      default:
        print('Unknowm method ${call.method}');
    }
  }

  void setCompletionHandler(VoidCallback callback) {
    completionHandler = callback;
  }

  // Future getInstance() async {
  //   try {
  //     await _plugin.awaitSpeakCompletion(true);
  //   } catch (exception, stackTrace) {
  //     throw PlatformException(
  //         code: 'init_error',
  //         message: exception.toString(),
  //         details: stackTrace.toString());
  //   }
  // }

  double _cutOff(double value) {
    if (value < 0) {
      return 0;
    }
    if (value > 1) {
      return 1;
    }
    return value;
  }

  @override
  Future<bool> checkLanguage(String locale) async {
    assert(locale.isNotEmpty);
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
    try {
      List<String> result = [];
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
    assert(voiceName.isNotEmpty);
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
    assert(pitch >= 0 && pitch <= 1);
    pitch = _cutOff(pitch);
    try {
      // ranges from .5 to 2.0
      pitch = pitch * 1.5 + 0.5;
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
    assert(rate >= 0 && rate <= 1);
    rate = _cutOff(rate);
    try {
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
    assert(volume >= 0 && volume <= 1);
    volume = _cutOff(volume);
    try {
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
    assert(text.isNotEmpty);
    if (text.isEmpty) {
      return;
    }
    try {
      final completer = Completer<void>();
      await _plugin.speak(text);
      setCompletionHandler(() {
        completer.complete();
      });
      return completer.future;
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
