import 'package:read_only/domain/entity/note.dart';
import 'package:read_only/ui/widgets/notes/notes_model.dart';

abstract class NotesServiceLocalNotesDataProvider {
  const NotesServiceLocalNotesDataProvider();
  Future<List<Note>?> getAll();
}

class NotesService implements NotesViewModelNotesService {
  final NotesServiceLocalNotesDataProvider notesProvider;

  NotesService(this.notesProvider);
  @override
  Future<List<Note>?> getAll() async {
    return await notesProvider.getAll();
  }
}
