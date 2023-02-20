import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/note.dart';

abstract class NotesViewModelNotesService {
  Future<List<Note>?> getAll();
}

class NotesViewModel extends ChangeNotifier {
  final NotesViewModelNotesService notesService;
  List<Note>? _notes;
  List<Note>? get notes => _notes;
  NotesViewModel(this.notesService) {
    asyncInit();
  }
  Future<void> asyncInit() async {
    _notes = await notesService.getAll();
    // TODO drop

    // SqfliteClient.printAllRecordsFromTable(tableName: "doc", tag: "Doc");
    // SqfliteClient.printAllRecordsFromTable(
    //     tableName: "chapter", tag: "Chapter");
    // SqfliteClient.printRecordCount(tableName: "paragraph", tag: "Paragraph");
    // SqfliteClient.printAllRecordsFromTable(tableName: "note", tag: "Note");
  }
}
