///
//  Generated code. Do not modify.
//  source: reader/service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'service.pb.dart' as $0;
export 'service.pb.dart';

class TypeGRPCClient extends $grpc.Client {
  static final _$getAll = $grpc.ClientMethod<$0.Empty, $0.GetAllTypesResponse>(
      '/reader.v1.TypeGRPC/GetAll',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAllTypesResponse.fromBuffer(value));

  TypeGRPCClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetAllTypesResponse> getAll($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }
}

abstract class TypeGRPCServiceBase extends $grpc.Service {
  $core.String get $name => 'reader.v1.TypeGRPC';

  TypeGRPCServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.GetAllTypesResponse>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.GetAllTypesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetAllTypesResponse> getAll_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getAll(call, await request);
  }

  $async.Future<$0.GetAllTypesResponse> getAll(
      $grpc.ServiceCall call, $0.Empty request);
}

class SubGRPCClient extends $grpc.Client {
  static final _$getAll =
      $grpc.ClientMethod<$0.GetAllSubtypesRequest, $0.GetAllSubtypesResponse>(
          '/reader.v1.SubGRPC/GetAll',
          ($0.GetAllSubtypesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetAllSubtypesResponse.fromBuffer(value));
  static final _$getDocs =
      $grpc.ClientMethod<$0.GetDocsRequest, $0.GetDocsResponse>(
          '/reader.v1.SubGRPC/GetDocs',
          ($0.GetDocsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetDocsResponse.fromBuffer(value));

  SubGRPCClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetAllSubtypesResponse> getAll(
      $0.GetAllSubtypesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetDocsResponse> getDocs($0.GetDocsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDocs, request, options: options);
  }
}

abstract class SubGRPCServiceBase extends $grpc.Service {
  $core.String get $name => 'reader.v1.SubGRPC';

  SubGRPCServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetAllSubtypesRequest,
            $0.GetAllSubtypesResponse>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAllSubtypesRequest.fromBuffer(value),
        ($0.GetAllSubtypesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetDocsRequest, $0.GetDocsResponse>(
        'GetDocs',
        getDocs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetDocsRequest.fromBuffer(value),
        ($0.GetDocsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetAllSubtypesResponse> getAll_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetAllSubtypesRequest> request) async {
    return getAll(call, await request);
  }

  $async.Future<$0.GetDocsResponse> getDocs_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetDocsRequest> request) async {
    return getDocs(call, await request);
  }

  $async.Future<$0.GetAllSubtypesResponse> getAll(
      $grpc.ServiceCall call, $0.GetAllSubtypesRequest request);
  $async.Future<$0.GetDocsResponse> getDocs(
      $grpc.ServiceCall call, $0.GetDocsRequest request);
}

class DocGRPCClient extends $grpc.Client {
  static final _$getOne =
      $grpc.ClientMethod<$0.GetOneDocRequest, $0.GetOneDocResponse>(
          '/reader.v1.DocGRPC/GetOne',
          ($0.GetOneDocRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetOneDocResponse.fromBuffer(value));
  static final _$getEntireDoc =
      $grpc.ClientMethod<$0.GetEntireDocRequest, $0.GetEntireDocResponse>(
          '/reader.v1.DocGRPC/GetEntireDoc',
          ($0.GetEntireDocRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetEntireDocResponse.fromBuffer(value));

  DocGRPCClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetOneDocResponse> getOne($0.GetOneDocRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOne, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetEntireDocResponse> getEntireDoc(
      $0.GetEntireDocRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEntireDoc, request, options: options);
  }
}

abstract class DocGRPCServiceBase extends $grpc.Service {
  $core.String get $name => 'reader.v1.DocGRPC';

  DocGRPCServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetOneDocRequest, $0.GetOneDocResponse>(
        'GetOne',
        getOne_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOneDocRequest.fromBuffer(value),
        ($0.GetOneDocResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetEntireDocRequest, $0.GetEntireDocResponse>(
            'GetEntireDoc',
            getEntireDoc_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetEntireDocRequest.fromBuffer(value),
            ($0.GetEntireDocResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetOneDocResponse> getOne_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetOneDocRequest> request) async {
    return getOne(call, await request);
  }

  $async.Future<$0.GetEntireDocResponse> getEntireDoc_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetEntireDocRequest> request) async {
    return getEntireDoc(call, await request);
  }

  $async.Future<$0.GetOneDocResponse> getOne(
      $grpc.ServiceCall call, $0.GetOneDocRequest request);
  $async.Future<$0.GetEntireDocResponse> getEntireDoc(
      $grpc.ServiceCall call, $0.GetEntireDocRequest request);
}

class ChapterGRPCClient extends $grpc.Client {
  static final _$getOne =
      $grpc.ClientMethod<$0.GetOneChapterRequest, $0.GetOneChapterResponse>(
          '/reader.v1.ChapterGRPC/GetOne',
          ($0.GetOneChapterRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetOneChapterResponse.fromBuffer(value));
  static final _$getWithNeighbors = $grpc.ClientMethod<
          $0.GetWithNeighborsRequest, $0.GetWithNeighborsResponse>(
      '/reader.v1.ChapterGRPC/GetWithNeighbors',
      ($0.GetWithNeighborsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetWithNeighborsResponse.fromBuffer(value));
  static final _$getAll = $grpc.ClientMethod<$0.GetAllChaptersByDocIdRequest,
          $0.GetAllChaptersByDocIdResponse>(
      '/reader.v1.ChapterGRPC/GetAll',
      ($0.GetAllChaptersByDocIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAllChaptersByDocIdResponse.fromBuffer(value));

  ChapterGRPCClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetOneChapterResponse> getOne(
      $0.GetOneChapterRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOne, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetWithNeighborsResponse> getWithNeighbors(
      $0.GetWithNeighborsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWithNeighbors, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAllChaptersByDocIdResponse> getAll(
      $0.GetAllChaptersByDocIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }
}

abstract class ChapterGRPCServiceBase extends $grpc.Service {
  $core.String get $name => 'reader.v1.ChapterGRPC';

  ChapterGRPCServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.GetOneChapterRequest, $0.GetOneChapterResponse>(
            'GetOne',
            getOne_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetOneChapterRequest.fromBuffer(value),
            ($0.GetOneChapterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWithNeighborsRequest,
            $0.GetWithNeighborsResponse>(
        'GetWithNeighbors',
        getWithNeighbors_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWithNeighborsRequest.fromBuffer(value),
        ($0.GetWithNeighborsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAllChaptersByDocIdRequest,
            $0.GetAllChaptersByDocIdResponse>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAllChaptersByDocIdRequest.fromBuffer(value),
        ($0.GetAllChaptersByDocIdResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetOneChapterResponse> getOne_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetOneChapterRequest> request) async {
    return getOne(call, await request);
  }

  $async.Future<$0.GetWithNeighborsResponse> getWithNeighbors_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetWithNeighborsRequest> request) async {
    return getWithNeighbors(call, await request);
  }

  $async.Future<$0.GetAllChaptersByDocIdResponse> getAll_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAllChaptersByDocIdRequest> request) async {
    return getAll(call, await request);
  }

  $async.Future<$0.GetOneChapterResponse> getOne(
      $grpc.ServiceCall call, $0.GetOneChapterRequest request);
  $async.Future<$0.GetWithNeighborsResponse> getWithNeighbors(
      $grpc.ServiceCall call, $0.GetWithNeighborsRequest request);
  $async.Future<$0.GetAllChaptersByDocIdResponse> getAll(
      $grpc.ServiceCall call, $0.GetAllChaptersByDocIdRequest request);
}

class ParagraphGRPCClient extends $grpc.Client {
  static final _$getAll = $grpc.ClientMethod<
          $0.GetAllParagraphsByChapterIdRequest,
          $0.GetAllParagraphsByChapterIdResponse>(
      '/reader.v1.ParagraphGRPC/GetAll',
      ($0.GetAllParagraphsByChapterIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAllParagraphsByChapterIdResponse.fromBuffer(value));

  ParagraphGRPCClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetAllParagraphsByChapterIdResponse> getAll(
      $0.GetAllParagraphsByChapterIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }
}

abstract class ParagraphGRPCServiceBase extends $grpc.Service {
  $core.String get $name => 'reader.v1.ParagraphGRPC';

  ParagraphGRPCServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetAllParagraphsByChapterIdRequest,
            $0.GetAllParagraphsByChapterIdResponse>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAllParagraphsByChapterIdRequest.fromBuffer(value),
        ($0.GetAllParagraphsByChapterIdResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$0.GetAllParagraphsByChapterIdResponse> getAll_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAllParagraphsByChapterIdRequest> request) async {
    return getAll(call, await request);
  }

  $async.Future<$0.GetAllParagraphsByChapterIdResponse> getAll(
      $grpc.ServiceCall call, $0.GetAllParagraphsByChapterIdRequest request);
}
