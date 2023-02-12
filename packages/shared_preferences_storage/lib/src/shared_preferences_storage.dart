import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _DefaultTypes { bool, int, double, string, list }

class SharedPreferencesClient {
  static late final SharedPreferences instance;

  static Future<void> init() async =>
      instance = await SharedPreferences.getInstance();

  final Map<Type, Function> _writeMethods = <Type, Function>{
    bool: ((String key, bool value) async =>
        await instance.setBool(key, value)),
    int: ((String key, int value) async => await instance.setInt(key, value)),
    double: ((String key, double value) async =>
        await instance.setDouble(key, value)),
    String: ((String key, String value) async =>
        await instance.setString(key, value)),
    List<String>: ((String key, List<String> value) async =>
        await instance.setStringList(key, value)),
  };

  final Map<_DefaultTypes, Function> _readMethods = <_DefaultTypes, Function>{
    _DefaultTypes.bool: ((String key) => instance.getBool(key)),
    _DefaultTypes.int: ((String key) => instance.getInt(key)),
    _DefaultTypes.double: ((String key) => instance.getDouble(key)),
    _DefaultTypes.string: ((String key) => instance.getString(key)),
    _DefaultTypes.list: ((String key) => instance.getStringList(key)),
  };

  SharedPreferencesClient();

  // static Future getInstance() async {
  //   try {
  //     _preferences = await SharedPreferences.getInstance();
  //   } catch (exception, stackTrace) {
  //     throw PlatformException(
  //         code: 'init_error',
  //         details: exception.toString(),
  //         stacktrace: stackTrace.toString());
  //   }
  // }

  Future<bool> delete({required String key}) async {
    try {
      final success = await instance.remove(key);
      return success;
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'remove_error',
          message: 'error for $key',
          details: exception.toString(),
          stacktrace: stackTrace.toString());
    }
  }

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

  bool? readBool({required String key}) {
    return _read(key: key, t: _DefaultTypes.bool);
  }

  double? readDouble({required String key}) {
    return _read(key: key, t: _DefaultTypes.double);
  }

  int? readInt({required String key}) {
    return _read(key: key, t: _DefaultTypes.int);
  }

  String? readString({required String key}) {
    return _read(key: key, t: _DefaultTypes.string);
  }

  List<String>? readStringList({required String key}) {
    return _read(key: key, t: _DefaultTypes.list);
  }
}
