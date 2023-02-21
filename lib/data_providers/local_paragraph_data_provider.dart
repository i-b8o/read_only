import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalParagraphDataProviderDefault
    implements ParagraphServiceLocalChapterDataProvider {
  LocalParagraphDataProviderDefault();

  @override
  Future<List<Paragraph>?> getParagraphs(int chapterID) async {
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
  }

  @override
  Future<void> saveParagraphs(List<Paragraph> paragraphs) {
    // TODO: implement saveParagraphs
    throw UnimplementedError();
  }
}
