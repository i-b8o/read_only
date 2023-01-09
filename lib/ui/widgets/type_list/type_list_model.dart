import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class TypesListViewModelProvider {
  Future<List<TypeResponse>> getAll();
}

class TypeListViewModel extends ChangeNotifier {
  final TypesListViewModelProvider typesProvider;
  var _types = <TypeResponse>[];
  List<TypeResponse> get types => List.unmodifiable(_types);

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

  void onTap(BuildContext context, Int64 id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.subtypeListScreen,
      arguments: id,
    );
  }
}
