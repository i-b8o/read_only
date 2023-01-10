import 'package:grpc/grpc.dart';
import 'package:read_only/configuration/configuration.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pbgrpc.dart';

class GrpcClient {
  late final ClientChannel _channel;
  static late final TypeGRPCClient typeStub;
  static late final SubGRPCClient subtypeStub;
  static late final DocGRPCClient docStub;
  static late final ChapterGRPCClient chapterStub;

  GrpcClient() {
    _channel = ClientChannel(
      Configuration.host,
      port: Configuration.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    typeStub = TypeGRPCClient(_channel);
    subtypeStub = SubGRPCClient(_channel);
    docStub = DocGRPCClient(_channel);
    chapterStub = ChapterGRPCClient(_channel);
  }
}
