import 'package:fixnum/fixnum.dart';

import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/domain/entity/chapter.dart' as domain_chapter;
import 'package:read_only/domain/entity/paragraph.dart' as domain_paragraph;

import 'package:read_only/domain/service/chapter_service.dart';

import 'package:read_only/pb/reader/service.pbgrpc.dart';

class ChapterDataProviderDefault implements ChapterDataProvider {
  ChapterDataProviderDefault()
      : _chapterGRPCClient = ChapterGRPCClient(GrpcClient().channel());

  final ChapterGRPCClient _chapterGRPCClient;

  @override
  Future<List<domain_chapter.Chapter>?> getChapterWithNeighbors(
      int chapterId) async {
    try {
      final int64ID = Int64(chapterId);
      final request = GetWithNeighborsRequest(iD: int64ID);
      final response = await _chapterGRPCClient.getWithNeighbors(request);

      List<domain_chapter.Chapter> chapters = [];
      for (final c in response.chapters) {
        chapters.add(domain_chapter.Chapter(
            id: c.iD.toInt(),
            docID: c.docID.toInt(),
            name: c.name,
            num: c.num,
            orderNum: c.orderNum));
      }

      return chapters;
    } catch (e) {
      return null;
    }
  }
}
