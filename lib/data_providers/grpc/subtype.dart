import 'dart:developer';

import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import '../../library/grpc_client/grpc_client.dart';
import 'package:fixnum/fixnum.dart';

class SubtypeDataProviderError {}

class SubtypeDataProvider {
  const SubtypeDataProvider();
  Future<GetAllSubtypesResponse> getAll(Int64 id) async {
    try {
      GetAllSubtypesRequest req = GetAllSubtypesRequest(iD: id);
      return await GrpcClient.subtypeStub.getAll(req);
    } catch (e) {
      log(e.toString());
      throw SubtypeDataProviderError();
    }
  }

  Future<GetDocsResponse> getDocs(Int64 id) async {
    try {
      GetDocsRequest req = GetDocsRequest(iD: id);
      return await GrpcClient.subtypeStub.getDocs(req);
    } catch (e) {
      log(e.toString());
      throw SubtypeDataProviderError();
    }
  }
}
