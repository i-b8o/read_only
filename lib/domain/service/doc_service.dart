import 'package:read_only/domain/entity/chapter_info.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';

abstract class DocDataProvider {
  const DocDataProvider();
  Future<ReadOnlyDoc> getOne(int id);
}

abstract class DocServiceLocalDocDataProvider {
  const DocServiceLocalDocDataProvider();
  Future<void> saveOne(ReadOnlyDoc doc, int id);
  Future<ReadOnlyDoc?> getOne(int id);
}

class DocService implements ChapterListViewModelService {
  final DocDataProvider docDataProvider;
  final DocServiceLocalDocDataProvider localDocDataProvider;

  DocService(
      {required this.docDataProvider, required this.localDocDataProvider});

  late int _totalChapters;

  // A getter to return the total number of chapters
  int get totalChapters => _totalChapters;

  // A private field to store a map of order numbers to id of chapters
  late Map<int, int> _orderNumToChapterIdMap;

  Map<int, int> get orderNumToChapterIdMap => _orderNumToChapterIdMap;

  @override
  Future<ReadOnlyDoc> getOne(int id) async {
    try {
      final ReadOnlyDoc? doc = await localDocDataProvider.getOne(id);
      if (doc != null) {
        assign(doc.chapters);
        return doc;
      }
      final ReadOnlyDoc resp = await docDataProvider.getOne(id);
      await localDocDataProvider.saveOne(resp, id);
      assign(resp.chapters);
      return resp;
    } on Exception catch (_) {
      rethrow;
    }
  }

  void assign(List<ReadOnlyChapterInfo> chapters) {
    _totalChapters = chapters.length;
    _orderNumToChapterIdMap = {};
    for (final chapter in chapters) {
      _orderNumToChapterIdMap[chapter.orderNum] = chapter.id;
    }
  }
}
