import 'dart:developer';

import 'package:read_only/data_providers/grpc/pb/reader/service.pb.dart';

import '../../library/grpc_client/grpc_client.dart';
import 'package:fixnum/fixnum.dart';

class SubtypeDataProviderError {}

class SubtypeDataProvider {
  final GrpcClient client;

  const SubtypeDataProvider({required this.client});

  Future<GetAllSubtypesResponse> getAll(Int64 id) async {
    try {
      GetAllSubtypesRequest req = GetAllSubtypesRequest(iD: id);
      return await client.subtypeStub.getAll(req);
    } catch (e) {
      log(e.toString());
      throw SubtypeDataProviderError();
    }
  }
}
