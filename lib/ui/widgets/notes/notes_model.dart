import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/note.dart';
import 'package:sqflite_client/sqflite_client.dart';

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
    SqfliteClient.printAllRecordsFromTable("doc", "Doc");
    SqfliteClient.printRecordCount("chapter", "Chapter");
    SqfliteClient.printRecordCount("paragraph", "Paragraph");
    SqfliteClient.printAllRecordsFromTable("note", "Note");
  }
}
