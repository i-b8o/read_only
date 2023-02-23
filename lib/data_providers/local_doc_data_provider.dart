import 'dart:math';
import 'dart:ui';

import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/doc.dart';

import 'package:read_only/domain/service/doc_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalDocDataProviderDefault
    with LocalDocDataProviderDB
    implements DocServiceLocalDocDataProvider {
  LocalDocDataProviderDefault();

  @override
  Future<void> saveDoc(Doc doc, int id) async {
    try {
      final currentTime = DateTime.now().toString();

      final data = doc.toMap();
      data['updated_at'] = currentTime;
      data['color'] = generateRandomColor();
      await SqfliteClient.insertOrReplace(table: 'doc', data: data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Doc?> getDoc(int id) async {
    try {
      await updateDocLastAccess(id);
      return await getDocById(id);
    } catch (e) {
      rethrow;
    }
  }
}

// handling data from a database
mixin LocalDocDataProviderDB {
  Future<void> updateDocLastAccess(int id) async {
    try {
      await SqfliteClient.update(
        table: "doc",
        data: {'last_access': DateTime.now().millisecondsSinceEpoch},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Doc?> getDocById(int id) async {
    const columns = ['id', 'name', 'color'];
    try {
      List<Map<String, dynamic>>? maps;
      try {
        maps = await SqfliteClient.select(
          table: 'doc',
          where: 'id = ?',
          whereArgs: [id],
        );
      } catch (e) {
        L.warning('Failed to select from the database: $e');
        return null;
      }

      if (maps != null && maps.isNotEmpty) {
        try {
          return Doc(
            id: id,
            color: maps.first['color'],
            name: maps.first['name'],
          );
        } catch (e) {
          rethrow;
        }
      }

      return null;
    } catch (e) {
      L.warning('Unhandled error: $e');
      return null;
    }
  }

  int generateRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    ).value;
  }
}
