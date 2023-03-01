///
//  Generated code. Do not modify.
//  source: searcher/service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use searchRequestDescriptor instead')
const SearchRequest$json = const {
  '1': 'SearchRequest',
  '2': const [
    const {'1': 'SearchQuery', '3': 1, '4': 1, '5': 9, '10': 'SearchQuery'},
    const {'1': 'Limit', '3': 2, '4': 1, '5': 13, '10': 'Limit'},
    const {'1': 'Offset', '3': 3, '4': 1, '5': 13, '10': 'Offset'},
    const {'1': 'subject', '3': 4, '4': 1, '5': 14, '6': '.searcher.v1.SearchRequest.Subject', '10': 'subject'},
  ],
  '4': const [SearchRequest_Subject$json],
};

@$core.Deprecated('Use searchRequestDescriptor instead')
const SearchRequest_Subject$json = const {
  '1': 'Subject',
  '2': const [
    const {'1': 'General', '2': 0},
    const {'1': 'Docs', '2': 1},
    const {'1': 'Chapters', '2': 2},
    const {'1': 'Pargaraphs', '2': 3},
  ],
};

/// Descriptor for `SearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRequestDescriptor = $convert.base64Decode('Cg1TZWFyY2hSZXF1ZXN0EiAKC1NlYXJjaFF1ZXJ5GAEgASgJUgtTZWFyY2hRdWVyeRIUCgVMaW1pdBgCIAEoDVIFTGltaXQSFgoGT2Zmc2V0GAMgASgNUgZPZmZzZXQSPAoHc3ViamVjdBgEIAEoDjIiLnNlYXJjaGVyLnYxLlNlYXJjaFJlcXVlc3QuU3ViamVjdFIHc3ViamVjdCI+CgdTdWJqZWN0EgsKB0dlbmVyYWwQABIICgREb2NzEAESDAoIQ2hhcHRlcnMQAhIOCgpQYXJnYXJhcGhzEAM=');
@$core.Deprecated('Use searchResponseDescriptor instead')
const SearchResponse$json = const {
  '1': 'SearchResponse',
  '2': const [
    const {'1': 'DocID', '3': 1, '4': 1, '5': 4, '10': 'DocID'},
    const {'1': 'DocName', '3': 2, '4': 1, '5': 9, '10': 'DocName'},
    const {'1': 'ChapterID', '3': 3, '4': 1, '5': 4, '10': 'ChapterID'},
    const {'1': 'ChapterName', '3': 4, '4': 1, '5': 9, '10': 'ChapterName'},
    const {'1': 'UpdatedAt', '3': 5, '4': 1, '5': 9, '10': 'UpdatedAt'},
    const {'1': 'ParagraphID', '3': 6, '4': 1, '5': 4, '10': 'ParagraphID'},
    const {'1': 'Text', '3': 7, '4': 1, '5': 9, '10': 'Text'},
    const {'1': 'Count', '3': 8, '4': 1, '5': 13, '10': 'Count'},
  ],
};

/// Descriptor for `SearchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchResponseDescriptor = $convert.base64Decode('Cg5TZWFyY2hSZXNwb25zZRIUCgVEb2NJRBgBIAEoBFIFRG9jSUQSGAoHRG9jTmFtZRgCIAEoCVIHRG9jTmFtZRIcCglDaGFwdGVySUQYAyABKARSCUNoYXB0ZXJJRBIgCgtDaGFwdGVyTmFtZRgEIAEoCVILQ2hhcHRlck5hbWUSHAoJVXBkYXRlZEF0GAUgASgJUglVcGRhdGVkQXQSIAoLUGFyYWdyYXBoSUQYBiABKARSC1BhcmFncmFwaElEEhIKBFRleHQYByABKAlSBFRleHQSFAoFQ291bnQYCCABKA1SBUNvdW50');
@$core.Deprecated('Use searchResponseMessageDescriptor instead')
const SearchResponseMessage$json = const {
  '1': 'SearchResponseMessage',
  '2': const [
    const {'1': 'response', '3': 1, '4': 3, '5': 11, '6': '.searcher.v1.SearchResponse', '10': 'response'},
  ],
};

/// Descriptor for `SearchResponseMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchResponseMessageDescriptor = $convert.base64Decode('ChVTZWFyY2hSZXNwb25zZU1lc3NhZ2USNwoIcmVzcG9uc2UYASADKAsyGy5zZWFyY2hlci52MS5TZWFyY2hSZXNwb25zZVIIcmVzcG9uc2U=');
