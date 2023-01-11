import 'dart:developer';

import 'package:fixnum/fixnum.dart';

import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

class DocDataProviderError {
  final String m;

  DocDataProviderError(this.m);
}

class DocDataProvider {
  const DocDataProvider();

  Future<GetOneDocResponse> getOne(Int64 id) async {
    // String? m = GrpcClient.check();
    // if (m != null) {
    //   throw DocDataProviderError(m);
    // }
    try {
      GetOneDocRequest req = GetOneDocRequest(iD: id);
      return await GrpcClient.docStub.getOne(req);
    } catch (e) {
      throw DocDataProviderError(e.toString());
    }
  }
}
