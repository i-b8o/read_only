import 'package:read_only/domain/entity/chapter_info.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';

abstract class DocDataProvider {
  const DocDataProvider();
  Future<ReadOnlyDoc> getOne(int id);
}

abstract class LocalDocDataProvider {
  const LocalDocDataProvider();
  Future<void> saveOne(ReadOnlyDoc doc, int id);
  Future<ReadOnlyDoc?> getOne(int id);
  Future<void> updateLastAccess(int id);
}

// DocService class implements the ChapterListViewModelService interface
class DocService implements ChapterListViewModelService {
  // Dependency injection for the data providers for doc and local doc data
  final DocDataProvider docDataProvider;
  final LocalDocDataProvider localDocDataProvider;

  // Constructor for the DocService class with required docDataProvider and localDocDataProvider parameters
  DocService(
      {required this.docDataProvider, required this.localDocDataProvider});

  // A private field to store the count of chapters
  late int _chapterCount;

  // A getter to return the value of _chapterCount
  int get chapterCount => _chapterCount;

  // A private field to store a map of orderNum to id of chapters
  late Map<int, int> _chaptersOrderNums;

  // A getter to return the value of _chaptersOrderNums
  Map<int, int> get chaptersOrderNums => _chaptersOrderNums;

  // Overriden method from the ChapterListViewModelService interface
  Future<ReadOnlyDoc> getOne(int id) async {
    try {
      // Try to retrieve doc from the localDocDataProvider
      final ReadOnlyDoc? doc = await localDocDataProvider.getOne(id);
      // If the doc is not null, assign the chapters to the class fields
      if (doc != null) {
        assign(doc.chapters);
        // Update the `doc` table column `last_access` with the current time
        await localDocDataProvider.updateLastAccess(id);
        return doc;
      }

      // If the doc is null, get the doc from the docDataProvider
      final ReadOnlyDoc resp = await docDataProvider.getOne(id);
      // Save the doc to the localDocDataProvider
      await localDocDataProvider.saveOne(resp, id);
      // Assign the chapter`s count and order num to the class fields
      assign(resp.chapters);
      // Update the `doc` table column `last_access` with the current time
      await localDocDataProvider.updateLastAccess(id);
      return resp;
    } on Exception catch (_) {
      rethrow;
    }
  }

  // A helper method to assign the chapter count and chapters order num map
  void assign(List<ReadOnlyChapterInfo> chapters) {
    // Set the value of _chapterCount to the length of chapters
    _chapterCount = chapters.length;
    // Initialize the _chaptersOrderNums map
    _chaptersOrderNums = {};
    // Loop through the chapters list
    for (final chapter in chapters) {
      // Add the orderNum and id of each chapter to the _chaptersOrderNums map
      _chaptersOrderNums[chapter.orderNum] = chapter.id;
    }
  }
}
