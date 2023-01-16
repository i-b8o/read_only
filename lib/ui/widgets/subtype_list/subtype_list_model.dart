import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/sub_type.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class SubtypesListViewModelService {
  Future<List<ReadOnlySubtype>> getAll(int id);
}

class SubtypeListViewModel extends ChangeNotifier {
  final SubtypesListViewModelService subtypesService;
  final int id;

  var _subtypes = <ReadOnlySubtype>[];
  List<ReadOnlySubtype> get subtypes => List.unmodifiable(_subtypes);

  SubtypeListViewModel({
    required this.subtypesService,
    required this.id,
  }) {
    asyncInit(id);
  }
  Future<void> asyncInit(int id) async {
    await getAll(id);
    notifyListeners();
  }

  Future<void> getAll(int id) async {
    _subtypes = await subtypesService.getAll(id);
  }

  void onTap(BuildContext context, int index) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.docListScreen,
      arguments: id,
    );
  }
}
