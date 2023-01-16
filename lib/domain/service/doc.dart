import 'package:read_only/data_providers/grpc/doc.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';
import 'package:fixnum/fixnum.dart';

class DocService implements ChapterListViewModelProvider {
  final DocDataProvider docDataProvider;
  late int _chapterCount;
  int get chapterCount => _chapterCount;
  late Map<int, int> _chaptersOrderNums;
  Map<int, int> get chaptersOrderNums => _chaptersOrderNums;

  DocService({required this.docDataProvider});

  @override
  Future<ReadOnlyDoc> getOne(int id) async {
    final ReadOnlyDoc resp = await docDataProvider.getOne(id);
    assign(resp.chapters);
    return resp;
  }

  void assign(List<ReadOnlyChapter> chapters) {
    _chapterCount = chapters.length;
    _chaptersOrderNums = {};
    for (final chapter in chapters) {
      _chaptersOrderNums[chapter.orderNum] = chapter.id;
    }
  }
}
