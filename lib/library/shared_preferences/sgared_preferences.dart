import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesStorage {
  Future<String?> read({required String key});

  Future<void> write({required String key, required String? value});

  Future<void> delete({required String key});
}

class DefaultSharedPreferencesStorage implements SharedPreferencesStorage {
  static SharedPreferences? _preferences;

  DefaultSharedPreferencesStorage() {
    asyncInit();
  }
  Future asyncInit() async {
    try {
      _preferences = await SharedPreferences.getInstance();
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'init_error',
          message: exception.toString(),
          details: stackTrace.toString());
    }
  }

  @override
  Future<void> delete({required String key}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<T?> read({required String key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> write({required String key, required String? value}) {
    // TODO: implement write
    throw UnimplementedError();
  }
}
