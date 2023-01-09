///
//  Generated code. Do not modify.
//  source: reader/service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use typeResponseDescriptor instead')
const TypeResponse$json = const {
  '1': 'TypeResponse',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
    const {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
  ],
};

/// Descriptor for `TypeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typeResponseDescriptor = $convert.base64Decode('CgxUeXBlUmVzcG9uc2USDgoCSUQYASABKARSAklEEhIKBE5hbWUYAiABKAlSBE5hbWU=');
@$core.Deprecated('Use getAllTypesResponseDescriptor instead')
const GetAllTypesResponse$json = const {
  '1': 'GetAllTypesResponse',
  '2': const [
    const {'1': 'Types', '3': 1, '4': 3, '5': 11, '6': '.reader.v1.TypeResponse', '10': 'Types'},
  ],
};

/// Descriptor for `GetAllTypesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllTypesResponseDescriptor = $convert.base64Decode('ChNHZXRBbGxUeXBlc1Jlc3BvbnNlEi0KBVR5cGVzGAEgAygLMhcucmVhZGVyLnYxLlR5cGVSZXNwb25zZVIFVHlwZXM=');
@$core.Deprecated('Use getAllSubtypesRequestDescriptor instead')
const GetAllSubtypesRequest$json = const {
  '1': 'GetAllSubtypesRequest',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
  ],
};

/// Descriptor for `GetAllSubtypesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllSubtypesRequestDescriptor = $convert.base64Decode('ChVHZXRBbGxTdWJ0eXBlc1JlcXVlc3QSDgoCSUQYASABKARSAklE');
@$core.Deprecated('Use subtypeResponseDescriptor instead')
const SubtypeResponse$json = const {
  '1': 'SubtypeResponse',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
    const {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
  ],
};

/// Descriptor for `SubtypeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subtypeResponseDescriptor = $convert.base64Decode('Cg9TdWJ0eXBlUmVzcG9uc2USDgoCSUQYASABKARSAklEEhIKBE5hbWUYAiABKAlSBE5hbWU=');
@$core.Deprecated('Use getAllSubtypesResponseDescriptor instead')
const GetAllSubtypesResponse$json = const {
  '1': 'GetAllSubtypesResponse',
  '2': const [
    const {'1': 'Subtypes', '3': 1, '4': 3, '5': 11, '6': '.reader.v1.SubtypeResponse', '10': 'Subtypes'},
  ],
};

/// Descriptor for `GetAllSubtypesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllSubtypesResponseDescriptor = $convert.base64Decode('ChZHZXRBbGxTdWJ0eXBlc1Jlc3BvbnNlEjYKCFN1YnR5cGVzGAEgAygLMhoucmVhZGVyLnYxLlN1YnR5cGVSZXNwb25zZVIIU3VidHlwZXM=');
@$core.Deprecated('Use getDocsRequestDescriptor instead')
const GetDocsRequest$json = const {
  '1': 'GetDocsRequest',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
  ],
};

/// Descriptor for `GetDocsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDocsRequestDescriptor = $convert.base64Decode('Cg5HZXREb2NzUmVxdWVzdBIOCgJJRBgBIAEoBFICSUQ=');
@$core.Deprecated('Use docDescriptor instead')
const Doc$json = const {
  '1': 'Doc',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
    const {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
  ],
};

/// Descriptor for `Doc`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List docDescriptor = $convert.base64Decode('CgNEb2MSDgoCSUQYASABKARSAklEEhIKBE5hbWUYAiABKAlSBE5hbWU=');
@$core.Deprecated('Use getDocsResponseDescriptor instead')
const GetDocsResponse$json = const {
  '1': 'GetDocsResponse',
  '2': const [
    const {'1': 'Docs', '3': 1, '4': 3, '5': 11, '6': '.reader.v1.Doc', '10': 'Docs'},
  ],
};

