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

  @override
  Future<bool> setRate(double value) async {
    bool ok = await _methodChannel.invokeMethod("setRate", value);
    return ok;
  }

  @override
  Future<bool> setPitch(double value) async {
    bool ok = await _methodChannel.invokeMethod("setPitch", value);
    return ok;
  }

  @override
  Future<List<String>?> getVoices() async {
    List<Object?>? result = await _methodChannel.invokeMethod("getVoices");
    if (result == null) return null;
    List<String> voices = result.map((e) => e.toString()).toList();
    return voices;
  }

  @override
  Future<bool> setVoice(String voice) async {
    return await _methodChannel.invokeMethod("setVoice", voice);
  }
}
