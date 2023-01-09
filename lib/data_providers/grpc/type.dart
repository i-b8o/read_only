import 'dart:developer';

import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import '../../library/grpc_client/grpc_client.dart';

class TypeDataProviderError {}

class TypeDataProvider {
  final GrpcClient client;

  const TypeDataProvider({required this.client});

  Future<GetAllTypesResponse> getAll() async {
    try {
      GetAllTypesResponse resp = await client.typeStub.getAll(Empty());
      return resp;
    } catch (e) {
      log(e.toString());
      throw TypeDataProviderError();
    }
  }
}