/// Descriptor for `GetDocsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDocsResponseDescriptor = $convert.base64Decode('Cg9HZXREb2NzUmVzcG9uc2USIgoERG9jcxgBIAMoCzIOLnJlYWRlci52MS5Eb2NSBERvY3M=');
@$core.Deprecated('Use readerParagraphDescriptor instead')
const ReaderParagraph$json = const {
  '1': 'ReaderParagraph',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
    const {'1': 'Num', '3': 2, '4': 1, '5': 13, '10': 'Num'},
    const {'1': 'HasLinks', '3': 3, '4': 1, '5': 8, '10': 'HasLinks'},
    const {'1': 'IsTable', '3': 4, '4': 1, '5': 8, '10': 'IsTable'},
    const {'1': 'IsNFT', '3': 5, '4': 1, '5': 8, '10': 'IsNFT'},
    const {'1': 'Class', '3': 6, '4': 1, '5': 9, '10': 'Class'},
    const {'1': 'Content', '3': 7, '4': 1, '5': 9, '10': 'Content'},
    const {'1': 'ChapterID', '3': 8, '4': 1, '5': 4, '10': 'ChapterID'},
  ],
};

/// Descriptor for `ReaderParagraph`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readerParagraphDescriptor = $convert.base64Decode('Cg9SZWFkZXJQYXJhZ3JhcGgSDgoCSUQYASABKARSAklEEhAKA051bRgCIAEoDVIDTnVtEhoKCEhhc0xpbmtzGAMgASgIUghIYXNMaW5rcxIYCgdJc1RhYmxlGAQgASgIUgdJc1RhYmxlEhQKBUlzTkZUGAUgASgIUgVJc05GVBIUCgVDbGFzcxgGIAEoCVIFQ2xhc3MSGAoHQ29udGVudBgHIAEoCVIHQ29udGVudBIcCglDaGFwdGVySUQYCCABKARSCUNoYXB0ZXJJRA==');
@$core.Deprecated('Use getOneDocRequestDescriptor instead')
const GetOneDocRequest$json = const {
  '1': 'GetOneDocRequest',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
  ],
};

/// Descriptor for `GetOneDocRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOneDocRequestDescriptor = $convert.base64Decode('ChBHZXRPbmVEb2NSZXF1ZXN0Eg4KAklEGAEgASgEUgJJRA==');
@$core.Deprecated('Use getOneDocResponseDescriptor instead')
const GetOneDocResponse$json = const {
  '1': 'GetOneDocResponse',
  '2': const [
    const {'1': 'Name', '3': 1, '4': 1, '5': 9, '10': 'Name'},
    const {'1': 'Abbreviation', '3': 2, '4': 1, '5': 9, '10': 'Abbreviation'},
    const {'1': 'Title', '3': 3, '4': 1, '5': 9, '10': 'Title'},
  ],
};

/// Descriptor for `GetOneDocResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOneDocResponseDescriptor = $convert.base64Decode('ChFHZXRPbmVEb2NSZXNwb25zZRISCgROYW1lGAEgASgJUgROYW1lEiIKDEFiYnJldmlhdGlvbhgCIAEoCVIMQWJicmV2aWF0aW9uEhQKBVRpdGxlGAMgASgJUgVUaXRsZQ==');
@$core.Deprecated('Use getOneChapterRequestDescriptor instead')
const GetOneChapterRequest$json = const {
  '1': 'GetOneChapterRequest',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
  ],
};

/// Descriptor for `GetOneChapterRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOneChapterRequestDescriptor = $convert.base64Decode('ChRHZXRPbmVDaGFwdGVyUmVxdWVzdBIOCgJJRBgBIAEoBFICSUQ=');
@$core.Deprecated('Use getOneChapterResponseDescriptor instead')
const GetOneChapterResponse$json = const {
  '1': 'GetOneChapterResponse',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
    const {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
    const {'1': 'Num', '3': 3, '4': 1, '5': 9, '10': 'Num'},
    const {'1': 'DocID', '3': 4, '4': 1, '5': 4, '10': 'DocID'},
    const {'1': 'OrderNum', '3': 5, '4': 1, '5': 13, '10': 'OrderNum'},
    const {'1': 'Paragraphs', '3': 6, '4': 3, '5': 11, '6': '.reader.v1.ReaderParagraph', '10': 'Paragraphs'},
  ],
};

