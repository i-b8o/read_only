import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

abstract class ChapterViewModelProvider {
  Future<GetOneChapterResponse> getOne(Int64 id);
}

class ChapterViewModel extends ChangeNotifier {
  final ChapterViewModelProvider chapterProvider;
  final Int64 id;
  final int chapterCount;
  final Map<int, Int64> chaptersOrderNums;
  final PageController pageController;
  final TextEditingController textEditingController;
  GetOneChapterResponse? _chapter;
  GetOneChapterResponse? get chapter => _chapter;

  ChapterViewModel({
    required this.chapterProvider,
    required this.id,
    required this.chapterCount,
    required this.chaptersOrderNums,
    required this.pageController,
    required this.textEditingController,
  }) {
    asyncInit(id);
  }
  Future<void> asyncInit(Int64 id) async {
    await getOne(id);
    notifyListeners();
  }

  Future<void> getOne(Int64 id) async {
    print("AAAAAAAAAA $id");
    _chapter = await chapterProvider.getOne(id);
  }

  // void onTap(BuildContext context, Int64 id) {
  //   Navigator.of(context).pushNamed(
  //     MainNavigationRouteNames.chapterListScreen,
  //     arguments: id,
  //   );
  // }
}
