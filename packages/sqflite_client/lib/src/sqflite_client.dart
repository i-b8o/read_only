import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteClient {
  SqfliteClient._();
  static final SqfliteClient _sqfliteClient = SqfliteClient._();
  static Database? _database;
  late String dbName;
  late List<String> sqlInit;

  factory SqfliteClient({required String name, required List<String> sql}) {
    _sqfliteClient.dbName = name;
    _sqfliteClient.sqlInit = sql;
    return _sqfliteClient;
  }

  Future<Database> database() async {
    if (_database != null) return _database!;

    // if _database is null we instantiate it
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) async {
        for (final sqlQuery in sqlInit) {
          await db.execute(sqlQuery);
        }
      },
    );
  }

  Future<int> insert(String tableName, Map<String, dynamic> json) async =>
      _database!.insert(tableName, json);

  Future<List<Map<String, dynamic>>> query(
    String tableName, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    return _database!.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> update(String tableName, Map<String, dynamic> json,
      {required String where, required List<dynamic> whereArgs}) async {
    return _database!.update(
      tableName,
      json,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // use: deleted = await db.delete(Place.tableName(),where: "name = ?", whereArgs: [name]);
  Future<int> delete(String tableName,
      {required String where, required List<dynamic> whereArgs}) async {
    return _database!.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }
}
