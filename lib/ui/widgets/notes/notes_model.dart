import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/link.dart';
import 'package:read_only/domain/entity/note.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class NotesViewModelNotesService {
  Future<List<Note>?> getAll();
  Future<void> dropNote(int paragraphID, chapterID);
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

    notifyListeners();
  }

  void onTap(BuildContext context, int chapterID, paragraphID) {
    try {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.chapterScreen,
        arguments: Link(chapterID: chapterID, paragraphID: paragraphID),
      );
    } catch (e) {
      L.error('Error occurred while navigating to chapter screen: $e');
    }
  }

  Future<void> onDrop(int paragraphID, chapterID) async {
    try {
      await notesService.dropNote(paragraphID, chapterID);
      _notes!.removeWhere((note) =>
          note.paragraphID == paragraphID && note.chapterID == chapterID);
      notifyListeners();
    } catch (e) {
      L.error('Error occurred while droping: $e');
    }
  }
}
