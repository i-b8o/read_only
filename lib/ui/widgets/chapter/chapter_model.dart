import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class ChapterViewModelProvider {
  Future<GetOneChapterResponse> getOne(Int64 id);
}

class ChapterViewModel extends ChangeNotifier {
  final ChapterViewModelProvider chapterProvider;
  final Int64 id;
  GetOneChapterResponse? _chapter;
  GetOneChapterResponse? get chapter => _chapter;

  ChapterViewModel({
    required this.chapterProvider,
    required this.id,
  }) {
    asyncInit(id);
  }
  Future<void> asyncInit(Int64 id) async {
    await getOne(id);
    print("Got name: ${_chapter?.name}");
    notifyListeners();
  }

  Future<void> getOne(Int64 id) async {
    _chapter = await chapterProvider.getOne(id);
  }

  void onTap(BuildContext context, Int64 id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.chapterListScreen,
      arguments: id,
    );
  }
}
