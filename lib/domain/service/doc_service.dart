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
  int totalChapters() => _totalChapters;

  // A private field to store a map of order numbers to id of chapters
  late Map<int, int> _orderNumToChapterIdMap;

  Map<int, int> orderNumToChapterIdMap() => _orderNumToChapterIdMap;

  @override
  // when a user selects a document on the DocList screen - save it (Doc) and all chapters (ReadOnlyChapterInfo).
  Future<Doc> getOne(int id) async {
    try {
      // local database
      final Doc? doc = await localDocDataProvider.getDoc(id);
      if (doc != null && doc.chapters != null) {
        assign(doc.chapters!);
        return doc;
      }

      // remote server
      final Doc resp = await docDataProvider.getOne(id);
      var futures = [
        localDocDataProvider.saveDoc(resp, id),
        localChapterDataProvider.saveChapters(resp.chapters ?? [])
      ];

      await Future.wait(futures);
      assign(resp.chapters ?? []);
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
    _totalChapters = chapters.length;
    _orderNumToChapterIdMap = {};
    for (final chapter in chapters) {
      _orderNumToChapterIdMap[chapter.orderNum] = chapter.id;
    }
  }
}
