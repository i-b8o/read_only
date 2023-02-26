import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/constants/constants.dart';

import 'package:read_only/domain/entity/app_settings.dart';

abstract class AppSettingService {
  Future<void> setDarkMode(bool darkModeOn);
  Future<void> setFontSize(double fontSize);
  Future<void> setFontWeight(int fontWeight);
  AppSettings getAppSettings();
}

abstract class AppViewModelTtsSettingService {
  Future<bool> setVolume(double volume);
}

class AppViewModel extends ChangeNotifier {
  AppViewModel(
      {required this.appSettingsService, required this.ttsSettingService}) {
    _appSettings = appSettingsService.getAppSettings();
  }
  final AppSettingService appSettingsService;
  final AppViewModelTtsSettingService ttsSettingService;

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

  double mapFontSize(double value) {
    // min = 7px max=40px
    return value * 33.0 + 7.0;
  }

  // int convertRange(double value) {
  //   if (value < 0.0 || value > 1.0) {
  //     throw ArgumentError('Value must be between 0.0 and 1.0');
  //   }

  //   return (value / 1.25).floor();
  // }

  double integerToDouble(int value) {
    return value / 10.0;
  }
}
