import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';

import 'package:read_only/domain/entity/doc.dart' as domain_doc;
import 'package:read_only/domain/service/doc_service.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/pb/reader/service.pbgrpc.dart';
import 'package:read_only/domain/entity/chapter.dart' as domain_chapter;

class DocDataProviderDefault implements DocDataProvider {
  DocDataProviderDefault()
      : _docGRPCClient = DocGRPCClient(GrpcClient().channel());

  final DocGRPCClient _docGRPCClient;

  @override
  Future<domain_doc.Doc> getOne(int id) async {
    try {
      // Request
      Int64 int64ID = Int64(id);
      GetOneDocRequest req = GetOneDocRequest(iD: int64ID);
      GetOneDocResponse resp = await _docGRPCClient.getOne(req);
      // Mapping
      List<domain_chapter.Chapter> chapters = resp.chapters
          .map((e) => domain_chapter.Chapter(
              id: e.iD.toInt(), name: e.name, orderNum: e.orderNum, num: e.num))
          .toList();
      return domain_doc.Doc(id: id, name: resp.name, chapters: chapters);
    } catch (e) {
      throw PlatformException(code: "get_one_doc_error", details: e);
    }
  }
}
