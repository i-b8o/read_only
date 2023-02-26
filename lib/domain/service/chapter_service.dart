import 'dart:async';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class ChapterDataProvider {
  const ChapterDataProvider();
  Future<Chapter?> getOne(int chapterId);
}

abstract class ParagraphDataProvider {
  const ParagraphDataProvider();
  Future<List<Paragraph>?> getParagraphs(int chapterID);
}

abstract class ParagraphServiceLocalChapterDataProvider {
  Future<List<Paragraph>?> getParagraphs(int chapterID);
  Future<void> saveParagraphs(List<Paragraph> paragraphs);
}

abstract class ChapterServiceLocalChapterDataProvider {
  Future<Chapter?> getChapter(int id);
  Future<void> saveChapter(Chapter chapter);
}

class ChapterService implements ChapterViewModelService {
  final ChapterDataProvider chapterDataProvider;
  final ParagraphDataProvider paragraphDataProvider;
  final ParagraphServiceLocalChapterDataProvider localParagraphDataProvider;
  final ChapterServiceLocalChapterDataProvider localChapterDataProvider;

  const ChapterService({
    required this.chapterDataProvider,
    required this.paragraphDataProvider,
    required this.localParagraphDataProvider,
    required this.localChapterDataProvider,
  });

  @override
  Future<Chapter?> getOne(int id) async {
    try {
      // Try to get the chapter from local storage
      final ch = await localChapterDataProvider.getChapter(id);
      if (ch != null) {
        try {
          // If found, try to get its paragraphs from local storage
          final paragraphs =
              await localParagraphDataProvider.getParagraphs(ch.id);
          if (paragraphs != null && paragraphs.isNotEmpty) {
            // If paragraphs found, return the chapter with paragraphs
            L.info("The chapter was returned from the local storage");
            return ch.copyWith(paragraphs: paragraphs);
          }
        } catch (e) {
          // Handle any exceptions when getting paragraphs from local storage
          L.error('Error getting paragraphs from local storage: $e');
        }
      }

      try {
        // If chapter or its paragraphs not found in local storage,
        // get the chapter with its neighbors from the remote server
        final chapter = await chapterDataProvider.getOne(id);
        if (chapter == null || chapter.paragraphs == null) {
          return null; // Return null if not found on server
        }

        // At first save the paragraphs and then save the chapters to local storage for faster access next time
        await localParagraphDataProvider.saveParagraphs(chapter.paragraphs!);
        await localChapterDataProvider.saveChapter(chapter);

        L.info("The chapter was returned from the remote server");
        // Return the chapter with the requested ID from the fetched chapters
        return chapter;
      } catch (e) {
        // Handle any exceptions when getting chapters from server
        L.error('Error getting chapters from server: $e');
      }
    } catch (e) {
      // Handle any exceptions when getting chapter from local storage
      L.error('Error getting chapter from local storage: $e');
    }
    return null;
  }
}
