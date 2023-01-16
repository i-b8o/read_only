import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

abstract class ChapterViewModelProvider {
  Future<GetOneChapterResponse> getOne(Int64 id);
}

class ChapterViewModel extends ChangeNotifier {
  final ChapterViewModelProvider chapterProvider;
  Int64 id;
  late int jumpTo;
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

  Future<bool> onTapUrl(String url) async {
    String chapterID = "";
    String? paragraphID;
    if (url.contains("#")) {
      chapterID = url.split("#")[0];
      paragraphID = url.split("#")[1];
    } else {
      chapterID = url;
    }

    id = Int64(int.tryParse(chapterID) ?? 0);
    await getOne(id);
    if (paragraphID != null && _chapter != null) {
      final Int64 paragraphIDInt = Int64(int.tryParse(paragraphID) ?? 0);
      ReaderParagraph jumpToParagraph = _chapter!.paragraphs
          .where((element) => element.iD == paragraphIDInt)
          .first;
      jumpTo = _chapter!.paragraphs.indexOf(jumpToParagraph);
    }
    return true;
  }
}
