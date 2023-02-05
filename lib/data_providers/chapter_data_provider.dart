import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/service/chapter_service.dart';

import 'package:read_only/pb/reader/service.pbgrpc.dart';

class ChapterDataProviderDefault implements ChapterDataProvider {
  ChapterDataProviderDefault({required this.grpcClient})
      : _chapterGRPCClient = ChapterGRPCClient(grpcClient.channel());
  final GrpcClient grpcClient;
  final ChapterGRPCClient _chapterGRPCClient;

  @override
  Future<ReadOnlyChapter> getOne(int id) async {
    // sleep(Duration(seconds: 2));
    try {
      // String? m = GrpcClient.check();
      // if (m != null) {
      //   throw GrpcChapterDataProviderError(m);
      // }
      Int64 int64ID = Int64(id);
      GetOneChapterRequest req = GetOneChapterRequest(iD: int64ID);
      GetOneChapterResponse resp = await _chapterGRPCClient.getOne(req);
      // Mapping
      List<ReadOnlyParagraph> paragraphs = resp.paragraphs
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
      return ReadOnlyChapter(
          id: resp.iD.toInt(),
          name: resp.name,
          num: resp.num,
          paragraphs: paragraphs,
          orderNum: resp.orderNum);
    } catch (e) {
      throw PlatformException(code: "get_one_chapter_error", details: e);
    }
  }
}