/// Descriptor for `GetOneChapterResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getOneChapterResponseDescriptor = $convert.base64Decode('ChVHZXRPbmVDaGFwdGVyUmVzcG9uc2USDgoCSUQYASABKARSAklEEhIKBE5hbWUYAiABKAlSBE5hbWUSEAoDTnVtGAMgASgJUgNOdW0SFAoFRG9jSUQYBCABKARSBURvY0lEEhoKCE9yZGVyTnVtGAUgASgNUghPcmRlck51bRI6CgpQYXJhZ3JhcGhzGAYgAygLMhoucmVhZGVyLnYxLlJlYWRlclBhcmFncmFwaFIKUGFyYWdyYXBocw==');
@$core.Deprecated('Use readerChapterDescriptor instead')
const ReaderChapter$json = const {
  '1': 'ReaderChapter',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
    const {'1': 'Name', '3': 2, '4': 1, '5': 9, '10': 'Name'},
    const {'1': 'Num', '3': 3, '4': 1, '5': 9, '10': 'Num'},
    const {'1': 'DocID', '3': 4, '4': 1, '5': 4, '10': 'DocID'},
    const {'1': 'OrderNum', '3': 5, '4': 1, '5': 13, '10': 'OrderNum'},
    const {'1': 'UpdatedAt', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'UpdatedAt'},
  ],
};

/// Descriptor for `ReaderChapter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readerChapterDescriptor = $convert.base64Decode('Cg1SZWFkZXJDaGFwdGVyEg4KAklEGAEgASgEUgJJRBISCgROYW1lGAIgASgJUgROYW1lEhAKA051bRgDIAEoCVIDTnVtEhQKBURvY0lEGAQgASgEUgVEb2NJRBIaCghPcmRlck51bRgFIAEoDVIIT3JkZXJOdW0SOAoJVXBkYXRlZEF0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJVXBkYXRlZEF0');
@$core.Deprecated('Use getAllChaptersByDocIdRequestDescriptor instead')
const GetAllChaptersByDocIdRequest$json = const {
  '1': 'GetAllChaptersByDocIdRequest',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
  ],
};

/// Descriptor for `GetAllChaptersByDocIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllChaptersByDocIdRequestDescriptor = $convert.base64Decode('ChxHZXRBbGxDaGFwdGVyc0J5RG9jSWRSZXF1ZXN0Eg4KAklEGAEgASgEUgJJRA==');
@$core.Deprecated('Use getAllChaptersByDocIdResponseDescriptor instead')
const GetAllChaptersByDocIdResponse$json = const {
  '1': 'GetAllChaptersByDocIdResponse',
  '2': const [
    const {'1': 'Chapters', '3': 1, '4': 3, '5': 11, '6': '.reader.v1.ReaderChapter', '10': 'Chapters'},
  ],
};

/// Descriptor for `GetAllChaptersByDocIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllChaptersByDocIdResponseDescriptor = $convert.base64Decode('Ch1HZXRBbGxDaGFwdGVyc0J5RG9jSWRSZXNwb25zZRI0CghDaGFwdGVycxgBIAMoCzIYLnJlYWRlci52MS5SZWFkZXJDaGFwdGVyUghDaGFwdGVycw==');
@$core.Deprecated('Use getAllParagraphsByChapterIdRequestDescriptor instead')
const GetAllParagraphsByChapterIdRequest$json = const {
  '1': 'GetAllParagraphsByChapterIdRequest',
  '2': const [
    const {'1': 'ID', '3': 1, '4': 1, '5': 4, '10': 'ID'},
  ],
};

/// Descriptor for `GetAllParagraphsByChapterIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllParagraphsByChapterIdRequestDescriptor = $convert.base64Decode('CiJHZXRBbGxQYXJhZ3JhcGhzQnlDaGFwdGVySWRSZXF1ZXN0Eg4KAklEGAEgASgEUgJJRA==');
@$core.Deprecated('Use getAllParagraphsByChapterIdResponseDescriptor instead')
const GetAllParagraphsByChapterIdResponse$json = const {
  '1': 'GetAllParagraphsByChapterIdResponse',
  '2': const [
    const {'1': 'Paragraphs', '3': 1, '4': 3, '5': 11, '6': '.reader.v1.ReaderParagraph', '10': 'Paragraphs'},
  ],
};

/// Descriptor for `GetAllParagraphsByChapterIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAllParagraphsByChapterIdResponseDescriptor = $convert.base64Decode('CiNHZXRBbGxQYXJhZ3JhcGhzQnlDaGFwdGVySWRSZXNwb25zZRI6CgpQYXJhZ3JhcGhzGAEgAygLMhoucmVhZGVyLnYxLlJlYWRlclBhcmFncmFwaFIKUGFyYWdyYXBocw==');
