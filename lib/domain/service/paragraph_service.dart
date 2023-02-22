import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:sqflite_client/sqflite_client.dart';

class ParagraphServiceDefaut implements ChapterViewModelParagraphService {
  @override
  Future<void> saveParagraph(int id, String content) async {
    try {
      await SqfliteClient.update(
        table: 'paragraph',
        data: {'content': content},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw DatabaseException("Failed to update paragraph: $e");
    }
  }
}
