import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class ChapterViewModelProvider {
  Future<ReadOnlyChapter> getOne(int id);
}

class ChapterViewModel extends ChangeNotifier {
  final ChapterViewModelProvider chapterProvider;

  final int chapterCount;
  final int id;
  final int paragraphOrderNum;
  final Map<int, int> chaptersOrderNums;
  final PageController pageController;
  final TextEditingController textEditingController;
  ReadOnlyChapter? _chapter;
  ReadOnlyChapter? get chapter => _chapter;
  int _currentPage = 0;
  int get currentPage => _currentPage;

  ChapterViewModel({
    required this.chapterProvider,
    required this.id,
    required this.paragraphOrderNum,
    required this.chapterCount,
    required this.chaptersOrderNums,
    required this.pageController,
    required this.textEditingController,
  }) {
    pageController.addListener(() {
      _currentPage = pageController.page!.toInt();
    });
    // if (url.contains("#")) {
    //   id = int.tryParse(url.split("#")[0]) ?? 0;
    //   paragraphNum = int.tryParse(url.split("#")[1]) ?? 0;
    // } else {
    //   id = int.tryParse(url) ?? 0;
    // }
    asyncInit(id);
  }

  Future<void> asyncInit(int id) async {
    await getOne(id);
  }

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
