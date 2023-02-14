import 'package:flutter/services.dart';

import 'package:read_only/domain/entity/doc.dart' as domain_doc;
import 'package:read_only/domain/entity/sub_type.dart' as domain_subtype;
import 'package:read_only/domain/service/subtype_service.dart';

import 'package:fixnum/fixnum.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/pb/reader/service.pbgrpc.dart';

class SubtypeDataProviderDefault implements SubtypeDataProvider {
  SubtypeDataProviderDefault()
      : _subtypeGRPCClient = SubGRPCClient(GrpcClient().channel());

  final SubGRPCClient _subtypeGRPCClient;
  @override
  Future<List<domain_subtype.Subtype>> getAll(int id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw GrpcSubtypeDataProviderError(m);
    // }
    try {
      // Request
      Int64 int64ID = Int64(id);
      GetAllSubtypesRequest req = GetAllSubtypesRequest(iD: int64ID);
      GetAllSubtypesResponse resp = await _subtypeGRPCClient.getAll(req);
      // Mapping
      List<domain_subtype.Subtype> subtypes = resp.subtypes
          .map((e) => domain_subtype.Subtype(id: e.iD.toInt(), name: e.name))
          .toList();
      return subtypes;
    } catch (e) {
      throw PlatformException(code: "get_all_subtype_error");
    }
  }

  @override
  Future<List<domain_doc.Doc>> getDocs(int id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw GrpcSubtypeDataProviderError(m);
    // }
    try {
      // Request
      Int64 int64ID = Int64(id);
      GetDocsRequest req = GetDocsRequest(iD: int64ID);
      GetDocsResponse resp = await _subtypeGRPCClient.getDocs(req);
      // Mapping
      List<domain_doc.Doc> docs = resp.docs
          .map((e) => domain_doc.Doc(
                name: e.name,
                id: e.iD.toInt(),
              ))
          .toList();
      return docs;
    } catch (e) {
      throw PlatformException(code: "get_docs_error", details: e);
    }
  }
}
