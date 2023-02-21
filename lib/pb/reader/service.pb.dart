///
//  Generated code. Do not modify.
//  source: reader/service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'timestamp.pb.dart' as $1;

class Empty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Empty',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  Empty._() : super();
  factory Empty() => create();
  factory Empty.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) =>
      super.copyWith((message) => updates(message as Empty))
          as Empty; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class TypeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'TypeResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Name',
        protoName: 'Name')
    ..hasRequiredFields = false;

  TypeResponse._() : super();
  factory TypeResponse({
    $fixnum.Int64? iD,
    $core.String? name,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory TypeResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TypeResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TypeResponse clone() => TypeResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TypeResponse copyWith(void Function(TypeResponse) updates) =>
      super.copyWith((message) => updates(message as TypeResponse))
          as TypeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TypeResponse create() => TypeResponse._();
  TypeResponse createEmptyInstance() => create();
  static $pb.PbList<TypeResponse> createRepeated() =>
      $pb.PbList<TypeResponse>();
  @$core.pragma('dart2js:noInline')
  static TypeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TypeResponse>(create);
  static TypeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class GetAllTypesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetAllTypesResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..pc<TypeResponse>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Types',
        $pb.PbFieldType.PM,
        protoName: 'Types',
        subBuilder: TypeResponse.create)
    ..hasRequiredFields = false;

  GetAllTypesResponse._() : super();
  factory GetAllTypesResponse({
    $core.Iterable<TypeResponse>? types,
  }) {
    final _result = create();
    if (types != null) {
      _result.types.addAll(types);
    }
    return _result;
  }
  factory GetAllTypesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAllTypesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAllTypesResponse clone() => GetAllTypesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAllTypesResponse copyWith(void Function(GetAllTypesResponse) updates) =>
      super.copyWith((message) => updates(message as GetAllTypesResponse))
          as GetAllTypesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAllTypesResponse create() => GetAllTypesResponse._();
  GetAllTypesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllTypesResponse> createRepeated() =>
      $pb.PbList<GetAllTypesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllTypesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAllTypesResponse>(create);
  static GetAllTypesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TypeResponse> get types => $_getList(0);
}

class GetAllSubtypesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetAllSubtypesRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  GetAllSubtypesRequest._() : super();
  factory GetAllSubtypesRequest({
    $fixnum.Int64? iD,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    return _result;
  }
  factory GetAllSubtypesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAllSubtypesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAllSubtypesRequest clone() =>
      GetAllSubtypesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAllSubtypesRequest copyWith(
          void Function(GetAllSubtypesRequest) updates) =>
      super.copyWith((message) => updates(message as GetAllSubtypesRequest))
          as GetAllSubtypesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAllSubtypesRequest create() => GetAllSubtypesRequest._();
  GetAllSubtypesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAllSubtypesRequest> createRepeated() =>
      $pb.PbList<GetAllSubtypesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAllSubtypesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAllSubtypesRequest>(create);
  static GetAllSubtypesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);
}

class SubtypeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SubtypeResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Name',
        protoName: 'Name')
    ..hasRequiredFields = false;

  SubtypeResponse._() : super();
  factory SubtypeResponse({
    $fixnum.Int64? iD,
    $core.String? name,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory SubtypeResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubtypeResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SubtypeResponse clone() => SubtypeResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SubtypeResponse copyWith(void Function(SubtypeResponse) updates) =>
      super.copyWith((message) => updates(message as SubtypeResponse))
          as SubtypeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SubtypeResponse create() => SubtypeResponse._();
  SubtypeResponse createEmptyInstance() => create();
  static $pb.PbList<SubtypeResponse> createRepeated() =>
      $pb.PbList<SubtypeResponse>();
  @$core.pragma('dart2js:noInline')
  static SubtypeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubtypeResponse>(create);
  static SubtypeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class GetAllSubtypesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetAllSubtypesResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..pc<SubtypeResponse>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Subtypes',
        $pb.PbFieldType.PM,
        protoName: 'Subtypes',
        subBuilder: SubtypeResponse.create)
    ..hasRequiredFields = false;

  GetAllSubtypesResponse._() : super();
  factory GetAllSubtypesResponse({
    $core.Iterable<SubtypeResponse>? subtypes,
  }) {
    final _result = create();
    if (subtypes != null) {
      _result.subtypes.addAll(subtypes);
    }
    return _result;
  }
  factory GetAllSubtypesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAllSubtypesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAllSubtypesResponse clone() =>
      GetAllSubtypesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAllSubtypesResponse copyWith(
          void Function(GetAllSubtypesResponse) updates) =>
      super.copyWith((message) => updates(message as GetAllSubtypesResponse))
          as GetAllSubtypesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAllSubtypesResponse create() => GetAllSubtypesResponse._();
  GetAllSubtypesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllSubtypesResponse> createRepeated() =>
      $pb.PbList<GetAllSubtypesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllSubtypesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAllSubtypesResponse>(create);
  static GetAllSubtypesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SubtypeResponse> get subtypes => $_getList(0);
}

class GetDocsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetDocsRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  GetDocsRequest._() : super();
  factory GetDocsRequest({
    $fixnum.Int64? iD,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    return _result;
  }
  factory GetDocsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetDocsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetDocsRequest clone() => GetDocsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetDocsRequest copyWith(void Function(GetDocsRequest) updates) =>
      super.copyWith((message) => updates(message as GetDocsRequest))
          as GetDocsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDocsRequest create() => GetDocsRequest._();
  GetDocsRequest createEmptyInstance() => create();
  static $pb.PbList<GetDocsRequest> createRepeated() =>
      $pb.PbList<GetDocsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDocsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDocsRequest>(create);
  static GetDocsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);
}

class Doc extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Doc',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Name',
        protoName: 'Name')
    ..hasRequiredFields = false;

  Doc._() : super();
  factory Doc({
    $fixnum.Int64? iD,
    $core.String? name,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory Doc.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Doc.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Doc clone() => Doc()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Doc copyWith(void Function(Doc) updates) =>
      super.copyWith((message) => updates(message as Doc))
          as Doc; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Doc create() => Doc._();
  Doc createEmptyInstance() => create();
  static $pb.PbList<Doc> createRepeated() => $pb.PbList<Doc>();
  @$core.pragma('dart2js:noInline')
  static Doc getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Doc>(create);
  static Doc? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class GetDocsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetDocsResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..pc<Doc>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Docs',
        $pb.PbFieldType.PM,
        protoName: 'Docs',
        subBuilder: Doc.create)
    ..hasRequiredFields = false;

  GetDocsResponse._() : super();
  factory GetDocsResponse({
    $core.Iterable<Doc>? docs,
  }) {
    final _result = create();
    if (docs != null) {
      _result.docs.addAll(docs);
    }
    return _result;
  }
  factory GetDocsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetDocsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetDocsResponse clone() => GetDocsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetDocsResponse copyWith(void Function(GetDocsResponse) updates) =>
      super.copyWith((message) => updates(message as GetDocsResponse))
          as GetDocsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetDocsResponse create() => GetDocsResponse._();
  GetDocsResponse createEmptyInstance() => create();
  static $pb.PbList<GetDocsResponse> createRepeated() =>
      $pb.PbList<GetDocsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDocsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDocsResponse>(create);
  static GetDocsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Doc> get docs => $_getList(0);
}

