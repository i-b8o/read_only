import 'package:my_logger/my_logger.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:sqflite_client/sqflite_client.dart';

class ParagraphServiceDefault implements ChapterViewModelParagraphService {
  @override
  Future<void> saveParagraph(int paragraphID, chapterID, String content) async {
    try {
      final i = await SqfliteClient.update(
        table: 'paragraph',
        data: {'content': content},
        where: 'paragraphID = ? AND chapterID = ?',
        whereArgs: [paragraphID, chapterID],
      );
    } catch (e) {
      L.error("Failed to update paragraph: $e");
    }
  }
}
