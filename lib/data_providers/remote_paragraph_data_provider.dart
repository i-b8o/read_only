import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/pb/reader/service.pbgrpc.dart';

import '../domain/service/chapter_service.dart';

class ParagraphDataProviderDefault implements ParagraphDataProvider {
  ParagraphDataProviderDefault()
      : _grpcClient = ParagraphGRPCClient(GrpcClient().channel());

  final ParagraphGRPCClient _grpcClient;

  @override
  Future<List<Paragraph>?> getParagraphs(int chapterID) {
    // TODO: implement getParagraphs
    throw UnimplementedError();
  }
}
