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

  static Future<void> printRecordCount(String tableName, tag) async {
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

  static Future<void> printAllRecordsFromTable(String tableName, tag) async {
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
