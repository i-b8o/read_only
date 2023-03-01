import 'package:fixnum/fixnum.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/pb/reader/service.pbgrpc.dart';
import 'package:read_only/domain/entity/paragraph.dart' as domain_paragraph;

import '../domain/service/chapter_service.dart';

class ParagraphDataProviderDefault implements ParagraphDataProvider {
  ParagraphDataProviderDefault()
      : _grpcClient = ParagraphGRPCClient(GrpcClient().channel(0));

  final ParagraphGRPCClient _grpcClient;

  @override
  Future<List<Paragraph>?> getParagraphs(int chapterID) async {
    try {
      final request = GetAllParagraphsByChapterIdRequest()
        ..iD = Int64(chapterID);
      final response = await _grpcClient.getAll(request);
      return response.paragraphs
          .map((e) => domain_paragraph.Paragraph(
              paragraphID: e.iD.toInt(),
              chapterID: e.chapterID.toInt(),
              hasLinks: e.hasLinks,
              isNFT: e.isNFT,
              isTable: e.isTable,
              paragraphOrderNum: e.num,
              paragraphclass: e.class_6,
              content: e.content))
          .toList();
    } catch (e) {
      // handle the exception here, for example:
      print('An error occurred while getting paragraphs: $e');
      return null;
    }
  }
}
