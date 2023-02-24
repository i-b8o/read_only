import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/type.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';

abstract class TypesListViewModelService {
  Future<List<Type>> getAll();
}

class TypeListViewModel extends ChangeNotifier {
  final TypesListViewModelService typesProvider;
  final NavigationDrawerViewModel drawerViewModel;
  var _types = <Type>[];
  List<Type> get types => List.unmodifiable(_types);

  TypeListViewModel(
      {required this.typesProvider, required this.drawerViewModel}) {
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
