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

  static Future<void> deleteDatabaseWithName(String name) async {
    final path = await getDatabasesPath();
    final databasePath = '$path/$name.db';
    await deleteDatabase(databasePath);
  }

  static Future<void> insertListOrReplace(
      {required String table, required List<Map<String, dynamic>> rows}) async {
    if (_database == null) {
      throw Exception('Database is not open');
    }
    try {
      await _database!.transaction((txn) async {
        for (final row in rows) {
          await txn.insert(table, row,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      });
    } catch (e) {
      throw Exception('Insert failed: $e');
    }
  }

  static Future<void> insertListOrIgnore(
      {required String table, required List<Map<String, dynamic>> rows}) async {
    if (_database == null) {
      throw Exception('Database is not open');
    }
    try {
      await _database!.transaction((txn) async {
        for (final row in rows) {
          await txn.insert(table, row,
              conflictAlgorithm: ConflictAlgorithm.ignore);
        }
      });
    } catch (e) {
      throw Exception('Insert failed: $e');
    }
  }

  static Future<int?> insertOrReplace(
      {required String table, required Map<String, dynamic> data}) async {
    if (_database == null) {
      throw Exception('Database is not open');
    }
    try {
      final int id = await _database!.insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id;
    } catch (e) {
      throw Exception('Insert failed: $e');
    }
  }

  static Future<int> insertOrIgnore(
      {required String table, required Map<String, dynamic> data}) async {
    if (_database == null) {
      throw Exception("Database is not open");
    }
    try {
      return await _database!.insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (e) {
      throw Exception("Failed to insert data into table $table: $e");
    }
  }

  static Future<List<Map<String, dynamic>>?> select({
    required String table,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      if (_database == null) {
        throw Exception("Database is null");
      }
      return await _database!
          .query(table, columns: columns, where: where, whereArgs: whereArgs);
    } catch (e) {
      throw Exception("Could not execute select query: $e");
    }
  }

  static Future<int> update({
    required String table,
    required Map<String, dynamic> data,
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    try {
      if (_database == null) {
        throw Exception("Database not initialized.");
      }

      final result = await _database!
          .update(table, data, where: where, whereArgs: whereArgs);

      return result;
    } catch (e) {
      throw Exception("Failed to update $table table: $e");
    }
  }

  static Future<int> delete(String table,
      {required String where, required List<dynamic> whereArgs}) async {
    try {
      if (_database == null) {
        throw Exception("Database not initialized.");
      }
      return await _database!.delete(table, where: where, whereArgs: whereArgs);
    } catch (e) {
      throw Exception('Failed to delete record from table: $table');
    }
  }

  static Future<void> printRecordCount(
      {required String tableName, required String tag}) async {
    try {
      if (_database == null) {
        throw Exception("$tag can not connect to the database");
      }
      int? count = Sqflite.firstIntValue(
          await _database!.rawQuery("SELECT COUNT(*) FROM $tableName"));
      if (count == null) {
        throw Exception("$tag could not get table:$tableName");
      }
      print('the $tableName table has $count records');
    } catch (e) {
      throw Exception("Error in $tag: $e");
    }
  }

  static Future<void> printAllRecordsFromTable(
      {required String tableName, required String tag}) async {
    try {
      if (_database == null) {
        throw Exception("$tag can not connect to the database");
      }
      final records = await _database!.query(tableName);
      if (records.isEmpty) {
        print("$tag => the $tableName table is empty");
        return;
      }
      for (final record in records) {
        print('$tag => $record');
      }
    } catch (e) {
      throw Exception(
          "$tag => an error occurred while trying to print records from the $tableName table: $e");
    }
  }

  static Future<void> printRowsByColumnValue({
    required String table,
    required String column,
    required dynamic value,
  }) async {
    try {
      final records = await _database!
          .query(table, where: '$column = ?', whereArgs: [value]);
      if (records.isEmpty) {
        print("$column=$value => in table $table empty");
      } else {
        for (final record in records) {
          print('$value => $record');
        }
      }
    } catch (e) {
      throw Exception('Failed to print rows by column value: $e');
    }
  }
}
