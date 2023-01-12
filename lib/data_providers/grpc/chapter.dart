import 'dart:io';

import 'package:fixnum/fixnum.dart';

import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

class ChapterDataProviderError {
  final String m;

  ChapterDataProviderError(this.m);
}

class ChapterDataProvider {
  const ChapterDataProvider();

  Future<GetOneChapterResponse> getOne(Int64 id) async {
    sleep(Duration(seconds: 2));

    try {
      // String? m = GrpcClient.check();
      // if (m != null) {
      //   throw ChapterDataProviderError(m);
      // }
      GetOneChapterRequest req = GetOneChapterRequest(iD: id);
      return await GrpcClient.chapterStub.getOne(req);
    } catch (e) {
      throw ChapterDataProviderError(e.toString());
    }
  }
}
