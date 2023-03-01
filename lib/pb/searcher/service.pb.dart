///
//  Generated code. Do not modify.
//  source: searcher/service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pbenum.dart';

export 'service.pbenum.dart';

class SearchRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'searcher.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'SearchQuery', protoName: 'SearchQuery')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Limit', $pb.PbFieldType.OU3, protoName: 'Limit')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Offset', $pb.PbFieldType.OU3, protoName: 'Offset')
    ..e<SearchRequest_Subject>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subject', $pb.PbFieldType.OE, defaultOrMaker: SearchRequest_Subject.General, valueOf: SearchRequest_Subject.valueOf, enumValues: SearchRequest_Subject.values)
    ..hasRequiredFields = false
  ;

  SearchRequest._() : super();
  factory SearchRequest({
    $core.String? searchQuery,
    $core.int? limit,
    $core.int? offset,
    SearchRequest_Subject? subject,
  }) {
    final _result = create();
    if (searchQuery != null) {
      _result.searchQuery = searchQuery;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (subject != null) {
      _result.subject = subject;
    }
    return _result;
  }
  factory SearchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchRequest clone() => SearchRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchRequest copyWith(void Function(SearchRequest) updates) => super.copyWith((message) => updates(message as SearchRequest)) as SearchRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchRequest create() => SearchRequest._();
  SearchRequest createEmptyInstance() => create();
  static $pb.PbList<SearchRequest> createRepeated() => $pb.PbList<SearchRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchRequest>(create);
  static SearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get searchQuery => $_getSZ(0);
  @$pb.TagNumber(1)
  set searchQuery($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSearchQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearSearchQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => clearField(3);

  @$pb.TagNumber(4)
  SearchRequest_Subject get subject => $_getN(3);
  @$pb.TagNumber(4)
  set subject(SearchRequest_Subject v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSubject() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubject() => clearField(4);
}

class SearchResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'searcher.v1'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'DocID', $pb.PbFieldType.OU6, protoName: 'DocID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'DocName', protoName: 'DocName')
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChapterID', $pb.PbFieldType.OU6, protoName: 'ChapterID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ChapterName', protoName: 'ChapterName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'UpdatedAt', protoName: 'UpdatedAt')
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ParagraphID', $pb.PbFieldType.OU6, protoName: 'ParagraphID', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Text', protoName: 'Text')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'Count', $pb.PbFieldType.OU3, protoName: 'Count')
    ..hasRequiredFields = false
  ;

  SearchResponse._() : super();
  factory SearchResponse({
    $fixnum.Int64? docID,
    $core.String? docName,
    $fixnum.Int64? chapterID,
    $core.String? chapterName,
    $core.String? updatedAt,
    $fixnum.Int64? paragraphID,
    $core.String? text,
    $core.int? count,
  }) {
    final _result = create();
    if (docID != null) {
      _result.docID = docID;
    }
    if (docName != null) {
      _result.docName = docName;
    }
    if (chapterID != null) {
      _result.chapterID = chapterID;
    }
    if (chapterName != null) {
      _result.chapterName = chapterName;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (paragraphID != null) {
      _result.paragraphID = paragraphID;
    }
    if (text != null) {
      _result.text = text;
    }
    if (count != null) {
      _result.count = count;
    }
    return _result;
  }
  factory SearchResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchResponse clone() => SearchResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchResponse copyWith(void Function(SearchResponse) updates) => super.copyWith((message) => updates(message as SearchResponse)) as SearchResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchResponse create() => SearchResponse._();
  SearchResponse createEmptyInstance() => create();
  static $pb.PbList<SearchResponse> createRepeated() => $pb.PbList<SearchResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchResponse>(create);
  static SearchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get docID => $_getI64(0);
  @$pb.TagNumber(1)
  set docID($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocID() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get docName => $_getSZ(1);
  @$pb.TagNumber(2)
  set docName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDocName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocName() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get chapterID => $_getI64(2);
  @$pb.TagNumber(3)
  set chapterID($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChapterID() => $_has(2);
  @$pb.TagNumber(3)
  void clearChapterID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get chapterName => $_getSZ(3);
  @$pb.TagNumber(4)
  set chapterName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChapterName() => $_has(3);
  @$pb.TagNumber(4)
  void clearChapterName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get updatedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set updatedAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUpdatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdatedAt() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get paragraphID => $_getI64(5);
  @$pb.TagNumber(6)
  set paragraphID($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasParagraphID() => $_has(5);
  @$pb.TagNumber(6)
  void clearParagraphID() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get text => $_getSZ(6);
  @$pb.TagNumber(7)
  set text($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasText() => $_has(6);
  @$pb.TagNumber(7)
  void clearText() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get count => $_getIZ(7);
  @$pb.TagNumber(8)
  set count($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearCount() => clearField(8);
}

class SearchResponseMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchResponseMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'searcher.v1'), createEmptyInstance: create)
    ..pc<SearchResponse>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'response', $pb.PbFieldType.PM, subBuilder: SearchResponse.create)
    ..hasRequiredFields = false
  ;

  SearchResponseMessage._() : super();
  factory SearchResponseMessage({
    $core.Iterable<SearchResponse>? response,
  }) {
    final _result = create();
    if (response != null) {
      _result.response.addAll(response);
    }
    return _result;
  }
  factory SearchResponseMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchResponseMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchResponseMessage clone() => SearchResponseMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchResponseMessage copyWith(void Function(SearchResponseMessage) updates) => super.copyWith((message) => updates(message as SearchResponseMessage)) as SearchResponseMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchResponseMessage create() => SearchResponseMessage._();
  SearchResponseMessage createEmptyInstance() => create();
  static $pb.PbList<SearchResponseMessage> createRepeated() => $pb.PbList<SearchResponseMessage>();
  @$core.pragma('dart2js:noInline')
  static SearchResponseMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchResponseMessage>(create);
  static SearchResponseMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SearchResponse> get response => $_getList(0);
}

