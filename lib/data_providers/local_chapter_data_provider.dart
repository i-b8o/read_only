import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalChapterDataProviderDefault
    implements ChapterServiceLocalChapterDataProvider {
  LocalChapterDataProviderDefault();

  @override
  Future<ReadOnlyChapter?> getChapter(int id) async {
    final paragraphs = await _getParagraphsByChapterId(id);
    if (paragraphs == null) {
      return null;
    }
    return await _getChapterById(id, paragraphs);
  }

  Future<ReadOnlyChapter?> _getChapterById(
      int id, List<ReadOnlyParagraph> paragraphs) async {
    try {
      final db = SqfliteClient.db;
      if (db == null) {
        print("could not connect to a database");
        return null;
      }
      final List<Map<String, dynamic>> maps =
          await db.query('chapter', where: 'id = ?', whereArgs: [id]);

      if (maps.isNotEmpty) {
        Map<String, dynamic> map = maps.first;
        return ReadOnlyChapter(
            id: map['id'],
            name: map['name'],
            num: map['num'],
            orderNum: map['orderNum'],
            paragraphs: []);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<ReadOnlyParagraph>?> _getParagraphsByChapterId(
      int chapterId) async {
    try {
      final db = SqfliteClient.db;
      if (db == null) {
        print("could not connect to a database");
        return null;
      }
      final maps = await db
          .query('paragraph', where: 'chapterID = ?', whereArgs: [chapterId]);
      if (maps.isEmpty) {
        return null;
      }
      return maps
          .map((map) => ReadOnlyParagraph(
                id: map['id'] as int,
                num: map['num'] as int,
                hasLinks: map['hasLinks'] == 1,
                isTable: map['isTable'] == 1,
                isNFT: map['isNFT'] == 1,
                className: map['className'] as String,
                content: map['content'] as String,
                chapterID: chapterId,
              ))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
