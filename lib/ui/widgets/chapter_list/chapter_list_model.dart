import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/domain/entity/link.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';

abstract class ChapterListViewModelService {
  Future<Doc> getOne(int id);
}

class ChapterListViewModel extends ChangeNotifier {
  final ChapterListViewModelService docsProvider;
  final NavigationDrawerViewModel drawerViewModel;
  final int id;
  Doc? _doc;
  Doc? get doc => _doc;
  List<Chapter>? _chapters;
  List<Chapter> get chapters => _chapters ?? [];

  ChapterListViewModel(
      {required this.docsProvider,
      required this.id,
      required this.drawerViewModel}) {
    asyncInit(id);
  }

  Future<void> asyncInit(int id) async {
    await getOne(id);
    notifyListeners();
  }

  Future<void> getOne(int id) async {
    _doc = await docsProvider.getOne(id);
    if (_doc != null) {
      _chapters = _doc!.chapters;
    }
  }

  void onTap(BuildContext context, int id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.chapterScreen,
      arguments: Link(chapterID: id),
    );
  }
}
