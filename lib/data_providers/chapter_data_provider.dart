import 'package:fixnum/fixnum.dart';

import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/service/chapter_service.dart';

import 'package:read_only/pb/reader/service.pbgrpc.dart';

class ChapterDataProviderDefault implements ChapterDataProvider {
  ChapterDataProviderDefault()
      : _chapterGRPCClient = ChapterGRPCClient(GrpcClient().channel());

  final ChapterGRPCClient _chapterGRPCClient;

  @override
  Future<ReadOnlyChapter?> getChapter(int chapterId) async {
    try {
      final int64ID = Int64(chapterId);
      final request = GetOneChapterRequest(iD: int64ID);
      final response = await _chapterGRPCClient.getOne(request);
      final paragraphs = _mapParagraphs(response.paragraphs);

      return ReadOnlyChapter(
          id: response.iD.toInt(),
          name: response.name,
          num: response.num,
          paragraphs: paragraphs,
          orderNum: response.orderNum);
    } catch (e) {
      return null;
    }
  }

  List<ReadOnlyParagraph> _mapParagraphs(List<ReaderParagraph> paragraphs) {
    return paragraphs
        .map((e) => ReadOnlyParagraph(
            id: e.iD.toInt(),
            num: e.num,
            hasLinks: e.hasLinks,
            isTable: e.isTable,
            isNFT: e.isNFT,
            className: e.class_6,
            content: e.content,
            chapterID: e.chapterID.toInt()))
        .toList();
  }
}
