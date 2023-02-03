import 'package:read_only/domain/entity/tts_position.dart';
import 'package:read_only/library/text/text.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class TtsDataProvider {
  Future<bool> speak(String text);
  Future<bool> stop();
  Future<bool> highlighting();
  Stream<TtsPosition>? positionStream();
}

class TtsService implements ChapterViewModelTtsService {
  // TtsService({required this.ttsChannel, required this.ttsPositionChannel}) {
  //   _positionEvent = ttsPositionChannel
  //       .receiveBroadcastStream()
  //       .map((event) => TtsPosition.fromStream(event.cast<int>()));
  // }
  // final MethodChannel ttsChannel;
  // final EventChannel ttsPositionChannel;
  final TtsDataProvider ttsDataProvider;
  // final Stream<TtsPosition> _positionEvent;
  // @override
  // Stream<TtsPosition> positionEvent() => _positionEvent;

  bool _stoped = false;

  TtsService(this.ttsDataProvider);

  Future<bool> _speak(List<String> texts) async {
    print("But here ${texts.length} $texts");
    _stoped = false;
    for (var i = 0; i < texts.length; i++) {
      print("so here $i ${texts[i]}|");
      final text = parseHtmlString(texts[i].replaceAll("\n", " "));
      print("then$text|");
      final ok = await ttsDataProvider.speak(text);
      if (_stoped) {
        break;
      }
      if (!ok) {
        return false;
      }
    }
    return true;
  }

  @override
  Future<bool> startSpeak(List<String> texts) async {
    if (texts.isEmpty) {
      return false;
    }
    return await _speak(texts);
  }

  @override
  Future<bool> resumeSpeak() async {
    // return await ttsChannel.invokeMethod("resume");
    // if (!ok){
    //   return false;
    // }
    // return await _speak(texts);
    throw Exception();
  }

  @override
  Future<void> pauseSpeak() async {
    // await ttsChannel.invokeMethod("pause");
    throw Exception();
  }

  @override
  Future<bool> stopSpeak() async {
    // await ttsChannel.invokeMethod("stop");
    final ok = await ttsDataProvider.stop();
    if (!ok) {
      return false;
    }
    _stoped = true;
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

  @override
  Stream<TtsPosition>? positionEvent() {
    return ttsDataProvider.positionStream();
  }

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

  // @override
  // Future<bool> setVolume(double volume) async =>
  //     await ttsChannel.invokeMethod('setVolume', volume) as bool;

  // Future<bool> setPitch(double pitch) async =>
  //     await ttsChannel.invokeMethod('setPitch', pitch) as bool;

  // @override
  // Future<bool> setSpeechRate(double rate) async =>
  //     await ttsChannel.invokeMethod('setSpeechRate', rate) as bool;
}
