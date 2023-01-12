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
  int _currentPage = 0;
  int get currentPage => _currentPage;

  ChapterViewModel({
    required this.chapterProvider,
    required this.id,
    required this.chapterCount,
    required this.chaptersOrderNums,
    required this.pageController,
    required this.textEditingController,
  }) {
    pageController.addListener(() {
      _currentPage = pageController.page!.toInt();
    });
    asyncInit(id);
  }

  Future<void> asyncInit(Int64 id) async {
    await getOne(id);
  }

  Future<void> getOne(Int64 id) async {
    _chapter = await chapterProvider.getOne(id);
    notifyListeners();
  }

  void onPageChanged() {
    final int index = pageController.page!.toInt();

    getOne(chaptersOrderNums[index + 1] ?? id);

    textEditingController.text = '${index + 1}';
  }
}
