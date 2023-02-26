import 'dart:async';

import 'package:my_logger/my_logger.dart';
import 'package:read_only/constants/constants.dart';
import 'package:read_only/domain/entity/app_settings.dart';

import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class AppSettingsServiceDataProvider {
  const AppSettingsServiceDataProvider();
  Future<void> setDarkMode(bool darkModeOn);
  bool getDarkMode();
  Future<void> setSpeechRate(double speechRate);
  Future<void> setPitch(double pitch);
  Future<void> setVolume(double volume);
  Future<void> setFontWeight(int fontWeight);
  Future<void> setFontSize(double fontSize);
  Future<void> setVoice(String voice);
  AppSettings getAppSettings();
  double getFontSize();
  int getFontWeight();
}

class AppSettingsServiceDefault
    implements AppSettingService, ChapterAppSettingService {
  AppSettingsServiceDefault(this.appSettingsdataProvider);
  final AppSettingsServiceDataProvider appSettingsdataProvider;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  Stream<bool> get darkModestream => _controller.stream;

  @override
  Future<void> setDarkMode(bool darkModeOn) async {
    try {
      _controller.add(darkModeOn);
      await appSettingsdataProvider.setDarkMode(darkModeOn);
    } catch (exception) {
      L.error('Error setting dark mode: $exception');
    }
  }

  @override
  Future<void> setSpeechRate(double speechRate) async {
    try {
      await appSettingsdataProvider.setSpeechRate(speechRate);
    } catch (exception) {
      L.error('Error setting speech rate: $exception');
    }
  }

  @override
  Future<void> setPitch(double pitch) async {
    try {
      await appSettingsdataProvider.setPitch(pitch);
    } catch (exception) {
      L.error('Error setting pitch: $exception');
    }
  }

  @override
  Future<void> setVolume(double volume) async {
    try {
      await appSettingsdataProvider.setVolume(volume);
    } catch (exception) {
      L.error('Error setting volume: $exception');
    }
  }

  @override
  Future<void> setFontWeight(int fontWeight) async {
    try {
      await appSettingsdataProvider.setFontWeight(fontWeight);
    } catch (exception) {
      L.error('Error setting font weight: $exception');
    }
  }

  @override
  Future<void> setFontSize(double fontSize) async {
    try {
      await appSettingsdataProvider.setFontSize(fontSize);
    } catch (exception) {
      L.error('Error setting font size: $exception');
    }
  }

  @override
  Future<void> setVoice(String voice) async {
    try {
      await appSettingsdataProvider.setVoice(voice);
    } catch (exception) {
      L.error('Error setting voice: $exception');
    }
  }

  @override
  AppSettings getAppSettings() {
    try {
      return appSettingsdataProvider.getAppSettings();
    } catch (exception) {
      L.error('Error getting app settings: $exception');
      return AppSettings(
        darkModeOn: Constants.darkModeDefaultValue,
        speechRate: Constants.speechRateDefaultValue,
        pitch: Constants.pitchDefaultValue,
        volume: Constants.volumeDefaultValue,
        fontWeight: Constants.fontWeightDefaultValue,
        fontSize: Constants.fontSizeDefaultValue,
        voice: Constants.voiceDefaultValue,
      );
    }
  }

  @override
  bool isDarkModeOn() {
    return appSettingsdataProvider.getDarkMode();
  }

  @override
  double getFontSizeInPx() {
    try {
      final value = appSettingsdataProvider.getFontSize();
      return value * 33.0 + 7.0;
    } catch (e) {
      L.error('Error getting font size: $e');
      return Constants.fontSizeDefaultValue;
    }
  }

  @override
  int getFontWeight() {
    try {
      return appSettingsdataProvider.getFontWeight();
    } catch (e) {
      L.error('Error getting font weight: $e');
      return Constants.fontWeightDefaultValue;
    }
  }
}
