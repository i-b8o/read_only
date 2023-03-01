///
//  Generated code. Do not modify.
//  source: searcher/service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'service.pb.dart' as $0;
export 'service.pb.dart';

class SearcherGRPCClient extends $grpc.Client {
  static final _$search =
      $grpc.ClientMethod<$0.SearchRequest, $0.SearchResponseMessage>(
          '/searcher.v1.SearcherGRPC/Search',
          ($0.SearchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SearchResponseMessage.fromBuffer(value));

  SearcherGRPCClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SearchResponseMessage> search(
      $0.SearchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$search, request, options: options);
  }
}

abstract class SearcherGRPCServiceBase extends $grpc.Service {
  $core.String get $name => 'searcher.v1.SearcherGRPC';

  SearcherGRPCServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SearchRequest, $0.SearchResponseMessage>(
        'Search',
        search_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchRequest.fromBuffer(value),
        ($0.SearchResponseMessage value) => value.writeToBuffer()));
  }

  $async.Future<$0.SearchResponseMessage> search_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SearchRequest> request) async {
    return search(call, await request);
  }

  $async.Future<$0.SearchResponseMessage> search(
      $grpc.ServiceCall call, $0.SearchRequest request);
}
