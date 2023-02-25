import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';

abstract class DocListViewModelService {
  Future<List<Doc>> getDocs(int id);
}

class DocListViewModel extends ChangeNotifier {
  final DocListViewModelService docsService;

  final int id;
  var _docs = <Doc>[];
  List<Doc> get docs => List.unmodifiable(_docs);

  DocListViewModel({
    required this.docsService,
    required this.id,
  }) {
    asyncInit(id);
  }
  Future<void> asyncInit(int id) async {
    await getDocs(id);
    notifyListeners();
  }

  Future<void> getDocs(int id) async {
    _docs = await docsService.getDocs(id);
  }

  void onTap(BuildContext context, int id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.chapterListScreen,
      arguments: id,
    );
  }
}
