import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteClient {
  static Database? _database;
  static Database? get db => _database;

  SqfliteClient();

  Future<void> init(String databaseName,
      {required List<String> initSQL, int version = 1}) async {
    _database = await openDatabase(
      join(await getDatabasesPath(), '$databaseName.db'),
      onCreate: (_database, version) {
        for (final sqlQuery in initSQL) {
          _database.execute(sqlQuery);
        }
      },
      version: 1,
    );
  }

  static Future<void> insertListOrReplace(
      {required String table, required List<Map<String, dynamic>> rows}) async {
    if (_database == null) {
      return null;
    }
    return _database!.transaction((txn) async {
      for (final row in rows) {
        await txn.insert(table, row,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  static Future<void> insertListOrIgnore(
      {required String table, required List<Map<String, dynamic>> rows}) async {
    if (_database == null) {
      return null;
    }
    return _database!.transaction((txn) async {
      for (final row in rows) {
        await txn.insert(table, row,
            conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    });
  }

  static Future<int?> insertOrReplace(
      {required String table, required Map<String, dynamic> data}) async {
    if (_database == null) {
      return null;
    }
    return await _database!.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int?> insertOrIgnore(
      {required String table, required Map<String, dynamic> data}) async {
    if (_database == null) {
      return null;
    }
    return await _database!.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  static Future<List<Map<String, dynamic>>?> select(
      {required String table,
      required String where,
      required List<dynamic> whereArgs}) async {
    if (_database == null) {
      return null;
    }
    // Select all records from the table
    return await _database!.query(table, where: where);
  }

  static Future<int?> update(
      {required String table,
      required Map<String, dynamic> data,
      required String where,
      required List<dynamic> whereArgs}) async {
    if (_database == null) {
      return null;
    }
    // Update an existing record in the table
    return await _database!
        .update(table, data, where: where, whereArgs: whereArgs);
  }

  static Future<int> delete(String table,
      {required String where, required List<dynamic> whereArgs}) async {
    // Delete a record from the table
    return await _database!.delete(table, where: where, whereArgs: whereArgs);
  }

  static Future<void> printRecordCount(
      {required String tableName, required String tag}) async {
    if (_database == null) {
      print("$tag can not connect to the database");
      return;
    }
    int? count = Sqflite.firstIntValue(
        await _database!.rawQuery("SELECT COUNT(*) FROM $tableName"));
    if (count == null) {
      print("$tag could not get table:$tableName");
      return;
    }
    print('the $tableName table has $count records');
  }

  static Future<void> printAllRecordsFromTable(
      {required String tableName, required String tag}) async {
    if (_database == null) {
      print("$tag can not connect to the database");
      return;
    }
    final records = await _database!.query(tableName);
    if (records.isEmpty) {
      print("$tag => the $tableName table is empty");
    }
    for (final record in records) {
      print('$tag => $record');
    }
  }

  static Future<void> printRowsByColumnValue(
      {required String table,
      required String column,
      required dynamic value}) async {
    final records =
        await _database!.query(table, where: '$column = ?', whereArgs: [value]);
    if (records.isEmpty) {
      print("$column=$value => in table $table empty");
    }
    for (final record in records) {
      print('$value => $record');
    }
  }
}
