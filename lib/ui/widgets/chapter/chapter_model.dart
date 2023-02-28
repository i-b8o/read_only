import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/link.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/entity/speak_state.dart';
import 'package:read_only/domain/entity/tts_position.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class ChapterAppSettingService {
  double getFontSizeInPx();
  int getFontWeight();
}

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
  // Stream<TtsPosition>? positionEvent();
}

abstract class ChapterViewModelParagraphService {
  Future<void> saveParagraph(int paragraphID, chapterID, String content);
}

abstract class ChapterViewModelNoteService {
  Future<void> saveNote(int paragraphID, chapterID);
}

class ChapterViewModel extends ChangeNotifier {
  ChapterViewModel(
    this.link, {
    required this.appSettingsService,
    required this.paragraphService,
    required this.chapterService,
    required this.docService,
    required this.ttsService,
    required this.noteService,
    required this.pageController,
    required this.textEditingController,
  }) {
    pageController.addListener(() {
      _currentPage = pageController.page!.toInt();
    });
    asyncInit();
  }
  final Link link;

  final ChapterAppSettingService appSettingsService;
  final ChapterViewModelParagraphService paragraphService;
  final ChapterViewModelService chapterService;
  final ChapterViewModelDocService docService;
  final ChapterViewModelTtsService ttsService;
  final ChapterViewModelNoteService noteService;
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

  int? _activeParagraphIndex;
  void setActiveParagraphIndex(int index) => _activeParagraphIndex = index;

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
    try {
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

      setChapter(chapter);
      if (_chapter != null && _chapter!.paragraphs != null) {
        _paragraphs = chapter!.paragraphs!;

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

  double getFontSizeInPx() {
    return appSettingsService.getFontSizeInPx();
  }

  int getFontWeight() {
    return appSettingsService.getFontWeight();
  }

  Future<bool> onTapUrl(BuildContext context, String url) async {
    final List<String> parts = url.split("#");
    final int chapterID = int.tryParse(parts[0]) ?? 0;
    int? paragraphID;
    Link link;
    if (parts.length == 2) {
      paragraphID = int.tryParse(parts[1]) ?? 0;
    }
    try {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.chapterScreen,
        arguments: Link(chapterID: chapterID, paragraphID: paragraphID ?? 0),
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
          _activeParagraphIndex == null) {
        return;
      }

      setSpeakState(SpeakState.speaking);
      await ttsService
          .speakOne(chapter!.paragraphs![_activeParagraphIndex!].content);
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

  Future<void> onSaveParagraph(
      int paragraphID, chapterID, String content) async {
    await paragraphService.saveParagraph(paragraphID, chapterID, content);
  }

  Future<void> onSaveNote() async {
    final paragraphID =
        chapter!.paragraphs![_activeParagraphIndex!].paragraphID;
    final chapterID = chapter!.paragraphs![_activeParagraphIndex!].chapterID;
    await noteService.saveNote(paragraphID, chapterID);
  }
}
