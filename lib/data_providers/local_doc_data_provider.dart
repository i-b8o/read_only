import 'package:read_only/domain/entity/chapter_info.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalDocDataProviderDefault
    implements
        DocServiceLocalDocDataProvider,
        ChapterServiceLocalDocDataProvider {
  LocalDocDataProviderDefault();

  @override
  Future<void> saveOne(ReadOnlyDoc doc, int id) async {
    await _insertReadOnlyDoc(doc, id);

    await _insertReadOnlyChapterInfos(doc.chapters, id);
  }

  @override
  Future<ReadOnlyDoc?> getOne(int id) async {
    final chapters = await _getReadOnlyChaptersByDocId(id);
    if (chapters == null) {
      return null;
    }

    return await _getReadOnlyDocById(id, chapters);
  }

  @override
  Future<void> updateLastAccess(int chapterID) async {
    final docID = await _getDocIdByChapterId(chapterID);
    if (docID == null) {
      print(
          "There is no such doc with the id=$docID (the chapter id=$chapterID)");
      return;
    }
    return await _updateLastAccess(docID);
  }

  Future<List<ReadOnlyChapterInfo>?> _getReadOnlyChaptersByDocId(
      int docID) async {
    const columns = ['id', 'name', 'orderNum', 'num'];
    try {
      final db = SqfliteClient.db;
      if (db == null) {
        print("could not connect to a database");
        return null;
      }

      final List<Map<String, dynamic>> maps = await db.query('chapter',
          columns: columns, where: 'docID = ?', whereArgs: [docID]);

      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return ReadOnlyChapterInfo(
            id: maps[i][columns[0]],
            name: maps[i][columns[1]],
            orderNum: maps[i][columns[2]],
            num: maps[i][columns[3]],
          );
        });
      }
      print("_getReadOnlyChaptersByDocId empty");
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ReadOnlyDoc?> _getReadOnlyDocById(
      int id, List<ReadOnlyChapterInfo>? chapters) async {
    const columns = ['id', 'name'];

    try {
      if (chapters == null) {
        print("chapters == null");
        return null;
      }
      final db = SqfliteClient.db;
      if (db == null) {
        print("could not connect to a database");
        return null;
      }

      final List<Map<String, dynamic>> maps = await db
          .query('doc', columns: columns, where: 'id = ?', whereArgs: [id]);

      if (maps.isNotEmpty) {
        print(maps);
        return ReadOnlyDoc(name: maps.first['name'], chapters: chapters);
      }
      print("_getReadOnlyDocById empty");
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _updateLastAccess(int id) async {
    try {
      final db = SqfliteClient.db;
      if (db == null) {
        print("could not connect to a database");
        return null;
      }
      final now = DateTime.now().toIso8601String();
      await db.execute("UPDATE doc SET last_access = '$now' WHERE id = $id");
    } catch (e) {
      print(e);
    }
  }

  Future<void> _insertReadOnlyDoc(ReadOnlyDoc doc, int id) async {
    try {
      final db = SqfliteClient.db;
      if (db == null) {
        print("could not connect to a database");
        return null;
      }
      await db.insert(
        'doc',
        {
          'id': id,
          'name': doc.name,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _insertReadOnlyChapterInfos(
      List<ReadOnlyChapterInfo> chapterInfos, int docID) async {
    final db = SqfliteClient.db;
    if (db == null) {
      print("could not connect to a database");
      return;
    }
    await db.transaction((txn) async {
      for (ReadOnlyChapterInfo chapterInfo in chapterInfos) {
        await txn.insert(
          'chapter',
          {
            'id': chapterInfo.id,
            'name': chapterInfo.name,
            'orderNum': chapterInfo.orderNum,
            'num': chapterInfo.num,
            'docID': docID,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<int?> _getDocIdByChapterId(int chapterId) async {
    try {
      final db = SqfliteClient.db;
      if (db == null) {
        print("could not connect to a database");
        return null;
      }
      final List<Map<String, dynamic>> maps = await db.query(
        'chapter',
        columns: ['docID'],
        where: 'id = ?',
        whereArgs: [chapterId],
      );
      if (maps.isNotEmpty) {
        return maps.first['docID'];
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
