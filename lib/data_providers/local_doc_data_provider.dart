import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalDocDataProviderDefault
    with LocalDocDataProviderDB
    implements DocServiceLocalDocDataProvider, ChapterServiceLocalDocDataProvider {
  LocalDocDataProviderDefault();

  @override
  Future<void> saveDoc(Doc doc, int id) async {
    final data = {
      "id": id,
      'name': doc.name,
      'color': doc.color,
      'last_access': DateTime.now().millisecondsSinceEpoch,
    };

    await insertDoc(data);
  }

  @override
  Future<Doc?> getDoc(int id) async {
    final futures = [
      // retrieve read-only chapters of a document
      getReadOnlyChaptersByDocId(id),
      // update the last access time of the document
      updateDocLastAccess(id),
    ];
    final results = await Future.wait(futures);
    final chapters = results[0] as List<Chapter>?;
    if (chapters == null) {
      return null;
    }

    return await getDocById(id, chapters);
  }

  Future<List<int>?> getAllChaptersIDs(int docID) async {
    return await getAllChaptersIDs(docID);
  }

  @override
  Future<bool> saved(int id) async {
    return await savedOrNot(id) ?? false;

  }
}

// handling data from a database
mixin LocalDocDataProviderDB {
  Future<bool?> savedOrNot(int id) async {
    final List<Map<String, dynamic>>? rows = await SqfliteClient.select(
      table: 'doc',
      columns: ['saved'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (rows != null && rows.isNotEmpty) {
       final res = rows.first['saved'] as int?;
       return res == null ? null : res == 1;
    }
    return null;

  }
  Future<List<int>?> getAllChaptersIDsByDocID(int id) async {
    return await SqfliteClient.select(
        table: 'chapter', where: 'docID = ?', whereArgs: [id]) as List<int>?;
  }

  Future<void> insertDoc(data) async {
    await SqfliteClient.insertOrReplace(table: "doc", data: data);
  }

  Future<void> updateDocLastAccess(int id) async {
    await SqfliteClient.update(
      table: "doc",
      data: {'last_access': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Doc?> getDocById(int id, List<Chapter>? chapters) async {
    const columns = ['id', 'name', 'color'];

    try {
      if (chapters == null) {
        L.info("chapters == null");
        return null;
      }

      final List<Map<String, dynamic>>? maps = await SqfliteClient.select(
          table: 'doc', where: 'id = ?', whereArgs: [id]);

      if (maps != null && maps.isNotEmpty) {
        L.info(maps.toString());
        return Doc(
          id: id,
          color: maps.first['color'],
          name: maps.first['name'],
          chapters: chapters,
        );
      }
      L.info("_getDocById empty");
      return null;
    } catch (e) {
      L.warning('$e');
      return null;
    }
  }

  Future<List<Chapter>?> getReadOnlyChaptersByDocId(int docID) async {
    const columns = ['id', 'name', 'orderNum', 'num', 'docID'];
    try {
      final List<Map<String, dynamic>>? maps = await SqfliteClient.select(
          table: 'chapter',
          columns: columns,
          where: 'docID = ?',
          whereArgs: [docID]);

      if (maps != null && maps.isNotEmpty) {
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
      L.info("_getReadOnlyChaptersByDocId empty");
      return null;
    } catch (e) {
      L.warning('$e');
      return null;
    }
  }
}
  // Future<List<Chapter>?> _getReadOnlyChaptersByDocId(int docID) async {
  //   const columns = ['id', 'name', 'orderNum', 'num', 'docID'];
  //   try {
  //     final db = SqfliteClient.db;
  //     if (db == null) {
  //       MyLogger.info("could not connect to a database");
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
  //     MyLogger.info("_getReadOnlyChaptersByDocId empty");
  //     return null;
  //   } catch (e) {
  //     MyLogger.info.warning(e);
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
  //     MyLogger.info(
  //         "There is no such doc with the id=$docID (the chapter id=$chapterID)");
  //     return;
  //   }
  //   return await _updateLastAccess(docID);
  // }

  // Future<void> _updateLastAccess(int id) async {
  //   try {
  //     final db = SqfliteClient.db;
  //     if (db == null) {
  //       MyLogger.info("could not connect to a database");
  //       return;
  //     }
  //     final now = DateTime.now().toIso8601String();
  //     await db.execute("UPDATE doc SET last_access = '$now' WHERE id = $id");
  //   } catch (e) {
  //     MyLogger.info.warning(e);
  //   }
  // }

  // Future<List<int>?> _fetchDistinctColorsFromDocTable() async {
  //   final db = SqfliteClient.db;
  //   if (db == null) {
  //     MyLogger.info("could not connect to a database");
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
  //       MyLogger.info("could not connect to a database");
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
  //     MyLogger.info.warning(e);
  //     return null;
  //   }
  // }
