///
//  Generated code. Do not modify.
//  source: searcher/service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SearchRequest_Subject extends $pb.ProtobufEnum {
  static const SearchRequest_Subject General = SearchRequest_Subject._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'General');
  static const SearchRequest_Subject Docs = SearchRequest_Subject._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Docs');
  static const SearchRequest_Subject Chapters = SearchRequest_Subject._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Chapters');
  static const SearchRequest_Subject Pargaraphs = SearchRequest_Subject._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Pargaraphs');

  static const $core.List<SearchRequest_Subject> values = <SearchRequest_Subject> [
    General,
    Docs,
    Chapters,
    Pargaraphs,
  ];

  static final $core.Map<$core.int, SearchRequest_Subject> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SearchRequest_Subject? valueOf($core.int value) => _byValue[value];

  const SearchRequest_Subject._($core.int v, $core.String n) : super(v, n);
}

