import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/app_settings.dart';

abstract class NavigationDrawerViewModelAppSettingsService {
  Future<void> setDarkMode(bool darkModeOn);
  Future<void> setFontSize(double fontSize);
  AppSettings getAppSettings();
}

class NavigationDrawerViewModel extends ChangeNotifier {
  NavigationDrawerViewModel(this.appSettingsService) {
    _appSettings = appSettingsService.getAppSettings();
  }

  final NavigationDrawerViewModelAppSettingsService appSettingsService;
  late AppSettings? _appSettings;
  AppSettings? get appSettings => _appSettings;

  Future<void> onDarkModeStateChanged() async {
    if (_appSettings == null) return;
    _appSettings =
        _appSettings!.copyWith(darkModeOn: !_appSettings!.darkModeOn);

    await appSettingsService.setDarkMode(_appSettings!.darkModeOn);
    notifyListeners();
  }

  void onFontSizeChanged(double value) {
    final fs = 40.0 * value;
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(fontSize: fs);
    notifyListeners();
  }

  Future<void> onFontSizeChangeEnd(double value) async {
    final fs = 40.0 * value;
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(fontSize: fs);

    await appSettingsService.setFontSize(fs);
    notifyListeners();
  }
}
