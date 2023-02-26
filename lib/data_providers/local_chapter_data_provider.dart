import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalChapterDataProviderDefault
    implements
        ChapterServiceLocalChapterDataProvider,
        DocServiceLocalChapterDataProvider {
  LocalChapterDataProviderDefault();

  @override
  Future<Chapter?> getChapter(int id) async {
    try {
      final List<Map<String, dynamic>>? chapters = await SqfliteClient.select(
          table: 'chapter', where: 'id = ?', whereArgs: [id]);

      if (chapters != null || chapters!.isNotEmpty) {
        Map<String, dynamic> chapter = chapters.first;

        return Chapter(
          id: chapter['id'],
          docID: chapter['docID'],
          name: chapter['name'],
          num: chapter['num'],
          orderNum: chapter['orderNum'],
        );
      }
      return null;
    } catch (e) {
      L.info("could not connect to a database: $e");
      return null;
    }
  }

  @override
  Future<void> saveChapters(List<Chapter> chapters) async {
    try {
      List<Map<String, dynamic>> mapList = [];
      for (var chapter in chapters) {
        mapList.add({
          'id': chapter.id,
          'name': chapter.name,
          'orderNum': chapter.orderNum,
          'num': chapter.num,
          'docID': chapter.docID,
        });
      }

      await SqfliteClient.insertListOrIgnore(table: 'chapter', rows: mapList);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveChapter(Chapter chapter) async {
    try {
      final data = chapter.toMap();
      await SqfliteClient.insertOrReplace(table: 'chapter', data: data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Chapter>?> getChaptersByDocId(int docID) async {
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
      return null;
    } catch (e) {
      return null;
    }
  }
}
