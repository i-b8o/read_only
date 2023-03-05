import 'package:fixnum/fixnum.dart';

import 'package:grpc_client/grpc_client.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart' as domain_chapter;
import 'package:read_only/domain/entity/paragraph.dart' as domain_paragraph;

import 'package:read_only/domain/service/chapter_service.dart';

import 'package:read_only/pb/reader/service.pbgrpc.dart';

class ChapterDataProviderDefault implements ChapterDataProvider {
  ChapterDataProviderDefault()
      : _chapterGRPCClient = ChapterGRPCClient(GrpcClient().channel("read"));

  final ChapterGRPCClient _chapterGRPCClient;

  @override
  Future<domain_chapter.Chapter?> getOne(int chapterId) async {
    L.info("Get chapter remote id: $chapterId");
    try {
      final int64ID = Int64(chapterId);
      final request = GetOneChapterRequest(iD: int64ID);
      final response = await _chapterGRPCClient.getOne(request);

      return domain_chapter.Chapter(
          id: response.iD.toInt(),
          docID: response.docID.toInt(),
          name: response.name,
          num: response.num,
          orderNum: response.orderNum,
          paragraphs: response.paragraphs
              .map((e) => domain_paragraph.Paragraph(
                  paragraphID: e.iD.toInt(),
                  paragraphOrderNum: e.num,
                  chapterID: chapterId,
                  hasLinks: e.hasLinks,
                  isNFT: e.isNFT,
                  isTable: e.isTable,
                  paragraphclass: e.class_6,
                  content: e.content))
              .toList());
    } catch (e) {
      return null;
    }
  }
}
