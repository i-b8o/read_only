import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _DefaultTypes { bool, int, double, string, list }

class SharedPreferencesClient {
  static late final SharedPreferences? instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static final Map<Type, Function> _writeMethods = <Type, Function>{
    bool: (String key, bool value) async {
      if (instance != null) {
        return await instance!.setBool(key, value);
      }
      return false;
    },
    int: (String key, int value) async {
      if (instance != null) {
        return await instance!.setInt(key, value);
      }
      return 0;
    },
    double: (String key, double value) async {
      if (instance != null) {
        return await instance!.setDouble(key, value);
      }
      return 0;
    },
    String: (String key, String value) async {
      if (instance != null) {
        return await instance!.setString(key, value);
      }
      return "";
    },
    List<String>: (String key, List<String> value) async {
      if (instance != null) {
        return await instance!.setStringList(key, value);
      }
      return [];
    },
  };

  static final Map<_DefaultTypes, Function> _readMethods =
      <_DefaultTypes, Function>{
    _DefaultTypes.bool: (String key) {
      if (instance == null) {
        return false;
      }
      return instance!.getBool(key);
    },
    _DefaultTypes.int: (String key) {
      if (instance == null) {
        return 0;
      }
      return instance!.getInt(key);
    },
    _DefaultTypes.double: (String key) {
      if (instance == null) {
        return 0;
      }
      return instance!.getDouble(key);
    },
    _DefaultTypes.string: (String key) {
      if (instance == null) {
        return "";
      }
      return instance!.getString(key);
    },
    _DefaultTypes.list: (String key) {
      if (instance == null) {
        return [];
      }
      return instance!.getStringList(key);
    },
  };

  SharedPreferencesClient();

  static Future<bool> delete({required String key}) async {
    try {
      if (instance == null) {
        return false;
      }
      final success = await instance!.remove(key);
      return success;
    } catch (exception, stackTrace) {
      throw PlatformException(
          code: 'remove_error',
          message: 'error for $key',
          details: exception.toString(),
          stacktrace: stackTrace.toString());
    }
  }

  static Future<void> write<T>({required String key, required T? value}) async {
    if (value == null) {
      return;
    }

    Type t = value.runtimeType;
    if (_writeMethods.containsKey(t)) {
      try {
        return await _writeMethods[t]!(key, value);
      } catch (exception) {
        rethrow;
      }
    }
    throw ArgumentError(
        'Only bool, int, double, String, List<String> are allowed');
  }

  static T? _read<T>({required String key, required _DefaultTypes t}) {
    try {
      return _readMethods[t]!(key);
    } catch (exception) {
      rethrow;
    }
  }

  static bool? readBool({required String key}) {
    return _read(key: key, t: _DefaultTypes.bool);
  }

  static double? readDouble({required String key}) {
    return _read(key: key, t: _DefaultTypes.double);
  }

  static int? readInt({required String key}) {
    return _read(key: key, t: _DefaultTypes.int);
  }

  static String? readString({required String key}) {
    return _read(key: key, t: _DefaultTypes.string);
  }

  static List<String>? readStringList({required String key}) {
    return _read(key: key, t: _DefaultTypes.list);
  }
}
