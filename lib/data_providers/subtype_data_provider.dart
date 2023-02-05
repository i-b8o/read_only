import 'package:flutter/services.dart';

import 'package:read_only/domain/entity/doc_info.dart';
import 'package:read_only/domain/entity/sub_type.dart';
import 'package:read_only/domain/service/subtype_service.dart';

import 'package:fixnum/fixnum.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/pb/reader/service.pbgrpc.dart';

class SubtypeDataProviderDefault implements SubtypeDataProvider {
  SubtypeDataProviderDefault({required this.grpcClient})
      : _subtypeGRPCClient = SubGRPCClient(grpcClient.channel());
  final GrpcClient grpcClient;
  final SubGRPCClient _subtypeGRPCClient;
  @override
  Future<List<ReadOnlySubtype>> getAll(int id) async {
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
      List<ReadOnlySubtype> subtypes = resp.subtypes
          .map((e) => ReadOnlySubtype(id: e.iD.toInt(), name: e.name))
          .toList();
      return subtypes;
    } catch (e) {
      throw PlatformException(code: "get_all_subtype_error");
    }
  }

  @override
  Future<List<ReadOnlyDocInfo>> getDocs(int id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw GrpcSubtypeDataProviderError(m);
    // }
    try {
      // Request
      Int64 int64ID = Int64(id);
      GetDocsRequest req = GetDocsRequest(iD: int64ID);
      GetDocsResponse resp = await _subtypeGRPCClient.getDocs(req);
      // MApping
      List<ReadOnlyDocInfo> docs = resp.docs
          .map((e) => ReadOnlyDocInfo(
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
