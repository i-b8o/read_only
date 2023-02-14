import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalDocDataProviderDefault
    with LocalDocDataProviderDB
    implements DocServiceLocalDocDataProvider {
  LocalDocDataProviderDefault();

  @override
  Future<void> saveDoc(Doc doc, int id) async {
    final data = {
      "id": id,
      'name': doc.name,
      'color': doc.color,
      'markToSave': 0,
      'last_access': DateTime.now().millisecondsSinceEpoch,
    };

    await insertDoc(data);
  }

  @override
  Future<Doc?> getDoc(int id) async {
    final chapters = await _getReadOnlyChaptersByDocId(id);
    if (chapters == null) {
      return null;
    }

    return await _getDocById(id, chapters);
  }
}

mixin LocalDocDataProviderDB {
  Future<void> insertDoc(data) async {
    await SqfliteClient.insertOrReplace(table: "doc", data: data);
  }

  Future<List<Chapter>?> _getReadOnlyChaptersByDocId(int docID) async {
    const columns = ['id', 'name', 'orderNum', 'num', 'docID'];
    try {
      final List<Map<String, dynamic>> maps = await db.query('chapter',
          columns: columns, where: 'docID = ?', whereArgs: [docID]);

      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return Chapter(
            id: maps[i][columns[0]],
            name: maps[i][columns[1]],
            orderNum: maps[i][columns[2]],
            num: maps[i][columns[3]],
            docID: maps[i][4],
          );
        });
      }
      MyLogger().getLogger().info("_getReadOnlyChaptersByDocId empty");
      return null;
    } catch (e) {
      MyLogger().getLogger().warning(e);
      return null;
    }
  }
}
  // Future<List<Chapter>?> _getReadOnlyChaptersByDocId(int docID) async {
  //   const columns = ['id', 'name', 'orderNum', 'num', 'docID'];
  //   try {
  //     final db = SqfliteClient.db;
  //     if (db == null) {
  //       MyLogger().getLogger().info("could not connect to a database");
  //       return null;
  //     }

  //     final List<Map<String, dynamic>> maps = await db.query('chapter',
  //         columns: columns, where: 'docID = ?', whereArgs: [docID]);

  //     if (maps.isNotEmpty) {
  //       return List.generate(maps.length, (i) {
  //         return Chapter(
  //           id: maps[i][columns[0]],
  //           name: maps[i][columns[1]],
  //           orderNum: maps[i][columns[2]],
  //           num: maps[i][columns[3]],
  //           docID: maps[i][4],
  //         );
  //       });
  //     }
  //     MyLogger().getLogger().info("_getReadOnlyChaptersByDocId empty");
  //     return null;
  //   } catch (e) {
  //     MyLogger().getLogger().warning(e);
  //     return null;
  //   }
  // }

  // Future<Doc?> _getDocById(int id, List<Chapter>? chapters) async {
  //   const columns = ['id', 'name', 'color'];

  //   try {
  //     if (chapters == null) {
  //       MyLogger().getLogger().info("chapters == null");
  //       return null;
  //     }
  //     final db = SqfliteClient.db;
  //     if (db == null) {
  //       MyLogger().getLogger().info("could not connect to a database");
  //       return null;
  //     }

  //     final List<Map<String, dynamic>> maps = await db
  //         .query('doc', columns: columns, where: 'id = ?', whereArgs: [id]);

  //     if (maps.isNotEmpty) {
  //       MyLogger().getLogger().info(maps);
  //       return Doc(
  //         id: id,
  //         color: maps.first['color'],
  //         name: maps.first['name'],
  //         chapters: chapters,
  //       );
  //     }
  //     MyLogger().getLogger().info("_getDocById empty");
  //     return null;
  //   } catch (e) {
  //     MyLogger().getLogger().warning(e);
  //     return null;
  //   }
  // }

  // Future<void> _insertDoc(Database db, Doc doc, int id) async {
  //   final data = {
  //     "id": id,
  //     'name': doc.name,
  //     'color': doc.color,
  //     'markToSave': 0,
  //     'last_access': DateTime.now().millisecondsSinceEpoch,
  //   };
  //   await db.insert('doc', data, conflictAlgorithm: ConflictAlgorithm.replace);
  // }


  // @override
  // Future<void> updateLastAccess(int chapterID) async {
  //   final docID = await _getDocIdByChapterId(chapterID);
  //   if (docID == null) {
  //     MyLogger().getLogger().info(
  //         "There is no such doc with the id=$docID (the chapter id=$chapterID)");
  //     return;
  //   }
  //   return await _updateLastAccess(docID);
  // }

  // Future<void> _updateLastAccess(int id) async {
  //   try {
  //     final db = SqfliteClient.db;
  //     if (db == null) {
  //       MyLogger().getLogger().info("could not connect to a database");
  //       return;
  //     }
  //     final now = DateTime.now().toIso8601String();
  //     await db.execute("UPDATE doc SET last_access = '$now' WHERE id = $id");
  //   } catch (e) {
  //     MyLogger().getLogger().warning(e);
  //   }
  // }

  // Future<List<int>?> _fetchDistinctColorsFromDocTable() async {
  //   final db = SqfliteClient.db;
  //   if (db == null) {
  //     MyLogger().getLogger().info("could not connect to a database");
  //     return null;
  //   }

  //   final List<Map<String, dynamic>> result = await db.rawQuery(
  //     'SELECT DISTINCT color FROM doc',
  //   );

  //   return result.map((row) => row['color'] as int).toList();
  // }

  // Future<int?> _getDocIdByChapterId(int chapterId) async {
  //   try {
  //     final db = SqfliteClient.db;
  //     if (db == null) {
  //       MyLogger().getLogger().info("could not connect to a database");
  //       return null;
  //     }
  //     final List<Map<String, dynamic>> maps = await db.query(
  //       'chapter',
  //       columns: ['docID'],
  //       where: 'id = ?',
  //       whereArgs: [chapterId],
  //     );
  //     if (maps.isNotEmpty) {
  //       return maps.first['docID'];
  //     }
  //     return null;
  //   } catch (e) {
  //     MyLogger().getLogger().warning(e);
  //     return null;
  //   }
  // }
