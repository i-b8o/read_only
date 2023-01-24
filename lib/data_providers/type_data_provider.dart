import 'dart:developer';

import 'package:read_only/domain/entity/type.dart';
import 'package:read_only/domain/service/type_service.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import '../../library/grpc_client/grpc_client.dart';

class TypeDataProviderError {
  final String m;

  TypeDataProviderError(this.m);
}

class GrpcTypeDataProvider implements TypeDataProvider {
  const GrpcTypeDataProvider();

  @override
  Future<List<ReadOnlyType>> getAll() async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   print(m);
    //   // catch exceptions
    //   throw TypeDataProviderError(m);
    // }
    try {
      // Request
      GetAllTypesResponse resp = await GrpcClient.typeStub.getAll(Empty());
      // Mapping
      List<ReadOnlyType> types = resp.types
          .map((e) => ReadOnlyType(id: e.iD.toInt(), name: e.name))
          .toList();
      return types;
    } catch (e) {
      log(e.toString());
      throw TypeDataProviderError(e.toString());
    }
  }
}
