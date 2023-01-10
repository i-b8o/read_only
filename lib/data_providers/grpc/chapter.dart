import 'dart:developer';

import 'package:fixnum/fixnum.dart';

import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

class ChapterDataProviderError {}

class ChapterDataProvider {
  final GrpcClient client;

  const ChapterDataProvider({required this.client});

  Future<GetOneChapterResponse> getOne(Int64 id) async {
    print("Here");
    try {
      GetOneChapterRequest req = GetOneChapterRequest(iD: id);
      return await client.chapterStub.getOne(req);
    } catch (e) {
      log(e.toString());
      throw ChapterDataProviderError();
    }
  }
}
