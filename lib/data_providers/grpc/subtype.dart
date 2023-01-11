import 'dart:developer';

import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import '../../library/grpc_client/grpc_client.dart';
import 'package:fixnum/fixnum.dart';

class SubtypeDataProviderError {
  final String m;

  SubtypeDataProviderError(this.m);
}

class SubtypeDataProvider {
  const SubtypeDataProvider();
  Future<GetAllSubtypesResponse> getAll(Int64 id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw SubtypeDataProviderError(m);
    // }
    try {
      GetAllSubtypesRequest req = GetAllSubtypesRequest(iD: id);
      return await GrpcClient.subtypeStub.getAll(req);
    } catch (e) {
      throw SubtypeDataProviderError(e.toString());
    }
  }

  Future<GetDocsResponse> getDocs(Int64 id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw SubtypeDataProviderError(m);
    // }
    try {
      GetDocsRequest req = GetDocsRequest(iD: id);
      return await GrpcClient.subtypeStub.getDocs(req);
    } catch (e) {
      throw SubtypeDataProviderError(e.toString());
    }
  }
}
