import 'dart:developer';

import 'package:fixnum/fixnum.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/chapter_info.dart';
import 'package:read_only/domain/entity/doc.dart';

import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

class DocDataProviderError {
  final String m;

  DocDataProviderError(this.m);
}

class DocDataProvider {
  const DocDataProvider();

  Future<ReadOnlyDoc> getOne(int id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw DocDataProviderError(m);
    // }
    try {
      // Request
      Int64 int64ID = Int64(id);
      GetOneDocRequest req = GetOneDocRequest(iD: int64ID);
      GetOneDocResponse resp = await GrpcClient.docStub.getOne(req);
      // Mapping
      List<ReadOnlyChapterInfo> chapters = resp.chapters
          .map((e) => ReadOnlyChapterInfo(
              id: e.iD.toInt(), name: e.name, orderNum: e.orderNum, num: e.num))
          .toList();
      return ReadOnlyDoc(name: resp.name, chapters: chapters);
    } catch (e) {
      throw DocDataProviderError(e.toString());
    }
  }
}
