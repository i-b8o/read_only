import 'dart:developer';

import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import '../../library/grpc_client/grpc_client.dart';

class TypeDataProviderError {}

class TypeDataProvider {
  const TypeDataProvider();

  Future<GetAllTypesResponse> getAll() async {
    try {
      GetAllTypesResponse resp = await GrpcClient.typeStub.getAll(Empty());
      return resp;
    } catch (e) {
      log(e.toString());
      throw TypeDataProviderError();
    }
  }
}
