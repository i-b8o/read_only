import 'package:flutter/services.dart';
import 'package:read_only/library/text/text.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class TtsProvider {}

class TtsPosition {
  final int start;
  final int end;

  TtsPosition(this.start, this.end);


  TtsPosition.fromStream(List<int> data): start = data[0], end = data[1];

}

class TtsService implements ChapterViewModelTtsService {
  TtsService({required this.ttsChannel,required  this.ttsPositionChannel}){
    _positionEvent = ttsPositionChannel.receiveBroadcastStream().map((event) => TtsPosition.fromStream(event.cast<int>()));
  }
  final MethodChannel ttsChannel;
  final EventChannel ttsPositionChannel;
  late Stream<TtsPosition> _positionEvent;
  Stream<TtsPosition> positionEvent() => _positionEvent;
  bool _stoped = false;



  Future<bool> _speak(List<String> texts) async {
    _stoped = false;
   for (var i = 0; i < texts.length; i++) {
      final text = parseHtmlString(texts[i].trim());
      bool ok = await ttsChannel.invokeMethod("speak", text);
      if(_stoped){
        break;
      }
      if (!ok){
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
    return await ttsChannel.invokeMethod("resume");
    // if (!ok){
    //   return false;
    // }
    // return await _speak(texts);
  }

  @override
  Future<void> pauseSpeak() async {
    await ttsChannel.invokeMethod("pause");
  }


  @override
  Future<void> stopSpeak() async {
    _stoped = true;
    await ttsChannel.invokeMethod("stop");
  }
  @override
  Future<dynamic> getLanguages() async {
    final languages = await ttsChannel.invokeMethod('getLanguages');
    return languages;
  }

  Future<bool> highlighting() async{
    return await ttsChannel.invokeMethod("highlighting") as bool;
  }

  @override
  Future<List<String>?> getVoices() async {
    final voices = await ttsChannel.invokeMethod('getVoices') as List<dynamic>?;
    if (voices != null){
      return List<String>.from(voices);
    }
    return null;
  }

  @override
  Future<bool> setLanguage(String language) async {
    return await ttsChannel.invokeMethod('setLanguage', language) as bool;
  }

  Future<bool> setVoice(String voice) async =>
      await ttsChannel.invokeMethod('setVoice', voice) as bool;

  @override
  Future<bool> setVolume(double volume) async =>
      await ttsChannel.invokeMethod('setVolume', volume) as bool;

  Future<bool> setPitch(double pitch) async =>
      await ttsChannel.invokeMethod('setPitch', pitch) as bool;

  @override
  Future<bool> setSpeechRate(double rate) async =>
      await ttsChannel.invokeMethod('setSpeechRate', rate) as bool;

}
