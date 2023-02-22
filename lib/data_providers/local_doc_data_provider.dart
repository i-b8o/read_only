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
    final data = [id, doc.name, doc.color];
  }

  @override
  Future<Doc?> getDoc(int id) async {
    try {
      await updateDocLastAccess(id);
      return await getDocById(id);
    } catch (e) {
      print('Error getting document: $e');
      return null;
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
      print('Error updating document last access: $e');
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
          L.warning('Failed to create Doc object: $e');
          return null;
        }
      }

      return null;
    } catch (e) {
      L.warning('Unhandled error: $e');
      return null;
    }
  }
}
