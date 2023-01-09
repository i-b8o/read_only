import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class DocListViewModelProvider {
  Future<List<Doc>> getDocs(Int64 id);
}

class DocListViewModel extends ChangeNotifier {
  final DocListViewModelProvider docsProvider;
  final Int64 id;
  var _docs = <Doc>[];
  List<Doc> get docs => List.unmodifiable(_docs);

  DocListViewModel({
    required this.docsProvider,
    required this.id,
  }) {
    asyncInit(id);
  }
  Future<void> asyncInit(Int64 id) async {
    await getDocs(id);
    notifyListeners();
  }

  Future<void> getDocs(Int64 id) async {
    _docs = await docsProvider.getDocs(id);
  }

  void onTap(BuildContext context, Int64 id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.docListScreen,
      arguments: id,
    );
  }
}
