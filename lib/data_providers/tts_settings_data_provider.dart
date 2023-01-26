import 'package:read_only/domain/service/chapter_service.dart';
import 'package:shared_preferences_storage/shared_preferences_storage.dart';

class TtsSettingsDataProviderDefault implements TtsSettingsDataProvider {
  const TtsSettingsDataProviderDefault(this.storage);
  final SharedPreferencesStorage storage;

  @override
  Future<void> saveVoice(String value) {
    // TODO: implement saveVoice
    throw UnimplementedError();
  }

  @override
  Future<void> saveVolume(double value) {
    // TODO: implement saveVolume
    throw UnimplementedError();
  }

  @override
  Future<String?> readCurrentLanguage() {
    // TODO: implement saveVolume
    throw UnimplementedError();
  }
}
