import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalChapterDataProviderDefault
    with LocalChapterDataProviderDB
    implements
        ChapterServiceLocalChapterDataProvider,
        DocServiceLocalChapterDataProvider {
  LocalChapterDataProviderDefault();

  @override
  Future<Chapter?> getChapter(int id) async {
    final paragraphs = await getParagraphsByChapterId(id);
    if (paragraphs == null) {
      return null;
    }
    return await getChapterById(id, paragraphs);
  }

  @override
  Future<void> saveChapters(List<Chapter> chapters) async {
    List<Map<String, dynamic>> mapList = [];
    chapters.forEach((chapter) {
      mapList.add({
        'id': chapter.id,
        'name': chapter.name,
        'orderNum': chapter.orderNum,
        'num': chapter.num,
        'docID': chapter.docID,
      });
    });

    await insertChapters(mapList);
  }
}

mixin LocalChapterDataProviderDB {
  Future<List<Paragraph>?> getParagraphsByChapterId(int chapterId) async {
    try {
      final maps = await SqfliteClient.select(
          table: 'paragraph', where: 'chapterID = ?', whereArgs: [chapterId]);
      if (maps == null) {
        return null;
      }
      if (maps.isEmpty) {
        return [];
      }
      return maps
          .map((map) => Paragraph(
                paragraphID: map['id'] as int,
                paragraphOrderNum: map['num'] as int,
                hasLinks: map['hasLinks'] == 1,
                isTable: map['isTable'] == 1,
                isNFT: map['isNFT'] == 1,
                paragraphclass: map['className'] as String,
                content: map['content'] as String,
                chapterID: chapterId,
              ))
          .toList();
    } catch (e) {
      MyLogger().logError(
          "could not get paragraphs for the chapter with id:$chapterId: $e");
      return null;
    }
  }

  Future<Chapter?> getChapterById(int id, List<Paragraph> paragraphs) async {
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
            paragraphs: paragraphs);
      }
      return null;
    } catch (e) {
      MyLogger().logError("could not connect to a database: $e");
      return null;
    }
  }

  Future<void> insertChapters(List<Map<String, dynamic>> mapList) async {
    return await SqfliteClient.insertListOrIgnore(
        table: 'chapter', rows: mapList);
  }
}
