import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/constants/constants.dart';

import 'package:read_only/domain/entity/app_settings.dart';
import 'package:read_only/domain/entity/tts_position.dart';

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
  Stream<TtsPosition>? positionEvent();
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
    if (ttsSettingService.positionEvent() != null) {
      ttsSettingService.positionEvent()!.listen((event) {});
    }
    final voices = ttsSettingService.getVoices();
    L.info("Voices $voices");
  }
  final AppSettingService appSettingsService;
  final DrawerViewModelTtsSettingService ttsSettingService;

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
    L.info("getFontSizeInAbs: ${_appSettings!.fontSize}");
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
    L.info("onFontWeightChangeEnd: $value");
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
    L.info("asd:${_appSettings!.fontWeight}");
    notifyListeners();
  }

  Future<void> onVolumeChangeEnd(double value) async {
    L.info("Valume change end with: $value");
    await ttsSettingService.setVolume(value);
    _appSettings = _appSettings!.copyWith(volume: value);
    notifyListeners();
  }

  Future<void> onVolumeChanged(double value) async {
    L.info("Valume changed with: $value");

    _appSettings = _appSettings!.copyWith(volume: value);
    notifyListeners();
  }

  Future<void> onRateChangeEnd(double value) async {
    L.info("Rate change end with: $value");
    await ttsSettingService.setRate(value);
    _appSettings = _appSettings!.copyWith(speechRate: value);
    notifyListeners();
  }

  Future<void> onRateChanged(double value) async {
    L.info("Rate changed with: $value");

    _appSettings = _appSettings!.copyWith(speechRate: value);
    notifyListeners();
  }

  Future<void> onPitchChangeEnd(double value) async {
    L.info("Pitch change end with: $value");
    await ttsSettingService.setPitch(value);
    _appSettings = _appSettings!.copyWith(pitch: value);
    notifyListeners();
  }

  Future<void> onPitchChanged(double value) async {
    L.info("Pitch changed with: $value");

    _appSettings = _appSettings!.copyWith(pitch: value);
    notifyListeners();
  }

  Future<void> onVoiceChanged(Object voice) async {
    L.info("voice changed with: $voice");
    final voiceStr = voice.toString();
    await ttsSettingService.setVoice(voiceStr);
    _appSettings = _appSettings!.copyWith(voice: voiceStr);
    notifyListeners();
  }

  Future<void> getVoices() async {
    final voices = await ttsSettingService.getVoices();
    _appSettings = _appSettings!.copyWith(voices: voices);
    L.info(voices);
    notifyListeners();
  }

  double mapFontSize(double value) {
    // TODO in Constant: min = 7px max=40px
    return value * 33.0 + 7.0;
  }

  Future<void> startSpeak() async {
    L.info("start speak ");
    try {
      await ttsSettingService.speakList(Constants.anyText);
    } catch (e) {
      L.error('An error occurred while speaking any text: $e');
    }
  }

  double integerToDouble(int value) {
    return value / 10.0;
  }
}
