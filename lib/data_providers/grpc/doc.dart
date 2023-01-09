import 'dart:developer';

import 'package:fixnum/fixnum.dart';

import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

class DocDataProviderError {}

class DocDataProvider {
  final GrpcClient client;

  const DocDataProvider({required this.client});

  Future<GetOneDocResponse> getOne(Int64 id) async {
    try {
      GetOneDocRequest req = GetOneDocRequest(iD: id);
      return await client.docStub.getOne(req);
    } catch (e) {
      log(e.toString());
      throw DocDataProviderError();
    }
  }

  Future<GetDocsResponse> getDocs(Int64 id) async {
    try {
      GetDocsRequest req = GetDocsRequest(iD: id);
      return await client.subtypeStub.getDocs(req);
    } catch (e) {
      log(e.toString());
      throw DocDataProviderError();
    }
  }
}
