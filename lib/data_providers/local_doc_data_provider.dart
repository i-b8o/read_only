import 'package:read_only/domain/entity/chapter_info.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:sqflite/sqflite.dart';

class LocalDocDataProviderDefault implements LocalDocDataProvider {
  const LocalDocDataProviderDefault(this.db);
  final Database db;

  @override
  Future<void> saveOne(ReadOnlyDoc doc, int id) async {
    await _insertReadOnlyDoc(doc, id);
    return await _insertReadOnlyChapterInfos(doc.chapters);
  }

  Future<void> _insertReadOnlyDoc(ReadOnlyDoc doc, int id) async {
    await db.insert(
      'doc',
      {
        'id': id,
        'name': doc.name,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _insertReadOnlyChapterInfos(
      List<ReadOnlyChapterInfo> chapterInfos) async {
    Batch batch = db.batch();

    for (ReadOnlyChapterInfo chapterInfo in chapterInfos) {
      batch.insert(
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

    await batch.commit();
  }

  @override
  Future<ReadOnlyDoc?> getOne(int id) async {
    final chapters = await _getReadOnlyChaptersByDocId(id);
    if (chapters == null) {
      return null;
    }
    return await _getReadOnlyDocById(id, chapters);
  }

  Future<List<ReadOnlyChapterInfo>?> _getReadOnlyChaptersByDocId(
      int docID) async {
    final List<Map<String, dynamic>> maps = await db.query('chapter',
        columns: ['id', 'name', 'orderNum', 'num'],
        where: 'docID = ?',
        whereArgs: [docID]);

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return ReadOnlyChapterInfo(
          id: maps[i]['id'],
          name: maps[i]['name'],
          orderNum: maps[i]['orderNum'],
          num: maps[i]['num'],
        );
      });
    }
    return null;
  }

  Future<ReadOnlyDoc?> _getReadOnlyDocById(
      int id, List<ReadOnlyChapterInfo>? chapters) async {
    if (chapters == null) {
      return null;
    }
    final List<Map<String, dynamic>> maps = await db.query('doc',
        columns: ['id', 'name'], where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return ReadOnlyDoc(name: maps.first['name'], chapters: chapters);
    }
    return null;
  }

  @override
  Future<void> updateLastAccess(int id) async {
    try {
      // Update the last_access field in the doc table
      return await _updateLastAccess(id);
    } on Exception catch (e) {
      // Rethrow the exception if it occurs
      rethrow;
    }
  }

  Future<void> _updateLastAccess(int id) async {
    final now = DateTime.now().toIso8601String();
    await db.execute("UPDATE doc SET last_access = '$now' WHERE id = $id");
  }
}
