import 'package:read_only/domain/service/chapter_service.dart';

abstract class TtsSettingsStorage {
  Future<void> write<T>({required String key, required T? value});
  double? readDouble({required String key});
}

class TtsSettingsDataProviderDefault implements TtsSettingsDataProvider {
  const TtsSettingsDataProviderDefault();

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
