import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/constants/constants.dart';

import 'package:read_only/domain/entity/app_settings.dart';
import 'package:read_only/domain/entity/speak_state.dart';

abstract class AppSettingService {
  Future<void> setDarkMode(bool darkModeOn);
  Future<void> setFontSize(double fontSize);
  Future<void> setFontWeight(int fontWeight);
  AppSettings getAppSettings();
}

abstract class DrawerViewModelTtsSettingService {
  Future<bool> setVolume(double volume);
  Future<bool> setRate(double volume);
  Future<bool> setPitch(double value);
  // Stream<TtsPosition>? positionEvent();
  Future<List<String>?> getVoices();
  Future<bool> setVoice(String voice);
  Future<bool> speakList(List<String> texts);
  Future<bool> stopSpeak();
}

class DrawerViewModel extends ChangeNotifier {
  DrawerViewModel({
    required this.appSettingsService,
    required this.ttsSettingService,
  }) {
    _appSettings = appSettingsService.getAppSettings();
  }
  final AppSettingService appSettingsService;
  final DrawerViewModelTtsSettingService ttsSettingService;

  SpeakState _speakState = SpeakState.silence;
  SpeakState get speakState => _speakState;
  void setSpeakState(SpeakState value) {
    if (_speakState == SpeakState.paused && value == SpeakState.silence) {
      return;
    }
    _speakState = value;
    notifyListeners();
  }

  bool isDarkModeOn = false;
  late AppSettings? _appSettings;
  AppSettings? get appSettings => _appSettings;

  double getFontSizeInPx() {
    if (_appSettings == null) {
      // 14px
      return 14.0;
    }
    return mapFontSize(_appSettings!.fontSize);
  }

  double getFontSizeInAbs() {
    if (_appSettings == null) {
      // 14px
      return 0.21;
    }
    return _appSettings!.fontSize;
  }

  int getFontWeight() {
    if (_appSettings == null) {
      // 14px
      return FontWeight.w400.index;
    }
    return _appSettings!.fontWeight;
  }

  double getFontWeightDouble() => integerToDouble(getFontWeight());

  Future<void> onDarkModeStateChanged() async {
    if (_appSettings == null) return;
    _appSettings =
        _appSettings!.copyWith(darkModeOn: !_appSettings!.darkModeOn);

    await appSettingsService.setDarkMode(_appSettings!.darkModeOn);
    notifyListeners();
  }

  void onFontSizeChanged(double value) {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(fontSize: value);
    notifyListeners();
  }

  Future<void> onFontSizeChangeEnd(double value) async {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(fontSize: value);

    await appSettingsService.setFontSize(value);
    notifyListeners();
  }

  Future<void> onFontWeightChangeEnd(int value) async {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(fontWeight: value);

    await appSettingsService.setFontWeight(value);

    notifyListeners();
  }

  Future<void> fontReset() async {
    var futures = [
      appSettingsService.setFontWeight(Constants.fontWeightDefaultValue),
      appSettingsService.setFontSize(Constants.fontSizeDefaultValue)
    ];
    await Future.wait(futures);
    _appSettings = _appSettings!.copyWith(
        fontWeight: Constants.fontWeightDefaultValue,
        fontSize: Constants.fontSizeDefaultValue);

    notifyListeners();
  }

  Future<void> onVolumeChangeEnd(double value) async {
    await ttsSettingService.setVolume(value);
    _appSettings = _appSettings!.copyWith(volume: value);
    notifyListeners();
  }

  Future<void> onVolumeChanged(double value) async {
    _appSettings = _appSettings!.copyWith(volume: value);
    notifyListeners();
  }

  Future<void> onRateChangeEnd(double value) async {
    await ttsSettingService.setRate(value);
    _appSettings = _appSettings!.copyWith(speechRate: value);
    notifyListeners();
  }

  Future<void> onRateChanged(double value) async {
    _appSettings = _appSettings!.copyWith(speechRate: value);
    notifyListeners();
  }

  Future<void> onPitchChangeEnd(double value) async {
    await ttsSettingService.setPitch(value);
    _appSettings = _appSettings!.copyWith(pitch: value);
    notifyListeners();
  }

  Future<void> onPitchChanged(double value) async {
    _appSettings = _appSettings!.copyWith(pitch: value);
    notifyListeners();
  }

  Future<void> onVoiceChanged(Object voice) async {
    final voiceStr = voice.toString();
    await ttsSettingService.setVoice(voiceStr);
    _appSettings = _appSettings!.copyWith(voice: voiceStr);
    notifyListeners();
  }

  Future<void> getVoices() async {
    final voices = await ttsSettingService.getVoices();
    _appSettings = _appSettings!.copyWith(voices: voices);

    notifyListeners();
  }

  double mapFontSize(double value) {
    // TODO in Constant: min = 7px max=40px
    return value * 33.0 + 7.0;
  }

  Future<void> startSpeak() async {
    try {
      setSpeakState(SpeakState.speaking);
      await ttsSettingService.speakList(Constants.anyText);
      setSpeakState(SpeakState.silence);
    } catch (e) {
      L.error('An error occurred while speaking any text: $e');
    }
  }

  Future<void> stopSpeak() async {
    try {
      await ttsSettingService.stopSpeak();
      setSpeakState(SpeakState.silence);
    } catch (e) {
      L.error('An error occurred while stop speaking the chapter: $e');
    }
  }

  double integerToDouble(int value) {
    return value / 10.0;
  }
}
