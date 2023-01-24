import 'package:read_only/data_providers/subtype_data_providerdart';
import 'package:read_only/domain/entity/doc_info.dart';
import 'package:read_only/domain/entity/sub_type.dart';
import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:fixnum/fixnum.dart';

class GrpcSubtypeDataProviderError {
  final String m;

  GrpcSubtypeDataProviderError(this.m);
}

class GrpcSubtypeDataProvider implements SubtypeDataProvider {
  const GrpcSubtypeDataProvider();
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
      GetAllSubtypesResponse resp = await GrpcClient.subtypeStub.getAll(req);
      // Mapping
      List<ReadOnlySubtype> subtypes = resp.subtypes
          .map((e) => ReadOnlySubtype(id: e.iD.toInt(), name: e.name))
          .toList();
      return subtypes;
    } catch (e) {
      throw GrpcSubtypeDataProviderError(e.toString());
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
      throw GrpcSubtypeDataProviderError(e.toString());
    }
  }
}
