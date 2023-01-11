import 'dart:developer';

import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import '../../library/grpc_client/grpc_client.dart';

class TypeDataProviderError {
  final String m;

  TypeDataProviderError(this.m);
}

class TypeDataProvider {
  const TypeDataProvider();

  Future<GetAllTypesResponse> getAll() async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   print(m);
    //   // catch exceptions
    //   throw TypeDataProviderError(m);
    // }
    try {
      GetAllTypesResponse resp = await GrpcClient.typeStub.getAll(Empty());
      return resp;
    } catch (e) {
      log(e.toString());
      throw TypeDataProviderError(e.toString());
    }
  }
}
