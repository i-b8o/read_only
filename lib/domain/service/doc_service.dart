import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';

abstract class DocDataProvider {
  const DocDataProvider();
  Future<Doc> getOne(int id);
}

abstract class DocServiceLocalDocDataProvider {
  const DocServiceLocalDocDataProvider();
  Future<void> saveDoc(Doc doc, int id);
  Future<Doc?> getDoc(int id);
}

abstract class DocServiceLocalChapterDataProvider {
  Future<void> saveChapters(List<Chapter> chapters);
  Future<List<Chapter>?> getChaptersByDocId(int id);
}

class DocService
    implements ChapterListViewModelService, ChapterViewModelDocService {
  final DocDataProvider docDataProvider;
  final DocServiceLocalDocDataProvider localDocDataProvider;
  final DocServiceLocalChapterDataProvider localChapterDataProvider;

  DocService(
      {required this.docDataProvider,
      required this.localDocDataProvider,
      required this.localChapterDataProvider});

  late int _totalChapters;
  // A getter to return the total number of chapters
  @override
  int totalChapters() => _totalChapters;

  // A private field to store a map of order numbers to id of chapters
  late Map<int?, int?> _orderNumToChapterIdMap;
  @override
  int? initPage(int chapterID) => _orderNumToChapterIdMap.keys
      .firstWhere((element) => element == chapterID, orElse: () => null);
  // @override
  // Map<int, int> orderNumToChapterIdMap() => _orderNumToChapterIdMap;

  @override
  // when a user selects a document on the DocList screen - save it (Doc) and all chapters (ReadOnlyChapterInfo).
  Future<Doc> getOne(int id) async {
    try {
      // local database
      final futures = [
        localDocDataProvider.getDoc(id),
        localChapterDataProvider.getChaptersByDocId(id),
      ];
      final results = await Future.wait(futures);
      final doc = results[0] as Doc?;
      final chapters = results[1] as List<Chapter>?;

      if (doc != null && chapters != null) {
        assign(doc.chapters!);
        L.info("The doc was returned from the local storage");
        return doc;
      }

      // remote server
      final Doc resp = await docDataProvider.getOne(id);
      final fs = [
        localDocDataProvider.saveDoc(resp, id),
        localChapterDataProvider.saveChapters(resp.chapters ?? [])
      ];

      await Future.wait(fs);
      assign(resp.chapters ?? []);
      L.info("The doc was returned from the remote server");
      return resp;
    } on Exception catch (_) {
      rethrow;
    }
  }

  // void _backgroundTask(SendPort sendPort) {
  //   int result = 0;
  //   final ids = _orderNumToChapterIdMap.values.toList();
  //   if (ids.isEmpty) {
  //     sendPort.send(result);
  //     return;
  //   }
  //   for (int i = 0; i < (ids.length - 1); i++) {
  //     final id = ids[i];
  //     //
  //     result += i;
  //   }
  //   sendPort.send(result);
  // }

  // void _launchInBackground() {
  //   ReceivePort receivePort = ReceivePort();
  //   Isolate.spawn(_backgroundTask, receivePort.sendPort);

  //   receivePort.listen((data) {
  //     MyLogger().getLogger().info('Result of the background task: $data');
  //   });
  // }

  void assign(List<Chapter> chapters) {
    try {
      _totalChapters = chapters.length;
      _orderNumToChapterIdMap = {};
      for (final chapter in chapters) {
        _orderNumToChapterIdMap[chapter.orderNum] = chapter.id;
      }
    } catch (e) {
      L.error('Error occurred while assigning chapters: $e');
    }
  }

  @override
  int? chapterIdByOrderNum(int orderNum) {
    return _orderNumToChapterIdMap[orderNum];
  }
}
