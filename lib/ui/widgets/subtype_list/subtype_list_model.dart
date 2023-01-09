import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class SubtypesListViewModelProvider {
  Future<List<SubtypeResponse>> getAll(Int64 id);
}

class SubtypeListViewModel extends ChangeNotifier {
  final SubtypesListViewModelProvider subtypesProvider;
  final Int64 id;

  var _subtypes = <SubtypeResponse>[];
  List<SubtypeResponse> get subtypes => List.unmodifiable(_subtypes);

  SubtypeListViewModel({
    required this.subtypesProvider,
    required this.id,
  }) {
    asyncInit(id);
  }
  Future<void> asyncInit(Int64 id) async {
    await getAll(id);
    notifyListeners();
  }

  Future<void> getAll(Int64 id) async {
    _subtypes = await subtypesProvider.getAll(id);
  }

  void onTap(BuildContext context, Int64 index) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.docListScreen,
      arguments: id,
    );
  }
}
