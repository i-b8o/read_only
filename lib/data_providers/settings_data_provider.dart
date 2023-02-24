import 'package:read_only/constants/constants.dart';
import 'package:read_only/domain/entity/app_settings.dart';
import 'package:read_only/domain/service/app_settings_service.dart';
import 'package:shared_preferences_storage/shared_preferences_storage.dart';

class SettingsDataProviderDefault implements AppSettingsServiceDataProvider {
  const SettingsDataProviderDefault();

  @override
  Future<void> setDarkMode(bool darkModeOn) async {
    try {
      await SharedPreferencesClient.write<bool>(
          key: Constants.darkModeKey, value: darkModeOn);
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> setSpeechRate(double speechRate) async {
    try {
      await SharedPreferencesClient.write<double>(
          key: Constants.speechRateKey, value: speechRate);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setPitch(double pitch) async {
    try {
      await SharedPreferencesClient.write<double>(
          key: Constants.pitchKey, value: pitch);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setVolume(double volume) async {
    try {
      await SharedPreferencesClient.write<double>(
          key: Constants.volumeKey, value: volume);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setFontWeight(double fontWeight) async {
    try {
      await SharedPreferencesClient.write<double>(
          key: Constants.fontWeightKey, value: fontWeight);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setFontSize(double fontSize) async {
    try {
      await SharedPreferencesClient.write<double>(
          key: Constants.fontSizeKey, value: fontSize);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setVoice(String voice) async {
    try {
      await SharedPreferencesClient.write<String>(
          key: Constants.voiceKey, value: voice);
    } catch (e) {
      rethrow;
    }
  }

  @override
  AppSettings getAppSettings() {
    try {
      return AppSettings(
        darkModeOn:
            SharedPreferencesClient.readBool(key: Constants.darkModeKey) ??
                Constants.darkModeDefaultValue,
        speechRate:
            SharedPreferencesClient.readDouble(key: Constants.speechRateKey) ??
                Constants.speechRateDefaultValue,
        pitch: SharedPreferencesClient.readDouble(key: Constants.pitchKey) ??
            Constants.pitchDefaultValue,
        volume: SharedPreferencesClient.readDouble(key: Constants.volumeKey) ??
            Constants.volumeDefaultValue,
        fontWeight:
            SharedPreferencesClient.readInt(key: Constants.fontWeightKey) ??
                Constants.fontWeightDefaultValue,
        fontSize:
            SharedPreferencesClient.readDouble(key: Constants.fontSizeKey) ??
                Constants.fontSizeDefaultValue,
        voice: SharedPreferencesClient.readString(key: Constants.voiceKey) ??
            Constants.voiceDefaultValue,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool getDarkMode() {
    return SharedPreferencesClient.readBool(key: Constants.darkModeKey) ??
        Constants.darkModeDefaultValue;
  }
}
