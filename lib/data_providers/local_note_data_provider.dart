import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/note.dart';
import 'package:read_only/domain/service/notes_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalNotesDataProviderDefault
    implements NotesServiceLocalNotesDataProvider {
  @override
  Future<List<Note>?> getAll() async {
    List<Note> notes = [];
    try {
      final noteParagraphs = await SqfliteClient.select(
        table: 'note',
      );
      if (noteParagraphs == null) {
        return null;
      }
      for (Map<String, dynamic> noteParagraph in noteParagraphs) {
        final paragraphID = noteParagraph['paragraphID'];
        final paragraph = await SqfliteClient.select(
            table: 'paragraph',
            where: 'paragraphID = ?',
            whereArgs: [paragraphID]);
        if (paragraph != null && paragraph.isNotEmpty) {
          L.info("1");
          final text = paragraph.first['content'] as String;
          final chapterID = paragraph.first['chapterID'];
          final chapter = await SqfliteClient.select(
              table: 'chapter', where: 'id = ?', whereArgs: [chapterID]);
          if (chapter != null && chapter.isNotEmpty) {
            L.info("2");
            final docID = chapter.first['docID'];
            final doc = await SqfliteClient.select(
                table: 'doc', where: 'id = ?', whereArgs: [docID]);
            if (doc != null && doc.isNotEmpty) {
              final name = doc.first['name'] as String;
              final color = doc.first['color'] as int;
              final url = '$chapterID#$paragraphID';
              L.info("$name -> $color");
              notes.add(Note(
                  docName: name,
                  docColor: color,
                  text: text,
                  chapterID: chapterID,
                  paragraphID: paragraphID));
            }
          }
        }
      }
      return notes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveNote(int paragraphID, chapterID) async {
    try {
      await SqfliteClient.insertOrReplace(
          table: 'note',
          data: {'paragraphID': paragraphID, 'chapterID': chapterID});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> dropNote(int paragraphID, chapterID) async {
    L.info("dropNote $paragraphID $chapterID");
    try {
      final i = await SqfliteClient.delete('note',
          where: 'paragraphID = ? AND chapterID = ?',
          whereArgs: [paragraphID, chapterID]);
      L.info("i = $i");
    } catch (e) {
      rethrow;
    }
  }
}
