import 'package:flutter/services.dart';

import 'package:read_only/domain/entity/type.dart' as domain_type;
import 'package:read_only/domain/service/type_service.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/pb/reader/service.pbgrpc.dart';

class TypeDataProviderDefault implements TypeDataProvider {
  TypeDataProviderDefault()
      : _typeGRPCClient = TypeGRPCClient(GrpcClient().channel());

  final TypeGRPCClient _typeGRPCClient;

  @override
  Future<List<domain_type.Type>> getAll() async {
    try {
      // Request
      GetAllTypesResponse resp = await _typeGRPCClient.getAll(Empty());
      // Mapping
      List<domain_type.Type> types = resp.types
          .map((e) => domain_type.Type(id: e.iD.toInt(), name: e.name))
          .toList();
      return types;
    } catch (e) {
      print("An error occurred while getting all types: $e");
      return []; // Return an empty list if an error occurred
    }
  }
}