class ReaderParagraph extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ReaderParagraph',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Num',
        $pb.PbFieldType.OU3,
        protoName: 'Num')
    ..aOB(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'HasLinks',
        protoName: 'HasLinks')
    ..aOB(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'IsTable',
        protoName: 'IsTable')
    ..aOB(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'IsNFT',
        protoName: 'IsNFT')
    ..aOS(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Class',
        protoName: 'Class')
    ..aOS(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Content',
        protoName: 'Content')
    ..a<$fixnum.Int64>(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ChapterID',
        $pb.PbFieldType.OU6,
        protoName: 'ChapterID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  ReaderParagraph._() : super();
  factory ReaderParagraph({
    $fixnum.Int64? iD,
    $core.int? num,
    $core.bool? hasLinks,
    $core.bool? isTable,
    $core.bool? isNFT,
    $core.String? class_6,
    $core.String? content,
    $fixnum.Int64? chapterID,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    if (num != null) {
      _result.num = num;
    }
    if (hasLinks != null) {
      _result.hasLinks = hasLinks;
    }
    if (isTable != null) {
      _result.isTable = isTable;
    }
    if (isNFT != null) {
      _result.isNFT = isNFT;
    }
    if (class_6 != null) {
      _result.class_6 = class_6;
    }
    if (content != null) {
      _result.content = content;
    }
    if (chapterID != null) {
      _result.chapterID = chapterID;
    }
    return _result;
  }
  factory ReaderParagraph.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReaderParagraph.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReaderParagraph clone() => ReaderParagraph()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReaderParagraph copyWith(void Function(ReaderParagraph) updates) =>
      super.copyWith((message) => updates(message as ReaderParagraph))
          as ReaderParagraph; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReaderParagraph create() => ReaderParagraph._();
  ReaderParagraph createEmptyInstance() => create();
  static $pb.PbList<ReaderParagraph> createRepeated() =>
      $pb.PbList<ReaderParagraph>();
  @$core.pragma('dart2js:noInline')
  static ReaderParagraph getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReaderParagraph>(create);
  static ReaderParagraph? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get num => $_getIZ(1);
  @$pb.TagNumber(2)
  set num($core.int v) {
    $_setUnsignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNum() => $_has(1);
  @$pb.TagNumber(2)
  void clearNum() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get hasLinks => $_getBF(2);
  @$pb.TagNumber(3)
  set hasLinks($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasHasLinks() => $_has(2);
  @$pb.TagNumber(3)
  void clearHasLinks() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isTable => $_getBF(3);
  @$pb.TagNumber(4)
  set isTable($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIsTable() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsTable() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isNFT => $_getBF(4);
  @$pb.TagNumber(5)
  set isNFT($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasIsNFT() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsNFT() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get class_6 => $_getSZ(5);
  @$pb.TagNumber(6)
  set class_6($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasClass_6() => $_has(5);
  @$pb.TagNumber(6)
  void clearClass_6() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get content => $_getSZ(6);
  @$pb.TagNumber(7)
  set content($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasContent() => $_has(6);
  @$pb.TagNumber(7)
  void clearContent() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get chapterID => $_getI64(7);
  @$pb.TagNumber(8)
  set chapterID($fixnum.Int64 v) {
    $_setInt64(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasChapterID() => $_has(7);
  @$pb.TagNumber(8)
  void clearChapterID() => clearField(8);
}

class GetOneDocRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetOneDocRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  GetOneDocRequest._() : super();
  factory GetOneDocRequest({
    $fixnum.Int64? iD,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    return _result;
  }
  factory GetOneDocRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetOneDocRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetOneDocRequest clone() => GetOneDocRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetOneDocRequest copyWith(void Function(GetOneDocRequest) updates) =>
      super.copyWith((message) => updates(message as GetOneDocRequest))
          as GetOneDocRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOneDocRequest create() => GetOneDocRequest._();
  GetOneDocRequest createEmptyInstance() => create();
  static $pb.PbList<GetOneDocRequest> createRepeated() =>
      $pb.PbList<GetOneDocRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOneDocRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOneDocRequest>(create);
  static GetOneDocRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);
}

class Chapter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Chapter',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Name',
        protoName: 'Name')
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'OrderNum',
        $pb.PbFieldType.OU3,
        protoName: 'OrderNum')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Num',
        protoName: 'Num')
    ..hasRequiredFields = false;

  Chapter._() : super();
  factory Chapter({
    $fixnum.Int64? iD,
    $core.String? name,
    $core.int? orderNum,
    $core.String? num,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    if (name != null) {
      _result.name = name;
    }
    if (orderNum != null) {
      _result.orderNum = orderNum;
    }
    if (num != null) {
      _result.num = num;
    }
    return _result;
  }
  factory Chapter.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Chapter.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Chapter clone() => Chapter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Chapter copyWith(void Function(Chapter) updates) =>
      super.copyWith((message) => updates(message as Chapter))
          as Chapter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Chapter create() => Chapter._();
  Chapter createEmptyInstance() => create();
  static $pb.PbList<Chapter> createRepeated() => $pb.PbList<Chapter>();
  @$core.pragma('dart2js:noInline')
  static Chapter getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chapter>(create);
  static Chapter? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get orderNum => $_getIZ(2);
  @$pb.TagNumber(3)
  set orderNum($core.int v) {
    $_setUnsignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOrderNum() => $_has(2);
  @$pb.TagNumber(3)
  void clearOrderNum() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get num => $_getSZ(3);
  @$pb.TagNumber(4)
  set num($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasNum() => $_has(3);
  @$pb.TagNumber(4)
  void clearNum() => clearField(4);
}

class GetOneDocResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetOneDocResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Name',
        protoName: 'Name')
    ..pc<Chapter>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'chapters',
        $pb.PbFieldType.PM,
        subBuilder: Chapter.create)
    ..hasRequiredFields = false;

  GetOneDocResponse._() : super();
  factory GetOneDocResponse({
    $core.String? name,
    $core.Iterable<Chapter>? chapters,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (chapters != null) {
      _result.chapters.addAll(chapters);
    }
    return _result;
  }
  factory GetOneDocResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetOneDocResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetOneDocResponse clone() => GetOneDocResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetOneDocResponse copyWith(void Function(GetOneDocResponse) updates) =>
      super.copyWith((message) => updates(message as GetOneDocResponse))
          as GetOneDocResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOneDocResponse create() => GetOneDocResponse._();
  GetOneDocResponse createEmptyInstance() => create();
  static $pb.PbList<GetOneDocResponse> createRepeated() =>
      $pb.PbList<GetOneDocResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOneDocResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOneDocResponse>(create);
  static GetOneDocResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Chapter> get chapters => $_getList(1);
}

class GetOneChapterRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetOneChapterRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  GetOneChapterRequest._() : super();
  factory GetOneChapterRequest({
    $fixnum.Int64? iD,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    return _result;
  }
  factory GetOneChapterRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetOneChapterRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetOneChapterRequest clone() =>
      GetOneChapterRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetOneChapterRequest copyWith(void Function(GetOneChapterRequest) updates) =>
      super.copyWith((message) => updates(message as GetOneChapterRequest))
          as GetOneChapterRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOneChapterRequest create() => GetOneChapterRequest._();
  GetOneChapterRequest createEmptyInstance() => create();
  static $pb.PbList<GetOneChapterRequest> createRepeated() =>
      $pb.PbList<GetOneChapterRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOneChapterRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOneChapterRequest>(create);
  static GetOneChapterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);
}

class GetOneChapterResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetOneChapterResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Name',
        protoName: 'Name')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Num',
        protoName: 'Num')
    ..a<$fixnum.Int64>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'DocID',
        $pb.PbFieldType.OU6,
        protoName: 'DocID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'OrderNum',
        $pb.PbFieldType.OU3,
        protoName: 'OrderNum')
    ..pc<ReaderParagraph>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Paragraphs',
        $pb.PbFieldType.PM,
        protoName: 'Paragraphs',
        subBuilder: ReaderParagraph.create)
    ..hasRequiredFields = false;

  GetOneChapterResponse._() : super();
  factory GetOneChapterResponse({
    $fixnum.Int64? iD,
    $core.String? name,
    $core.String? num,
    $fixnum.Int64? docID,
    $core.int? orderNum,
    $core.Iterable<ReaderParagraph>? paragraphs,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    if (name != null) {
      _result.name = name;
    }
    if (num != null) {
      _result.num = num;
    }
    if (docID != null) {
      _result.docID = docID;
    }
    if (orderNum != null) {
      _result.orderNum = orderNum;
    }
    if (paragraphs != null) {
      _result.paragraphs.addAll(paragraphs);
    }
    return _result;
  }
  factory GetOneChapterResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetOneChapterResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetOneChapterResponse clone() =>
      GetOneChapterResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetOneChapterResponse copyWith(
          void Function(GetOneChapterResponse) updates) =>
      super.copyWith((message) => updates(message as GetOneChapterResponse))
          as GetOneChapterResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOneChapterResponse create() => GetOneChapterResponse._();
  GetOneChapterResponse createEmptyInstance() => create();
  static $pb.PbList<GetOneChapterResponse> createRepeated() =>
      $pb.PbList<GetOneChapterResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOneChapterResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOneChapterResponse>(create);
  static GetOneChapterResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get num => $_getSZ(2);
  @$pb.TagNumber(3)
  set num($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNum() => $_has(2);
  @$pb.TagNumber(3)
  void clearNum() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get docID => $_getI64(3);
  @$pb.TagNumber(4)
  set docID($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDocID() => $_has(3);
  @$pb.TagNumber(4)
  void clearDocID() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get orderNum => $_getIZ(4);
  @$pb.TagNumber(5)
  set orderNum($core.int v) {
    $_setUnsignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasOrderNum() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderNum() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<ReaderParagraph> get paragraphs => $_getList(5);
}

class ReaderChapter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ReaderChapter',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Name',
        protoName: 'Name')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Num',
        protoName: 'Num')
    ..a<$fixnum.Int64>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'DocID',
        $pb.PbFieldType.OU6,
        protoName: 'DocID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'OrderNum',
        $pb.PbFieldType.OU3,
        protoName: 'OrderNum')
    ..aOM<$1.Timestamp>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'UpdatedAt',
        protoName: 'UpdatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  ReaderChapter._() : super();
  factory ReaderChapter({
    $fixnum.Int64? iD,
    $core.String? name,
    $core.String? num,
    $fixnum.Int64? docID,
    $core.int? orderNum,
    $1.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    if (name != null) {
      _result.name = name;
    }
    if (num != null) {
      _result.num = num;
    }
    if (docID != null) {
      _result.docID = docID;
    }
    if (orderNum != null) {
      _result.orderNum = orderNum;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory ReaderChapter.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReaderChapter.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReaderChapter clone() => ReaderChapter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReaderChapter copyWith(void Function(ReaderChapter) updates) =>
      super.copyWith((message) => updates(message as ReaderChapter))
          as ReaderChapter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReaderChapter create() => ReaderChapter._();
  ReaderChapter createEmptyInstance() => create();
  static $pb.PbList<ReaderChapter> createRepeated() =>
      $pb.PbList<ReaderChapter>();
  @$core.pragma('dart2js:noInline')
  static ReaderChapter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReaderChapter>(create);
  static ReaderChapter? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get num => $_getSZ(2);
  @$pb.TagNumber(3)
  set num($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNum() => $_has(2);
  @$pb.TagNumber(3)
  void clearNum() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get docID => $_getI64(3);
  @$pb.TagNumber(4)
  set docID($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDocID() => $_has(3);
  @$pb.TagNumber(4)
  void clearDocID() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get orderNum => $_getIZ(4);
  @$pb.TagNumber(5)
  set orderNum($core.int v) {
    $_setUnsignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasOrderNum() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderNum() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get updatedAt => $_getN(5);
  @$pb.TagNumber(6)
  set updatedAt($1.Timestamp v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureUpdatedAt() => $_ensure(5);
}

class GetAllChaptersByDocIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetAllChaptersByDocIdRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  GetAllChaptersByDocIdRequest._() : super();
  factory GetAllChaptersByDocIdRequest({
    $fixnum.Int64? iD,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    return _result;
  }
  factory GetAllChaptersByDocIdRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAllChaptersByDocIdRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAllChaptersByDocIdRequest clone() =>
      GetAllChaptersByDocIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAllChaptersByDocIdRequest copyWith(
          void Function(GetAllChaptersByDocIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAllChaptersByDocIdRequest))
          as GetAllChaptersByDocIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAllChaptersByDocIdRequest create() =>
      GetAllChaptersByDocIdRequest._();
  GetAllChaptersByDocIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetAllChaptersByDocIdRequest> createRepeated() =>
      $pb.PbList<GetAllChaptersByDocIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAllChaptersByDocIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAllChaptersByDocIdRequest>(create);
  static GetAllChaptersByDocIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);
}

class GetAllChaptersByDocIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetAllChaptersByDocIdResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..pc<ReaderChapter>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Chapters',
        $pb.PbFieldType.PM,
        protoName: 'Chapters',
        subBuilder: ReaderChapter.create)
    ..hasRequiredFields = false;

  GetAllChaptersByDocIdResponse._() : super();
  factory GetAllChaptersByDocIdResponse({
    $core.Iterable<ReaderChapter>? chapters,
  }) {
    final _result = create();
    if (chapters != null) {
      _result.chapters.addAll(chapters);
    }
    return _result;
  }
  factory GetAllChaptersByDocIdResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAllChaptersByDocIdResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAllChaptersByDocIdResponse clone() =>
      GetAllChaptersByDocIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAllChaptersByDocIdResponse copyWith(
          void Function(GetAllChaptersByDocIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAllChaptersByDocIdResponse))
          as GetAllChaptersByDocIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAllChaptersByDocIdResponse create() =>
      GetAllChaptersByDocIdResponse._();
  GetAllChaptersByDocIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllChaptersByDocIdResponse> createRepeated() =>
      $pb.PbList<GetAllChaptersByDocIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllChaptersByDocIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAllChaptersByDocIdResponse>(create);
  static GetAllChaptersByDocIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ReaderChapter> get chapters => $_getList(0);
}

class GetAllParagraphsByChapterIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetAllParagraphsByChapterIdRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  GetAllParagraphsByChapterIdRequest._() : super();
  factory GetAllParagraphsByChapterIdRequest({
    $fixnum.Int64? iD,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    return _result;
  }
  factory GetAllParagraphsByChapterIdRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAllParagraphsByChapterIdRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAllParagraphsByChapterIdRequest clone() =>
      GetAllParagraphsByChapterIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAllParagraphsByChapterIdRequest copyWith(
          void Function(GetAllParagraphsByChapterIdRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetAllParagraphsByChapterIdRequest))
          as GetAllParagraphsByChapterIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAllParagraphsByChapterIdRequest create() =>
      GetAllParagraphsByChapterIdRequest._();
  GetAllParagraphsByChapterIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetAllParagraphsByChapterIdRequest> createRepeated() =>
      $pb.PbList<GetAllParagraphsByChapterIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAllParagraphsByChapterIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAllParagraphsByChapterIdRequest>(
          create);
  static GetAllParagraphsByChapterIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);
}

class GetAllParagraphsByChapterIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetAllParagraphsByChapterIdResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..pc<ReaderParagraph>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Paragraphs',
        $pb.PbFieldType.PM,
        protoName: 'Paragraphs',
        subBuilder: ReaderParagraph.create)
    ..hasRequiredFields = false;

  GetAllParagraphsByChapterIdResponse._() : super();
  factory GetAllParagraphsByChapterIdResponse({
    $core.Iterable<ReaderParagraph>? paragraphs,
  }) {
    final _result = create();
    if (paragraphs != null) {
      _result.paragraphs.addAll(paragraphs);
    }
    return _result;
  }
  factory GetAllParagraphsByChapterIdResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAllParagraphsByChapterIdResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAllParagraphsByChapterIdResponse clone() =>
      GetAllParagraphsByChapterIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAllParagraphsByChapterIdResponse copyWith(
          void Function(GetAllParagraphsByChapterIdResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetAllParagraphsByChapterIdResponse))
          as GetAllParagraphsByChapterIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAllParagraphsByChapterIdResponse create() =>
      GetAllParagraphsByChapterIdResponse._();
  GetAllParagraphsByChapterIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetAllParagraphsByChapterIdResponse> createRepeated() =>
      $pb.PbList<GetAllParagraphsByChapterIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAllParagraphsByChapterIdResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetAllParagraphsByChapterIdResponse>(create);
  static GetAllParagraphsByChapterIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ReaderParagraph> get paragraphs => $_getList(0);
}

class GetEntireDocRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetEntireDocRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  GetEntireDocRequest._() : super();
  factory GetEntireDocRequest({
    $fixnum.Int64? iD,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    return _result;
  }
  factory GetEntireDocRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetEntireDocRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetEntireDocRequest clone() => GetEntireDocRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetEntireDocRequest copyWith(void Function(GetEntireDocRequest) updates) =>
      super.copyWith((message) => updates(message as GetEntireDocRequest))
          as GetEntireDocRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEntireDocRequest create() => GetEntireDocRequest._();
  GetEntireDocRequest createEmptyInstance() => create();
  static $pb.PbList<GetEntireDocRequest> createRepeated() =>
      $pb.PbList<GetEntireDocRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEntireDocRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEntireDocRequest>(create);
  static GetEntireDocRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);
}

class GetEntireDocParagraph extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetEntireDocParagraph',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'DocName',
        protoName: 'DocName')
    ..a<$fixnum.Int64>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ChapterID',
        $pb.PbFieldType.OU6,
        protoName: 'ChapterID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ChapterName',
        protoName: 'ChapterName')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ChupterNumber',
        protoName: 'ChupterNumber')
    ..a<$core.int>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ChupterOrderNum',
        $pb.PbFieldType.OU3,
        protoName: 'ChupterOrderNum')
    ..a<$fixnum.Int64>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ParagraphID',
        $pb.PbFieldType.OU6,
        protoName: 'ParagraphID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ParagraphOrderNum',
        $pb.PbFieldType.OU3,
        protoName: 'ParagraphOrderNum')
    ..aOB(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'HasLinks',
        protoName: 'HasLinks')
    ..aOB(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'IsTable',
        protoName: 'IsTable')
    ..aOB(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'IsNFT',
        protoName: 'IsNFT')
    ..aOS(
        11,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Class',
        protoName: 'Class')
    ..aOS(
        12,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Content',
        protoName: 'Content')
    ..hasRequiredFields = false;

  GetEntireDocParagraph._() : super();
  factory GetEntireDocParagraph({
    $core.String? docName,
    $fixnum.Int64? chapterID,
    $core.String? chapterName,
    $core.String? chupterNumber,
    $core.int? chupterOrderNum,
    $fixnum.Int64? paragraphID,
    $core.int? paragraphOrderNum,
    $core.bool? hasLinks,
    $core.bool? isTable,
    $core.bool? isNFT,
    $core.String? class_11,
    $core.String? content,
  }) {
    final _result = create();
    if (docName != null) {
      _result.docName = docName;
    }
    if (chapterID != null) {
      _result.chapterID = chapterID;
    }
    if (chapterName != null) {
      _result.chapterName = chapterName;
    }
    if (chupterNumber != null) {
      _result.chupterNumber = chupterNumber;
    }
    if (chupterOrderNum != null) {
      _result.chupterOrderNum = chupterOrderNum;
    }
    if (paragraphID != null) {
      _result.paragraphID = paragraphID;
    }
    if (paragraphOrderNum != null) {
      _result.paragraphOrderNum = paragraphOrderNum;
    }
    if (hasLinks != null) {
      _result.hasLinks = hasLinks;
    }
    if (isTable != null) {
      _result.isTable = isTable;
    }
    if (isNFT != null) {
      _result.isNFT = isNFT;
    }
    if (class_11 != null) {
      _result.class_11 = class_11;
    }
    if (content != null) {
      _result.content = content;
    }
    return _result;
  }
  factory GetEntireDocParagraph.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetEntireDocParagraph.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetEntireDocParagraph clone() =>
      GetEntireDocParagraph()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetEntireDocParagraph copyWith(
          void Function(GetEntireDocParagraph) updates) =>
      super.copyWith((message) => updates(message as GetEntireDocParagraph))
          as GetEntireDocParagraph; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEntireDocParagraph create() => GetEntireDocParagraph._();
  GetEntireDocParagraph createEmptyInstance() => create();
  static $pb.PbList<GetEntireDocParagraph> createRepeated() =>
      $pb.PbList<GetEntireDocParagraph>();
  @$core.pragma('dart2js:noInline')
  static GetEntireDocParagraph getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEntireDocParagraph>(create);
  static GetEntireDocParagraph? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get docName => $_getSZ(0);
  @$pb.TagNumber(1)
  set docName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDocName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocName() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get chapterID => $_getI64(1);
  @$pb.TagNumber(2)
  set chapterID($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasChapterID() => $_has(1);
  @$pb.TagNumber(2)
  void clearChapterID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get chapterName => $_getSZ(2);
  @$pb.TagNumber(3)
  set chapterName($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasChapterName() => $_has(2);
  @$pb.TagNumber(3)
  void clearChapterName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get chupterNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set chupterNumber($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasChupterNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearChupterNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get chupterOrderNum => $_getIZ(4);
  @$pb.TagNumber(5)
  set chupterOrderNum($core.int v) {
    $_setUnsignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasChupterOrderNum() => $_has(4);
  @$pb.TagNumber(5)
  void clearChupterOrderNum() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get paragraphID => $_getI64(5);
  @$pb.TagNumber(6)
  set paragraphID($fixnum.Int64 v) {
    $_setInt64(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasParagraphID() => $_has(5);
  @$pb.TagNumber(6)
  void clearParagraphID() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get paragraphOrderNum => $_getIZ(6);
  @$pb.TagNumber(7)
  set paragraphOrderNum($core.int v) {
    $_setUnsignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasParagraphOrderNum() => $_has(6);
  @$pb.TagNumber(7)
  void clearParagraphOrderNum() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get hasLinks => $_getBF(7);
  @$pb.TagNumber(8)
  set hasLinks($core.bool v) {
    $_setBool(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasHasLinks() => $_has(7);
  @$pb.TagNumber(8)
  void clearHasLinks() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isTable => $_getBF(8);
  @$pb.TagNumber(9)
  set isTable($core.bool v) {
    $_setBool(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasIsTable() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsTable() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isNFT => $_getBF(9);
  @$pb.TagNumber(10)
  set isNFT($core.bool v) {
    $_setBool(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasIsNFT() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsNFT() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get class_11 => $_getSZ(10);
  @$pb.TagNumber(11)
  set class_11($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasClass_11() => $_has(10);
  @$pb.TagNumber(11)
  void clearClass_11() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get content => $_getSZ(11);
  @$pb.TagNumber(12)
  set content($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasContent() => $_has(11);
  @$pb.TagNumber(12)
  void clearContent() => clearField(12);
}

class GetEntireDocResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetEntireDocResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..pc<GetEntireDocParagraph>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'paragraphs',
        $pb.PbFieldType.PM,
        subBuilder: GetEntireDocParagraph.create)
    ..hasRequiredFields = false;

  GetEntireDocResponse._() : super();
  factory GetEntireDocResponse({
    $core.Iterable<GetEntireDocParagraph>? paragraphs,
  }) {
    final _result = create();
    if (paragraphs != null) {
      _result.paragraphs.addAll(paragraphs);
    }
    return _result;
  }
  factory GetEntireDocResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetEntireDocResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetEntireDocResponse clone() =>
      GetEntireDocResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetEntireDocResponse copyWith(void Function(GetEntireDocResponse) updates) =>
      super.copyWith((message) => updates(message as GetEntireDocResponse))
          as GetEntireDocResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEntireDocResponse create() => GetEntireDocResponse._();
  GetEntireDocResponse createEmptyInstance() => create();
  static $pb.PbList<GetEntireDocResponse> createRepeated() =>
      $pb.PbList<GetEntireDocResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEntireDocResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEntireDocResponse>(create);
  static GetEntireDocResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GetEntireDocParagraph> get paragraphs => $_getList(0);
}

class GetWithNeighborsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetWithNeighborsRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'ID',
        $pb.PbFieldType.OU6,
        protoName: 'ID',
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  GetWithNeighborsRequest._() : super();
  factory GetWithNeighborsRequest({
    $fixnum.Int64? iD,
  }) {
    final _result = create();
    if (iD != null) {
      _result.iD = iD;
    }
    return _result;
  }
  factory GetWithNeighborsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetWithNeighborsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetWithNeighborsRequest clone() =>
      GetWithNeighborsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetWithNeighborsRequest copyWith(
          void Function(GetWithNeighborsRequest) updates) =>
      super.copyWith((message) => updates(message as GetWithNeighborsRequest))
          as GetWithNeighborsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetWithNeighborsRequest create() => GetWithNeighborsRequest._();
  GetWithNeighborsRequest createEmptyInstance() => create();
  static $pb.PbList<GetWithNeighborsRequest> createRepeated() =>
      $pb.PbList<GetWithNeighborsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWithNeighborsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWithNeighborsRequest>(create);
  static GetWithNeighborsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);
}

class GetWithNeighborsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetWithNeighborsResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'reader.v1'),
      createEmptyInstance: create)
    ..pc<ReaderChapter>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'Chapters',
        $pb.PbFieldType.PM,
        protoName: 'Chapters',
        subBuilder: ReaderChapter.create)
    ..hasRequiredFields = false;

  GetWithNeighborsResponse._() : super();
  factory GetWithNeighborsResponse({
    $core.Iterable<ReaderChapter>? chapters,
  }) {
    final _result = create();
    if (chapters != null) {
      _result.chapters.addAll(chapters);
    }
    return _result;
  }
  factory GetWithNeighborsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetWithNeighborsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetWithNeighborsResponse clone() =>
      GetWithNeighborsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetWithNeighborsResponse copyWith(
          void Function(GetWithNeighborsResponse) updates) =>
      super.copyWith((message) => updates(message as GetWithNeighborsResponse))
          as GetWithNeighborsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetWithNeighborsResponse create() => GetWithNeighborsResponse._();
  GetWithNeighborsResponse createEmptyInstance() => create();
  static $pb.PbList<GetWithNeighborsResponse> createRepeated() =>
      $pb.PbList<GetWithNeighborsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWithNeighborsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWithNeighborsResponse>(create);
  static GetWithNeighborsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ReaderChapter> get chapters => $_getList(0);
}
