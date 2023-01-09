import 'package:grpc/grpc.dart';
import 'package:read_only/configuration/configuration.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pbgrpc.dart';

class GrpcClient {
  late final ClientChannel channel;
  late final TypeGRPCClient typeStub;
  late final SubGRPCClient subtypeStub;
  late final DocGRPCClient docStub;

  GrpcClient() {
    channel = ClientChannel(
      Configuration.host,
      port: Configuration.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    typeStub = TypeGRPCClient(channel);
    subtypeStub = SubGRPCClient(channel);
    docStub = DocGRPCClient(channel);
  }
}
