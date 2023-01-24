import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class ChapterListViewModelService {
  Future<ReadOnlyDoc> getOne(int id);
}

class ChapterListViewModel extends ChangeNotifier {
  final ChapterListViewModelService docsProvider;
  final int id;
  ReadOnlyDoc? _doc;
  ReadOnlyDoc? get doc => _doc;

  ChapterListViewModel({
    required this.docsProvider,
    required this.id,
  }) {
    asyncInit(id);
  }
  Future<void> asyncInit(int id) async {
    await getOne(id);
    notifyListeners();
  }

  Future<void> getOne(int id) async {
    _doc = await docsProvider.getOne(id);
  }

  void onTap(BuildContext context, int id) {
    final String idStr = id.toString();
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.chapterScreen,
      arguments: idStr,
    );
  }
}
