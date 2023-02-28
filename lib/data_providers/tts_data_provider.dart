import 'dart:async';

import 'package:flutter/services.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/tts_position.dart';
import 'package:read_only/domain/service/tts_service.dart';

class TtsDataProviderState {
  bool _paused = false;
  String? _lastPart;
  void resume() => _paused = false;

  int _offset = 0;
  int get offset => _offset;
  void setOffset(int value) => _offset = value;
  void resetOffset() => _offset = 0;

  int _start = 0;
  int get start => _start;
  void setStart(int value) => _start = value;

  late List<String> textStack;
  String? textStackPop() {
    final text =
        (!_paused && textStack.isNotEmpty) ? textStack.removeAt(0) : null;
    if (text == null) {
      return null;
    }

    // _symbolsInPrevStringToSpeak = text.length;
    _lastPart = text;
    return text;
  }

  void pause() {
    if (_paused || _lastPart == null) return;
    _paused = true;
    textStack.insert(0, _lastPart!.substring(_start));

    _start = 0;
  }

  TtsDataProviderState({required String text}) {
    text = text.replaceAll(RegExp('(?<=[0-9]),(?=[0-9])'), 'запятая и');

    List<String> sentences = text.split(".");
    textStack = [];
    for (final sentence in sentences) {
      final parts = sentence.split(",");
      for (final part in parts) {
        if (part.isEmpty) continue;
        textStack.add(part);
      }
    }
  }
}

class TtsDataProviderDefault implements TtsDataProvider {
  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;
  late Stream<TtsPosition>? positionEvent;
  TtsDataProviderState? _state;

  TtsDataProviderDefault(this._methodChannel, this._eventChannel) {
    _startListening();
  }
  StreamSubscription<TtsPosition>? _subscription;
  void _startListening() {
    _subscription = _eventStream()!.listen((event) {});
  }

  @override
  Future<bool> highlighting() async {
    bool ok = await _methodChannel.invokeMethod("highlighting");
    return ok;
  }

  Future<bool> _speak() async {
    for (;;) {
      if (_state == null) {
        return false;
      }
      final text = _state!.textStackPop();
      if (text == null) {
        _state!.resetOffset();
        return true;
      }

      await _methodChannel.invokeMethod("speak", text);
      _state?.setOffset(text.length);
    }
  }

  @override
  Future<bool> speak(String text) async {
    if (text.isEmpty) {
      return true;
    }
    _state = TtsDataProviderState(text: text);
    return await _speak();
  }

  @override
  Future<bool> stop() async {
    _state = null;
    bool ok = await _methodChannel.invokeMethod("stop");
    return ok;
  }

  @override
  Future<bool> pause() async {
    if (_state == null) {
      return false;
    }
    _state!.pause();
    bool ok = await _methodChannel.invokeMethod("stop");
    return ok;
  }

  @override
  Future<bool> resume() async {
    if (_state == null) {
      return false;
    }
    _state!.resume();
    return await _speak();
  }

  Stream<TtsPosition>? _eventStream() {
    positionEvent = _eventChannel.receiveBroadcastStream().map((event) {
      if (_state == null) {
        return TtsPosition(0, 0);
      }
      final offset = _state!.offset;
      List<int> values = event.cast<int>();
      final int start = values[0];
      _state!.setStart(start);
      final int end = values[1];
      return TtsPosition(start + offset, end + offset);
    });

    return positionEvent;
  }

  @override
  Stream<TtsPosition>? positionStream() {}
}
