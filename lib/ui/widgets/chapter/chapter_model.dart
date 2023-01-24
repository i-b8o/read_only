import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class ChapterViewModelService {
  Future<ReadOnlyChapter> getOne(int id);
}

class ChapterViewModel extends ChangeNotifier {
  final ChapterViewModelService chapterProvider;

  final int chapterCount;
  final int id;
  final int paragraphID;
  final Map<int, int> chaptersOrderNums;

  final PageController pageController;
  final TextEditingController textEditingController;
  int _paragraphOrderNum = 0;
  int get paragraphOrderNum => _paragraphOrderNum;
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
    print("paragraphID: $paragraphID");
    _paragraphOrderNum = chapter!.paragraphs
        .where((element) => element.id.toInt() == paragraphID)
        .first
        .num;
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
