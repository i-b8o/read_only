import 'dart:async';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class ChapterDataProvider {
  const ChapterDataProvider();
  Future<List<Chapter>?> getChapterWithNeighbors(int id);
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
  Future<void> saveChapters(List<Chapter> chapters);
}

abstract class TtsSettingsDataProvider {
  const TtsSettingsDataProvider();
  Future<void> saveVolume(double value);
  Future<void> saveVoice(String value);
  Future<String?> readCurrentLanguage();
}

class ChapterService implements ChapterViewModelService {
  final ChapterDataProvider chapterDataProvider;
  final ParagraphDataProvider paragraphDataProvider;
  final TtsSettingsDataProvider ttsSettingsDataProvider;
  final ParagraphServiceLocalChapterDataProvider localParagraphDataProvider;
  final ChapterServiceLocalChapterDataProvider localChapterDataProvider;

  const ChapterService({
    required this.chapterDataProvider,
    required this.paragraphDataProvider,
    required this.ttsSettingsDataProvider,
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
        final chapters = await chapterDataProvider.getChapterWithNeighbors(id);
        if (chapters == null || chapters.isEmpty) {
          return null; // Return null if not found on server
        }

        List<Paragraph> paragraphs = [];
        Chapter? resultChapter;
        for (final c in chapters) {
          try {
            final ps = await paragraphDataProvider.getParagraphs(c.id);
            if (ps == null) {
              return null;
            }
            if (c.id == id) {
              resultChapter = c.copyWith(paragraphs: ps);
            }

            paragraphs = paragraphs + ps;
          } catch (e) {
            // Handle any exceptions when getting paragraphs from server
            L.error('Error getting paragraphs from server: $e');
          }
        }

        // At first save the paragraphs and then save the chapters to local storage for faster access next time
        await localParagraphDataProvider.saveParagraphs(paragraphs);
        await localChapterDataProvider.saveChapters(chapters);

        L.info("The chapter was returned from the remote server");
        // Return the chapter with the requested ID from the fetched chapters
        return resultChapter;
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
