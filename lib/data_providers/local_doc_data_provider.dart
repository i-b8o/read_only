import 'package:read_only/domain/entity/chapter_info.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:sqflite/sqflite.dart';

class LocalDocDataProviderDefault
    implements
        DocServiceLocalDocDataProvider,
        ChapterServiceLocalDocDataProvider {
  const LocalDocDataProviderDefault(this.db);
  final Database db;

  @override
  Future<void> saveOne(ReadOnlyDoc doc, int id) async {
    await _insertReadOnlyDoc(doc, id);

    await _insertReadOnlyChapterInfos(doc.chapters);
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
        return null;
      }
      final List<Map<String, dynamic>> maps = await db
          .query('doc', columns: columns, where: 'id = ?', whereArgs: [id]);

      if (maps.isNotEmpty) {
        return ReadOnlyDoc(name: maps.first['name'], chapters: chapters);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _updateLastAccess(int id) async {
    try {
      final now = DateTime.now().toIso8601String();
      await db.execute("UPDATE doc SET last_access = '$now' WHERE id = $id");
    } catch (e) {
      print(e);
    }
  }

  Future<void> _insertReadOnlyDoc(ReadOnlyDoc doc, int id) async {
    try {
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
      List<ReadOnlyChapterInfo> chapterInfos) async {
    await db.transaction((txn) async {
      for (ReadOnlyChapterInfo chapterInfo in chapterInfos) {
        await txn.insert(
          'chapter',
          {
            'id': chapterInfo.id,
            'name': chapterInfo.name,
            'orderNum': chapterInfo.orderNum,
            'num': chapterInfo.num,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<int?> _getDocIdByChapterId(int chapterId) async {
    try {
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
