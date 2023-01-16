import 'dart:io';

import 'package:fixnum/fixnum.dart';
import 'package:read_only/domain/entity/chapter.dart';

import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

class ChapterDataProviderError {
  final String m;

  ChapterDataProviderError(this.m);
}

class ChapterDataProvider {
  const ChapterDataProvider();

  Future<ReadOnlyChapter> getOne(int id) async {
    sleep(Duration(seconds: 2));
    try {
      // String? m = GrpcClient.check();
      // if (m != null) {
      //   throw ChapterDataProviderError(m);
      // }
      Int64 int64ID = Int64(id);
      GetOneChapterRequest req = GetOneChapterRequest(iD: int64ID);
      GetOneChapterResponse resp = await GrpcClient.chapterStub.getOne(req);
      // Mapping
      return ReadOnlyChapter(
          id: resp.iD.toInt(),
          name: resp.name,
          num: resp.num,
          orderNum: resp.orderNum);
    } catch (e) {
      throw ChapterDataProviderError(e.toString());
    }
  }
}
