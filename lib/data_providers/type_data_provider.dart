import 'package:flutter/services.dart';

import 'package:read_only/domain/entity/type.dart';
import 'package:read_only/domain/service/type_service.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/pb/reader/service.pbgrpc.dart';

class TypeDataProviderDefault implements TypeDataProvider {
  TypeDataProviderDefault({required this.grpcClient})
      : _typeGRPCClient = TypeGRPCClient(grpcClient.channel());
  final GrpcClient grpcClient;
  final TypeGRPCClient _typeGRPCClient;

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
      GetAllTypesResponse resp = await _typeGRPCClient.getAll(Empty());
      // Mapping
      List<ReadOnlyType> types = resp.types
          .map((e) => ReadOnlyType(id: e.iD.toInt(), name: e.name))
          .toList();
      return types;
    } catch (e) {
      throw PlatformException(code: "get_all_type_error", details: e);
    }
  }
}
