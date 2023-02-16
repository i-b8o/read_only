import 'package:fixnum/fixnum.dart';

import 'package:grpc_client/grpc_client.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/chapter.dart' as domain_chapter;
import 'package:read_only/domain/entity/paragraph.dart' as domain_paragraph;

import 'package:read_only/domain/service/chapter_service.dart';

import 'package:read_only/pb/reader/service.pbgrpc.dart';

class ChapterDataProviderDefault implements ChapterDataProvider {
  ChapterDataProviderDefault()
      : _chapterGRPCClient = ChapterGRPCClient(GrpcClient().channel());

  final ChapterGRPCClient _chapterGRPCClient;

  @override
  Future<domain_chapter.Chapter?> getChapter(int chapterId) async {
    try {
      final int64ID = Int64(chapterId);
      final request = GetOneChapterRequest(iD: int64ID);
      final response = await _chapterGRPCClient.getOne(request);
      final paragraphs = _mapParagraphs(response.paragraphs);

      return domain_chapter.Chapter(
          id: response.iD.toInt(),
          docID: response.docID.toInt(),
          name: response.name,
          num: response.num,
          paragraphs: paragraphs,
          orderNum: response.orderNum);
    } catch (e) {
      return null;
    }
  }

  List<domain_paragraph.Paragraph> _mapParagraphs(
      List<ReaderParagraph> paragraphs) {
    return paragraphs
        .map((e) => domain_paragraph.Paragraph(
            paragraphID: e.iD.toInt(),
            paragraphOrderNum: e.num,
            hasLinks: e.hasLinks,
            isTable: e.isTable,
            isNFT: e.isNFT,
            paragraphclass: e.class_6,
            content: e.content,
            chapterID: e.chapterID.toInt()))
        .toList();
  }
}
