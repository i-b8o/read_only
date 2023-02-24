import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/service/app_settings_service.dart';

class AppViewModel extends ChangeNotifier {
  bool isDarkModeOn = false;
  AppViewModel(AppSettingsService appSettingsService) {
    appSettingsService.darkModestream.listen((value) {
      isDarkModeOn = value;
      L.info("gat message: $value");
      notifyListeners();
    });
  }
}
