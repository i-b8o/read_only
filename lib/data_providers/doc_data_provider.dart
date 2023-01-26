import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';

import 'package:read_only/domain/entity/chapter_info.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/pb/reader/service.pbgrpc.dart';

class DocDataProviderDefault1 implements DocDataProvider {
  DocDataProviderDefault1({required this.grpcClient})
      : _docGRPCClient = DocGRPCClient(grpcClient.channel());
  final GrpcClient grpcClient;
  final DocGRPCClient _docGRPCClient;

  Future<ReadOnlyDoc> getOne(int id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw GrpcDocDataProviderError(m);
    // }
    try {
      // Request
      Int64 int64ID = Int64(id);
      GetOneDocRequest req = GetOneDocRequest(iD: int64ID);
      GetOneDocResponse resp = await _docGRPCClient.getOne(req);
      // Mapping
      List<ReadOnlyChapterInfo> chapters = resp.chapters
          .map((e) => ReadOnlyChapterInfo(
              id: e.iD.toInt(), name: e.name, orderNum: e.orderNum, num: e.num))
          .toList();
      return ReadOnlyDoc(name: resp.name, chapters: chapters);
    } catch (e) {
      throw PlatformException(code: "get_one_doc_error", details: e);
    }
  }
}
