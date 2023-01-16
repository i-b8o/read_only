import 'dart:developer';

import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/domain/entity/doc_info.dart';
import 'package:read_only/domain/entity/sub_type.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import '../../library/grpc_client/grpc_client.dart';
import 'package:fixnum/fixnum.dart';

class SubtypeDataProviderError {
  final String m;

  SubtypeDataProviderError(this.m);
}

class SubtypeDataProvider {
  const SubtypeDataProvider();
  Future<List<ReadOnlySubtype>> getAll(int id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw SubtypeDataProviderError(m);
    // }
    try {
      // Request
      Int64 int64ID = Int64(id);
      GetAllSubtypesRequest req = GetAllSubtypesRequest(iD: int64ID);
      GetAllSubtypesResponse resp = await GrpcClient.subtypeStub.getAll(req);
      // Mapping
      List<ReadOnlySubtype> subtypes = resp.subtypes
          .map((e) => ReadOnlySubtype(id: e.iD.toInt(), name: e.name))
          .toList();
      return subtypes;
    } catch (e) {
      throw SubtypeDataProviderError(e.toString());
    }
  }

  Future<List<ReadOnlyDocInfo>> getDocs(int id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw SubtypeDataProviderError(m);
    // }
    try {
      // Request
      Int64 int64ID = Int64(id);
      GetDocsRequest req = await GetDocsRequest(iD: int64ID);
      GetDocsResponse resp = await GrpcClient.subtypeStub.getDocs(req);
      // MApping
      List<ReadOnlyDocInfo> docs = resp.docs
          .map((e) => ReadOnlyDocInfo(
                name: e.name,
                id: e.iD.toInt(),
              ))
          .toList();
      return docs;
    } catch (e) {
      throw SubtypeDataProviderError(e.toString());
    }
  }
}
