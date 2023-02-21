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
    await updateDocLastAccess(id);
    return await getDocById(id);
  }
}

// handling data from a database
mixin LocalDocDataProviderDB {
  Future<void> updateDocLastAccess(int id) async {
    await SqfliteClient.update(
      table: "doc",
      data: {'last_access': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Doc?> getDocById(int id) async {
    const columns = ['id', 'name', 'color'];
    try {
      final List<Map<String, dynamic>>? maps = await SqfliteClient.select(
          table: 'doc', where: 'id = ?', whereArgs: [id]);

      if (maps != null && maps.isNotEmpty) {
        return Doc(
          id: id,
          color: maps.first['color'],
          name: maps.first['name'],
        );
      }

      return null;
    } catch (e) {
      L.warning('$e');
      return null;
    }
  }
}
