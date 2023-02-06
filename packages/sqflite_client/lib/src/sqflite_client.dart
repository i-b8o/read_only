import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteClient {
  SqfliteClient._();
  static final SqfliteClient _sqfliteClient = SqfliteClient._();
  static Database? _database;

  factory SqfliteClient() {
    return _sqfliteClient;
  }

  Future<Database> database(String dbName, List<String> sqlInit) async {
    if (_database != null) return _database!;

    // if _database is null we instantiate it
    _database = await _initDB(dbName, sqlInit);
    return _database!;
  }

  Future<Database> _initDB(String dbName, List<String> initSQL) async {
    return await openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) async {
        for (final sqlQuery in initSQL) {
          await db.execute(sqlQuery);
        }
      },
    );
  }
}
