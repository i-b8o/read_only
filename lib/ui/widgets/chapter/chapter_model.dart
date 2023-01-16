import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import '../../navigation/main_navigation_route_names.dart';

abstract class ChapterViewModelProvider {
  Future<GetOneChapterResponse> getOne(int id);
}

class ChapterViewModel extends ChangeNotifier {
  final ChapterViewModelProvider chapterProvider;
  final String url;
  final int chapterCount;
  late int id;
  late int paragraphNum;
  final Map<int, int> chaptersOrderNums;
  final PageController pageController;
  final TextEditingController textEditingController;
  GetOneChapterResponse? _chapter;
  GetOneChapterResponse? get chapter => _chapter;
  int _currentPage = 0;
  int get currentPage => _currentPage;

  ChapterViewModel({
    required this.chapterProvider,
    required this.url,
    required this.chapterCount,
    required this.chaptersOrderNums,
    required this.pageController,
    required this.textEditingController,
  }) {
    pageController.addListener(() {
      _currentPage = pageController.page!.toInt();
    });
    if (url.contains("#")) {
      id = int.tryParse(url.split("#")[0]) ?? 0;
      paragraphNum = int.tryParse(url.split("#")[1]) ?? 0;
    } else {
      id = int.tryParse(url) ?? 0;
    }
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
    print(url);
    String chapterID = "";
    String? paragraphID;
    if (url.contains("#")) {
      chapterID = url.split("#")[0];
      paragraphID = url.split("#")[1];
    } else {
      chapterID = url;
    }

    // id = Int64(int.tryParse(chapterID) ?? 0);
    // await getOne(id);
    // if (paragraphID != null && _chapter != null) {
    //   final Int64 paragraphIDInt = Int64(int.tryParse(paragraphID) ?? 0);
    //   ReaderParagraph jumpToParagraph = _chapter!.paragraphs
    //       .where((element) => element.iD == paragraphIDInt)
    //       .first;
    //   jumpTo = _chapter!.paragraphs.indexOf(jumpToParagraph);
    // }
    // Navigator.of(context).pushNamed(
    //   MainNavigationRouteNames.chapterScreen,
    //   arguments: id,
    // );
    return true;
  }
}
