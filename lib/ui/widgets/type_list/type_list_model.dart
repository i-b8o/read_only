import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/type.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class TypesListViewModelService {
  Future<List<ReadOnlyType>> getAll();
}

class TypeListViewModel extends ChangeNotifier {
  final TypesListViewModelService typesProvider;
  var _types = <ReadOnlyType>[];
  List<ReadOnlyType> get types => List.unmodifiable(_types);

  TypeListViewModel({
    required this.typesProvider,
  }) {
    asyncInit();
  }
  Future<void> asyncInit() async {
    await getAll();
    notifyListeners();
  }

  Future<void> getAll() async {
    _types = await typesProvider.getAll();
  }

  void onTap(BuildContext context, int id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.subtypeListScreen,
      arguments: id,
    );
  }
}
