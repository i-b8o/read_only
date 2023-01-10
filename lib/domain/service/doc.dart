import 'package:read_only/data_providers/grpc/doc.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';
import 'package:fixnum/fixnum.dart';

class DocService implements ChapterListViewModelProvider {
  final DocDataProvider docDataProvider;
  late int _chapterCount;
  int get chapterCount => _chapterCount;
  Map<int, Int64> _chaptersOrderNums = {};
  Map<int, Int64> get chaptersOrderNums => _chaptersOrderNums;

  DocService({required this.docDataProvider});

  @override
  Future<GetOneDocResponse> getOne(Int64 id) async {
    print("get one");
    final resp = await docDataProvider.getOne(id);
    assign(resp.chapters);
    return resp;
  }

  void assign(List<Chapter> chapters) {
    _chapterCount = chapters.length;
    for (final chapter in chapters) {
      _chaptersOrderNums[chapter.orderNum] = chapter.iD;
    }
  }
}
