import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class ChapterListViewModelProvider {
  Future<GetOneDocResponse> getOne(Int64 id);
}

class ChapterListViewModel extends ChangeNotifier {
  final ChapterListViewModelProvider docsProvider;
  final Int64 id;
  GetOneDocResponse? _doc;
  GetOneDocResponse? get doc => _doc;

  ChapterListViewModel({
    required this.docsProvider,
    required this.id,
  }) {
    asyncInit(id);
  }
  Future<void> asyncInit(Int64 id) async {
    await getOne(id);
    notifyListeners();
  }

  Future<void> getOne(Int64 id) async {
    _doc = await docsProvider.getOne(id);
  }

  void onTap(BuildContext context, Int64 id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.docListScreen,
      arguments: id,
    );
  }
}
