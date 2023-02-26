import 'package:flutter/services.dart';
import 'package:read_only/domain/service/tts_service.dart';

class TtsSettingsDataProviderDefault implements TtsSettingsDataProvider {
  const TtsSettingsDataProviderDefault(this._methodChannel);
  final MethodChannel _methodChannel;
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

  @override
  Future<bool> setVolume(double value) async {
    bool ok = await _methodChannel.invokeMethod("setVolume", value);
    return ok;
  }
}
