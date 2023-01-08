import 'dart:developer';

import 'package:read_only/data_providers/grpc/pb/reader/service.pb.dart';

import '../../library/grpc_client/grpc_client.dart';

class TypeDataProviderError {}

class TypeDataProvider {
  final GrpcClient client;

  const TypeDataProvider({required this.client});

  Future<List<TypeResponse>> getAll() async {
    try {
      GetAllTypesResponse resp = await client.typeStub.getAll(Empty());
      return resp.types;
    } catch (e) {
      log(e.toString());
      throw TypeDataProviderError();
    }
  }
}
