import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _DefaultTypes { bool, int, double, string, list }

abstract class SharedPreferencesStorage {
  Future getInstance();
  bool? readBool({required String key});
  int? readInt({required String key});
  double? readDouble({required String key});
  String? readString({required String key});
  List<String>? readStringList({required String key});
  Future<void> write<T>({required String key, required T? value});
  Future<bool> delete({required String key});
}

class DefaultSharedPreferencesStorage implements SharedPreferencesStorage {
  static SharedPreferences? _preferences;
  final Map<Type, Function> _writeMethods = <Type, Function>{
    bool: ((String key, bool value) async =>
        await _preferences!.setBool(key, value)),
    int: ((String key, int value) async =>
        await _preferences!.setInt(key, value)),
    double: ((String key, double value) async =>
        await _preferences!.setDouble(key, value)),
    String: ((String key, String value) async =>
        await _preferences!.setString(key, value)),
    List<String>: ((String key, List<String> value) async =>
        await _preferences!.setStringList(key, value)),
  };

  final Map<_DefaultTypes, Function> _readMethods = <_DefaultTypes, Function>{
    _DefaultTypes.bool: ((String key) => _preferences!.getBool(key)),
    _DefaultTypes.int: ((String key) => _preferences!.getInt(key)),
    _DefaultTypes.double: ((String key) => _preferences!.getDouble(key)),
    _DefaultTypes.string: ((String key) => _preferences!.getString(key)),
    _DefaultTypes.list: ((String key) => _preferences!.getStringList(key)),
  };

  DefaultSharedPreferencesStorage();

  Future getInstance() async {
    try {
      _preferences = await SharedPreferences.getInstance();
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'init_error',
          details: exception.toString(),
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<bool> delete({required String key}) async {
    try {
      final success = await _preferences!.remove(key);
      return success;
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'remove_error',
          message: 'error for $key',
          details: exception.toString(),
          stacktrace: stackTrace.toString());
    }
  }

  @override
  Future<void> write<T>({required String key, required T? value}) async {
    if (value == null) {
      return;
    }

    Type t = value.runtimeType;
    if (_writeMethods.containsKey(t)) {
      try {
        return await _writeMethods[t]!(value);
      } catch (exception, stackTrace) {
        throw PlatformException(
            code: 'write_error',
            message: 'error for key:$key and value:$value',
            details: exception.toString(),
            stacktrace: stackTrace.toString());
      }
    }
    throw ArgumentError(
        'Only bool, int, double, String, List<String> are allowed');
  }

  T? _read<T>({required String key, required _DefaultTypes t}) {
    try {
      return _readMethods[t]!(key);
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'read_error',
          message: 'error for $key',
          details: exception.toString(),
          stacktrace: stackTrace.toString());
    }
  }

  @override
  bool? readBool({required String key}) {
    return _read(key: key, t: _DefaultTypes.bool);
  }

  @override
  double? readDouble({required String key}) {
    return _read(key: key, t: _DefaultTypes.double);
  }

  @override
  int? readInt({required String key}) {
    return _read(key: key, t: _DefaultTypes.int);
  }

  @override
  String? readString({required String key}) {
    return _read(key: key, t: _DefaultTypes.string);
  }

  @override
  List<String>? readStringList({required String key}) {
    return _read(key: key, t: _DefaultTypes.list);
  }
}
