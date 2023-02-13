import 'package:read_only/domain/entity/note.dart';
import 'package:read_only/domain/service/notes_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalNotesDataProviderDefault
    implements NotesServiceLocalNotesDataProvider {
  @override
  Future<List<Note>?> getAll() async {
    return await _getNotes();
  }

  Future<List<Note>?> _getNotes() async {
    List<Note> notes = [];
    final db = SqfliteClient.db;
    if (db == null) {
      print("could not connect to a database");
      return null;
    }
    try {
      final noteParagraphs = await db.query('note');
      for (Map<String, dynamic> noteParagraph in noteParagraphs) {
        final paragraphID = noteParagraph['paragraphID'];
        final paragraph = await db.query('paragraph',
            where: 'paragraphID = ?', whereArgs: [paragraphID]);
        if (paragraph.isNotEmpty) {
          final text = paragraph.first['content'] as String;
          final chapterID = paragraph.first['chapterID'];
          final chapter = await db
              .query('chapter', where: 'id = ?', whereArgs: [chapterID]);
          if (chapter.isNotEmpty) {
            final docID = chapter.first['docID'];
            final doc =
                await db.query('doc', where: 'id = ?', whereArgs: [docID]);
            if (doc.isNotEmpty) {
              final name = doc.first['name'] as String;
              final color = doc.first['color'] as int;
              final url = '$chapterID#$paragraphID';
              notes.add(
                  Note(docName: name, docColor: color, text: text, url: url));
            }
          }
        }
      }
    } catch (e) {
      print('An error occured while fetching notes: $e');
    }
    return notes;
  }
}
