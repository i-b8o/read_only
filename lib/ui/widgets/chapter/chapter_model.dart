import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/entity/tts_position.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class ChapterViewModelService {
  Future<Chapter?> getOne(int id);
}

abstract class ChapterViewModelDocService {
  int totalChapters();
  Map<int, int> orderNumToChapterIdMap();
}

abstract class ChapterViewModelTtsService {
  Future<bool> speakList(List<String> texts);
  Future<bool> speakOne(String text);
  Future<bool> stopSpeak();
  Future<void> pauseSpeak();
  Future<bool> resumeSpeak();
  Stream<TtsPosition>? positionEvent();
}

enum SpeakState { silence, speaking, paused }

class ChapterViewModel extends ChangeNotifier {
  final ChapterViewModelService chapterService;
  final ChapterViewModelTtsService ttsService;
  final ChapterViewModelDocService docService;
  final PageController pageController;
  final TextEditingController textEditingController;
  final String url;

  late final Map<int, int> chapterIdOrderNumMap;

  late final int chapterCount;
  int paragraphID = 0;
  late final int chapterID;
  List<Paragraph> _paragraphs = [];
  List<Paragraph> get paragraphs => _paragraphs;
  SpeakState _speakState = SpeakState.silence;
  SpeakState get speakState => _speakState;
  void setSpeakState(SpeakState value) {
    if (_speakState == SpeakState.paused && value == SpeakState.silence) {
      return;
    }
    _speakState = value;
    notifyListeners();
  }

  int? activeParagraphIndex;
  void setActiveParagraphIndex(int index) => activeParagraphIndex = index;

  int _paragraphOrderNum = 0;
  int get paragraphOrderNum => _paragraphOrderNum;
  Chapter? _chapter;
  Chapter? get chapter => _chapter;
  int _currentPage = 0;
  int get currentPage => _currentPage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  ChapterViewModel(
    this.url, {
    required this.chapterService,
    required this.docService,
    required this.ttsService,
    required this.pageController,
    required this.textEditingController,
  }) {
    pageController.addListener(() {
      _currentPage = pageController.page!.toInt();
    });
    asyncInit();
    if (ttsService.positionEvent() != null) {
      ttsService.positionEvent()!.listen((event) {
        L.info("start1: ${event.start}, end: ${event.end}");
      });
    }
  }

  Future<void> asyncInit() async {
    // prepairing IDs
    if (url.contains("#")) {
      chapterID = int.tryParse(url.split("#")[0]) ?? 0;
      paragraphID = int.tryParse(url.split("#")[1]) ?? 0;
    } else {
      chapterID = int.tryParse(url) ?? 0;
      paragraphID = 0;
    }
    // it is necessary to specify init page number for the PageController
    chapterIdOrderNumMap = docService.orderNumToChapterIdMap();
    int initPage = 0;
    // if requested a current doc
    if (chapterIdOrderNumMap.containsValue(chapterID)) {
      initPage = chapterIdOrderNumMap.keys
          .firstWhere((key) => chapterIdOrderNumMap[key] == chapterID);
    }

    if (pageController.hasClients) pageController.jumpToPage(initPage);

    chapterCount = docService.totalChapters();
    L.info('chapter ID: $chapterID');
    await getOne(chapterID);
    // if (paragraphID == 0) {
    //   print("paragraphID == 0");
    //   return;
    // }
    if (chapter == null || chapter!.paragraphs == null) {
      L.info("chapter == null || chapter!.paragraphs == null");
      return;
    }

    _paragraphs = chapter!.paragraphs!;
    L.error("${_paragraphs == null} length: ${_paragraphs.length}");
    _paragraphOrderNum = _paragraphs
        .where((element) => element.paragraphID.toInt() == paragraphID)
        .first
        .paragraphOrderNum;
  }

  Future<void> getOne(int id) async {
    _chapter = await chapterService.getOne(id);
    _errorMessage = chapter == null ? "Этот документ пока недоступен" : null;
    notifyListeners();
  }

  void onPageChanged() {
    final int index = pageController.page!.toInt();
    final int id = chapterIdOrderNumMap[index + 1] ?? chapterID;
    getOne(id);

    textEditingController.text = '${index + 1}';
    notifyListeners();
  }

  Future<bool> onTapUrl(BuildContext context, String url) async {
    print("url: $url");
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.chapterScreen,
      arguments: url,
    );
    return true;
  }

  Future<void> startSpeakParagraph() async {
    if (chapter == null ||
        _paragraphs.isEmpty ||
        activeParagraphIndex == null) {
      return;
    }

    setSpeakState(SpeakState.speaking);
    await ttsService
        .speakOne(chapter!.paragraphs![activeParagraphIndex!].content);
    setSpeakState(SpeakState.silence);
  }

  Future<void> startSpeakChapter() async {
    if (chapter == null || _paragraphs.isEmpty) {
      return;
    }

    final texts =
        chapter!.paragraphs!.map((paragraph) => paragraph.content).toList();
    setSpeakState(SpeakState.speaking);
    await ttsService.speakList(texts);
    setSpeakState(SpeakState.silence);
  }

  Future<void> stopSpeak() async {
    await ttsService.stopSpeak();
    setSpeakState(SpeakState.silence);
  }

  Future<void> pauseSpeak() async {
    await ttsService.pauseSpeak();
    setSpeakState(SpeakState.paused);
  }

  Future<void> resumeSpeak() async {
    setSpeakState(SpeakState.speaking);
    await ttsService.resumeSpeak();
    setSpeakState(SpeakState.silence);
  }

  void onAppBarTextFormFieldChanged(String text) {
    print("changed:$text");
    textEditingController.text = text;
    textEditingController.selection =
        TextSelection.collapsed(offset: textEditingController.text.length);
    notifyListeners();
  }

  void onAppBarTextFormFieldEditingComplete(BuildContext context) {
    print("completed");
    final text = textEditingController.text;
    int pageNum = int.tryParse(text) ?? 1;
    if (pageNum > chapterCount) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            '$pageNum-ой страницы не существует, страниц в документе всего $chapterCount!'),
      ));
      notifyListeners();
      return;
    } else if (pageNum < 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$pageNum-ой страницы не существует!'),
      ));
      notifyListeners();
      return;
    }
    if (pageController.page == null) {
      return;
    }
    pageController.animateToPage(pageNum,
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }

  void onPrevPressed(BuildContext context) async {
    int? pageNum = int.tryParse(textEditingController.text);
    if (pageNum == 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Это первая страница!'),
      ));
      return;
    }
    if (pageController.page == null) {
      return;
    }
    pageController.previousPage(
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }

  void onForwardPressed(BuildContext context) async {
    int? pageNum = int.tryParse(textEditingController.text);
    if (pageNum == null) {
      return;
    }
    if (pageNum == chapterCount) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Это последняя страница!'),
      ));
      return;
    }
    if (pageController.page == null) {
      return;
    }
    pageController.nextPage(
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }
}
