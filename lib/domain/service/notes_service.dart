import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/note.dart';
import 'package:read_only/library/text/text.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:read_only/ui/widgets/notes/notes_model.dart';

abstract class NotesServiceLocalNotesDataProvider {
  const NotesServiceLocalNotesDataProvider();
  Future<List<Note>?> getAll();
  Future<void> saveNote(int paragraphID, chapterID);
  Future<void> dropNote(int paragraphID, chapterID);
}

class NotesService
    implements NotesViewModelNotesService, ChapterViewModelNoteService {
  final NotesServiceLocalNotesDataProvider notesProvider;

  NotesService(this.notesProvider);
  @override
  Future<List<Note>?> getAll() async {
    List<Note> notes = [];
    try {
      final resp = await notesProvider.getAll();
      if (resp == null) {
        return null;
      }

      for (final n in resp) {
        var note = Note(
            docName: n.docName,
            docColor: n.docColor,
            text: parseHtmlString(n.text),
            chapterID: n.chapterID,
            paragraphID: n.paragraphID);
        notes.add(note);
      }
      return notes;
    } catch (e) {
      L.error('Error retrieving notes: $e');
      return null;
    }
  }

  @override
  Future<void> saveNote(int paragraphID, chapterID) async {
    try {
      return await notesProvider.saveNote(paragraphID, chapterID);
    } catch (e) {
      L.error('Error saving note: $e');
    }
  }

  @override
  Future<void> dropNote(int paragraphID, chapterID) async {
    try {
      return await notesProvider.dropNote(paragraphID, chapterID);
    } catch (e) {
      L.error('Error saving note: $e');
    }
  }
}
