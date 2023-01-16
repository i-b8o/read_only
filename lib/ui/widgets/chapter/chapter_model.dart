import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

abstract class ChapterViewModelProvider {
  Future<ReadOnlyChapter> getOne(int id);
}

class ChapterViewModel extends ChangeNotifier {
  final ChapterViewModelProvider chapterProvider;

  final int chapterCount;
  final int id;
  final int paragraphID;
  final Map<int, int> chaptersOrderNums;
  final ItemScrollController itemScrollController;
  final PageController pageController;
  final TextEditingController textEditingController;
  late int _paragraphOrderNum = 0;
  ReadOnlyChapter? _chapter;
  ReadOnlyChapter? get chapter => _chapter;
  int _currentPage = 0;
  int get currentPage => _currentPage;

  ChapterViewModel({
    required this.chapterProvider,
    required this.id,
    required this.paragraphID,
    required this.chapterCount,
    required this.chaptersOrderNums,
    required this.itemScrollController,
    required this.pageController,
    required this.textEditingController,
  }) {
    pageController.addListener(() {
      _currentPage = pageController.page!.toInt();
    });
    asyncInit(id);
  }

  Future<void> asyncInit(int id) async {
    print("asyncInit");
    await getOne(id);
    print("got");
    if (paragraphID == 0) {
      print("zero");
      return;
    }
    if (chapter == null) {
      print("chapter null");
      return;
    }
    _paragraphOrderNum = chapter!.paragraphs
        .where((element) => element.id.toInt() == paragraphID)
        .first
        .num;
    print("paragraph order num: $_paragraphOrderNum");
    WidgetsBinding.instance
        .addPostFrameCallback((_) => jumpTo(_paragraphOrderNum - 1));

    // jumpTo(_paragraphOrderNum);
  }

  void jumpTo(int index) {
    if (!itemScrollController.isAttached) {
      return;
    }
    itemScrollController.jumpTo(
      index: index,
    );
  }

  // void scrollToItem() {
  //   if (_paragraphOrderNum < 1) {
  //     return;
  //   }
  //   if (!itemScrollController.isAttached) {
  //     return;
  //   }
  //   itemScrollController.jumpTo(index: _paragraphOrderNum);
  // }

  Future<void> getOne(int id) async {
    _chapter = await chapterProvider.getOne(id);
    notifyListeners();
  }

  void onPageChanged() {
    final int index = pageController.page!.toInt();

    getOne(chaptersOrderNums[index + 1] ?? id);

    textEditingController.text = '${index + 1}';
  }

  Future<bool> onTapUrl(BuildContext context, String url) async {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.chapterScreen,
      arguments: url,
    );
    return true;
  }
}
