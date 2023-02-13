import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/tts_position.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class ChapterViewModelService {
  Future<ReadOnlyChapter?> getOne(int id);
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
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final ChapterViewModelService chapterProvider;
  final ChapterViewModelTtsService ttsService;
  final int chapterCount;
  final int id;
  final int paragraphID;
  final Map<int, int> chaptersOrderNums;
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
    required this.ttsService,
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
    if (ttsService.positionEvent() != null) {
      ttsService.positionEvent()!.listen((event) {
        MyLogger()
            .getLogger()
            .info("start1: ${event.start}, end: ${event.end}");
      });
    }
  }

  Future<void> asyncInit(int id) async {
    await getOne(id);
    if (paragraphID == 0) {
      return;
    }
    if (chapter == null) {
      return;
    }

    _paragraphOrderNum = chapter!.paragraphs
        .where((element) => element.id.toInt() == paragraphID)
        .first
        .num;
  }

  Future<void> getOne(int id) async {
    _chapter = await chapterProvider.getOne(id);
    _errorMessage = chapter == null ? "Этот документ пока недоступен" : null;
    notifyListeners();
  }

  void onPageChanged() {
    final int index = pageController.page!.toInt();

    getOne(chaptersOrderNums[index + 1] ?? id);

    textEditingController.text = '${index + 1}';
    notifyListeners();
  }

  Future<bool> onTapUrl(BuildContext context, String url) async {
    MyLogger().getLogger().info("url: $url");
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.chapterScreen,
      arguments: url,
    );
    return true;
  }

  Future<void> startSpeakParagraph() async {
    if (chapter == null || activeParagraphIndex == null) {
      return;
    }

    setSpeakState(SpeakState.speaking);
    await ttsService
        .speakOne(chapter!.paragraphs[activeParagraphIndex!].content);
    setSpeakState(SpeakState.silence);
  }

  Future<void> startSpeakChapter() async {
    if (chapter == null) {
      return;
    }
    final texts =
        chapter!.paragraphs.map((paragraph) => paragraph.content).toList();
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
    MyLogger().getLogger().info("changed:$text");
    textEditingController.text = text;
    textEditingController.selection =
        TextSelection.collapsed(offset: textEditingController.text.length);
    notifyListeners();
  }

  void onAppBarTextFormFieldEditingComplete(BuildContext context) {
    MyLogger().getLogger().info("completed");
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
