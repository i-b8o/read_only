import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/note.dart';
import 'package:read_only/domain/service/notes_service.dart';
import 'package:sqflite_client/sqflite_client.dart';

class LocalNotesDataProviderDefault
    with LocalNotesDataProviderDB
    implements NotesServiceLocalNotesDataProvider {
  @override
  Future<List<Note>?> getAll() async {
    return await getNotes();
  }
}

// handling data from a database
mixin LocalNotesDataProviderDB {
  Future<List<Note>?> getNotes() async {
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
          final text = paragraph.first['content'] as String;
          final chapterID = paragraph.first['chapterID'];
          final chapter = await SqfliteClient.select(
              table: 'chapter', where: 'id = ?', whereArgs: [chapterID]);
          if (chapter != null && chapter.isNotEmpty) {
            final docID = chapter.first['docID'];
            final doc = await SqfliteClient.select(
                table: 'doc', where: 'id = ?', whereArgs: [docID]);
            if (doc != null && doc.isNotEmpty) {
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
      L.warning('An error occured while fetching notes: $e');
    }
    return notes;
  }
}
