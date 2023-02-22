import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/link.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/entity/tts_position.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class ChapterViewModelService {
  Future<Chapter?> getOne(int id);
}

abstract class ChapterViewModelDocService {
  int totalChapters();
  int? initPage(int chapterID);
  int? chapterIdByOrderNum(int orderNum);
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
  ChapterViewModel(
    this.link, {
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
  final Link link;

  final ChapterViewModelService chapterService;
  final ChapterViewModelDocService docService;
  final ChapterViewModelTtsService ttsService;
  final PageController pageController;
  final TextEditingController textEditingController;

  int chaptersTotal = 0;

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
  void setChapter(Chapter? chapter) {
    _chapter = chapter;
    _errorMessage =
        chapter == null ? "This document is currently unavailable" : null;
  }

  List<Paragraph> _paragraphs = [];
  List<Paragraph> get paragraphs => _paragraphs;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> asyncInit() async {
    L.info("asyncInit");
    try {
      L.info(
          " link: ${link.chapterID} ${link.paragraphID} ${pageController.initialPage}");
      chaptersTotal = docService.totalChapters();
      await getOne(link.chapterID);

      if (link.paragraphID == 0) {
        return;
      }
      if (chapter == null || chapter!.paragraphs == null) {
        return;
      }

      _paragraphOrderNum = _paragraphs
          .where((element) => element.paragraphID.toInt() == link.paragraphID)
          .first
          .paragraphOrderNum;
    } catch (e) {
      L.error("Error in asyncInit: $e");
    }
  }

  Future<void> getOne(int id) async {
    try {
      final chapter = await chapterService.getOne(id);
      L.error("getOne: ${chapter!.id}");
      setChapter(chapter);
      if (_chapter != null && _chapter!.paragraphs != null) {
        _paragraphs = chapter.paragraphs!;
        L.info("Length:${_paragraphs.length}");
        notifyListeners();
      }
    } catch (e) {
      L.error("Error in getOne: $e");
    }
  }

  Future<void> onPageChanged() async {
    try {
      final index = pageController.page!.toInt();
      final id = docService.chapterIdByOrderNum(index + 1) ?? link.chapterID;
      L.error("Page changed index: $index id:$id");
      await getOne(id);
      if (chapter != null) {
        L.error("chapter not null");
        textEditingController.text = '${index + 1}';
        notifyListeners();
      } else {
        throw Exception('Failed to retrieve chapter');
      }
    } catch (e) {
      L.error('Error in onPageChanged: $e');
      // Handle the error appropriately, e.g. show a toast or dialog to the user
    }
  }

  Future<bool> onTapUrl(BuildContext context, String url) async {
    try {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.chapterScreen,
        arguments: url,
      );
      return true;
    } catch (e) {
      L.error('Error occurred while navigating to chapter screen: $e');
      return false;
    }
  }

  Future<void> startSpeakParagraph() async {
    try {
      if (chapter == null ||
          _paragraphs.isEmpty ||
          activeParagraphIndex == null) {
        return;
      }

      setSpeakState(SpeakState.speaking);
      await ttsService
          .speakOne(chapter!.paragraphs![activeParagraphIndex!].content);
      setSpeakState(SpeakState.silence);
    } catch (e) {
      L.error('Error occurred while speaking: $e');
    }
  }

  Future<void> startSpeakChapter() async {
    try {
      if (chapter == null || _paragraphs.isEmpty) {
        return;
      }

      final texts =
          chapter!.paragraphs!.map((paragraph) => paragraph.content).toList();
      setSpeakState(SpeakState.speaking);
      await ttsService.speakList(texts);
      setSpeakState(SpeakState.silence);
    } catch (e) {
      L.error('An error occurred while speaking the chapter: $e');
    }
  }

  Future<void> stopSpeak() async {
    try {
      await ttsService.stopSpeak();
    } catch (e) {
      L.error('An error occurred while stop speaking the chapter: $e');
    }
    try {
      setSpeakState(SpeakState.silence);
    } catch (e) {
      L.error('An error occurred while stop speaking the chapter: $e');
    }
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
    textEditingController.text = text;
    textEditingController.selection =
        TextSelection.collapsed(offset: textEditingController.text.length);
    notifyListeners();
  }

  void onAppBarTextFormFieldEditingComplete(BuildContext context) {
    final text = textEditingController.text;
    int pageNum = int.tryParse(text) ?? 1;
    if (pageNum > chaptersTotal) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            '$pageNum-ой страницы не существует, страниц в документе всего $chaptersTotal!'),
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
    L.info("pressed");
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
    if (pageNum == chaptersTotal) {
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
