import 'dart:developer';

import 'package:fixnum/fixnum.dart';

import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

class ChapterDataProviderError {}

class ChapterDataProvider {
  const ChapterDataProvider();

  Future<GetOneChapterResponse> getOne(Int64 id) async {
    try {
      GetOneChapterRequest req = GetOneChapterRequest(iD: id);
      return await GrpcClient.chapterStub.getOne(req);
    } catch (e) {
      log(e.toString());
      throw ChapterDataProviderError();
    }
  }
}
