import 'package:flutter/services.dart';
import 'package:read_only/domain/entity/tts_position.dart';
import 'package:read_only/domain/service/tts_service.dart';

class TtsDataProviderDefault implements TtsDataProvider {
  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;
  late Stream<TtsPosition>? positionEvent;
  int _symbolsInPrevStringToSpeak = 0;

  TtsDataProviderDefault(this._methodChannel, this._eventChannel);


  @override
  Future<bool> highlighting() async {
    bool ok = await _methodChannel.invokeMethod("highlighting");
    return ok;
  }

  List<String> _prepairText(String text){
    List<String> listToSpeak = [];
    List<String> sentences = text.split(".");
    for(final sentence in sentences){
      final parts = sentence.split(",");
      for (final part in parts){
        listToSpeak.add(part);
      }
    }
    return listToSpeak;
  }

  @override
    Future<bool> speak(String text) async {
    _symbolsInPrevStringToSpeak = 0;
    if (text.isEmpty) {
      return true;
    }

    final listToSpeak = _prepairText(text);
      for (final stringToSpeak in listToSpeak){
        print('Speak $stringToSpeak - length: ${stringToSpeak.length}');
        final ok = await _methodChannel.invokeMethod("speak", stringToSpeak);
        if(!ok){
          return false;
        }
        print('ok: $ok');
        _symbolsInPrevStringToSpeak+=stringToSpeak.length;
      }
      return true;
  }

  @override
  Future<bool> stop() async {
    bool ok = await _methodChannel.invokeMethod("stop");
    return ok;
  }

  @override
  Stream<TtsPosition>? positionStream() {
    positionEvent = _eventChannel
        .receiveBroadcastStream()
        .map((event) {
          List<int> values = event.cast<int>();
          final start = values[0] + _symbolsInPrevStringToSpeak;
          final end = values[1] + _symbolsInPrevStringToSpeak;
          return TtsPosition(start, end);
    });
    return positionEvent;
  }
}
