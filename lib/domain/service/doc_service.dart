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
}

class DocService implements ChapterListViewModelService {
  final DocDataProvider docDataProvider;
  final LocalDocDataProvider localDocDataProvider;

  DocService(
      {required this.docDataProvider, required this.localDocDataProvider});

  late int _chapterCount;
  int get chapterCount => _chapterCount;
  late Map<int, int> _chaptersOrderNums;
  Map<int, int> get chaptersOrderNums => _chaptersOrderNums;

  @override
  Future<ReadOnlyDoc> getOne(int id) async {
    // Try to retrieve doc from a local storage
    final ReadOnlyDoc? doc = await localDocDataProvider.getOne(id);
    if (doc != null) {
      assign(doc.chapters);
      return doc;
    }

    // Get from a remote storage
    final ReadOnlyDoc resp = await docDataProvider.getOne(id);
    await localDocDataProvider.saveOne(resp, id);
    assign(resp.chapters);
    return resp;
  }

  void assign(List<ReadOnlyChapterInfo> chapters) {
    _chapterCount = chapters.length;
    _chaptersOrderNums = {};
    for (final chapter in chapters) {
      _chaptersOrderNums[chapter.orderNum] = chapter.id;
    }
  }
}
