import 'package:read_only/domain/entity/chapter_info.dart';
import 'package:read_only/domain/entity/doc_paragraps.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalEntireDocDataProviderDefault {
  LocalEntireDocDataProviderDefault();

  Future<void> _insertParagraphs(List<DocParagraph> paragraphs) async {
    final db = SqfliteClient.db;
    if (db == null) {
      print("could not connect to a database");
      return null;
    }
    Batch batch = db.batch();
    for (var paragraph in paragraphs) {
      batch.insert('paragraph', {
        'num': paragraph.chapterNumber,
        'hasLinks': paragraph.hasLinks ? 1 : 0,
        'isTable': paragraph.isTable ? 1 : 0,
        'isNFT': paragraph.isNFT ? 1 : 0,
        'className': paragraph.paragraphclass,
        'content': paragraph.content,
        'chapterID': paragraph.chapterID,
      });
    }
    await batch.commit(noResult: true);
  }

  Future<void> _insertChapters(List<ReadOnlyChapterInfo> chapters) async {
    final db = SqfliteClient.db;
    if (db == null) {
      print("could not connect to a database");
      return null;
    }
    Batch batch = db.batch();
    for (var chapter in chapters) {
      batch.insert("ReadOnlyChapter", {
        "id": chapter.id,
        "name": chapter.name,
        "orderNum": chapter.orderNum,
        "num": chapter.num
      });
    }
    await batch.commit();
  }

  List<ReadOnlyChapterInfo> _mapParagraphsToChapters(
      List<DocParagraph> paragraphs) {
    Map<int, ReadOnlyChapterInfo> chapterMap = {};

    for (var paragraph in paragraphs) {
      if (chapterMap.containsKey(paragraph.chapterID)) {
        continue;
      }
      chapterMap[paragraph.chapterID] = ReadOnlyChapterInfo(
        id: paragraph.chapterID,
        name: paragraph.chapterName,
        orderNum: paragraph.chapterOrderNum,
        num: paragraph.chapterNumber,
      );
    }

    return chapterMap.values.toList();
  }

  Future<void> _deleteDoc(int id) async {
    final db = SqfliteClient.db;
    if (db == null) {
      print("could not connect to a database");
      return null;
    }
    // Begin a transaction
    await db.transaction((txn) async {
      // Delete the ReadOnlyDoc with id
      await txn.delete('ReadOnlyDoc', where: 'id = ?', whereArgs: [id]);

      final chapters = await txn.query('ReadOnlyChapter',
          columns: ['id'], where: 'doc_id = ?', whereArgs: [id]) as List<int>;

      // Delete all ReadOnlyChapter with doc_id equal to the id
      await txn.delete('ReadOnlyChapter', where: 'doc_id = ?', whereArgs: [id]);

      // Delete all ReadOnlyParagraph for every deleted chapter id
      final List<int>? chapterIds = await _getChapterIDsForDoc(id);
      if (chapterIds == null) {
        return;
      }

      await txn.delete('ReadOnlyParagraph',
          where: 'chapter_id in (${chapterIds.join(', ')})');
    });
  }

  Future<List<int>?> _getChapterIDsForDoc(int docID) async {
    final db = SqfliteClient.db;
    if (db == null) {
      print("could not connect to a database");
      return null;
    }
    List<Map<String, dynamic>> result = await db.query("chapter",
        columns: ["id"], where: "docID = ?", whereArgs: [docID]);

    return result.map((row) => row["id"]).toList() as List<int>;
  }
}
