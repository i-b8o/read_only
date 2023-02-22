import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalParagraphDataProviderDefault
    implements ParagraphServiceLocalChapterDataProvider {
  LocalParagraphDataProviderDefault();

  @override
  Future<List<Paragraph>?> getParagraphs(int chapterID) async {
    try {
      final paragraphs = await SqfliteClient.select(
          table: "paragraph", where: 'chapterID = ?', whereArgs: [chapterID]);
      if (paragraphs == null) {
        return null;
      }
      return paragraphs
          .map((p) => Paragraph(
                chapterID: p["chapterID"] as int,
                paragraphID: p["paragraphID"] as int,
                paragraphOrderNum: p["num"] as int,
                hasLinks: p["hasLinks"] == 1,
                isTable: p["isTable"] == 1,
                isNFT: p["isNFT"] == 1,
                paragraphclass: p["className"] as String,
                content: p["content"] as String,
              ))
          .toList();
    } catch (e) {
      print('An error occurred while getting paragraphs: $e');
      return null;
    }
  }

  @override
  Future<void> saveParagraphs(List<Paragraph> paragraphs) async {
    try {
      final List<Map<String, dynamic>> rows = paragraphs.map((p) {
        return {
          'paragraphID': p.paragraphID,
          'num': p.paragraphOrderNum,
          'hasLinks': p.hasLinks ? 1 : 0,
          'isTable': p.isTable ? 1 : 0,
          'isNFT': p.isNFT ? 1 : 0,
          'className': p.paragraphclass,
          'content': p.content,
          'chapterID': p.chapterID,
        };
      }).toList();

      await SqfliteClient.insertListOrReplace(table: 'paragraph', rows: rows);
    } catch (e) {
      // Handle the exception
      print('Error saving paragraphs: $e');
    }
  }
}
