import 'package:grpc/grpc.dart';
import 'package:read_only/configuration/configuration.dart';
import 'package:read_only/data_providers/grpc/pb/reader/service.pbgrpc.dart';

class GrpcClient {
  late final ClientChannel channel;
  late final TypeGRPCClient typeStub;

  GrpcClient() {
    channel = ClientChannel(
      '192.168.31.203',
      port: 30000,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    typeStub = TypeGRPCClient(channel);
  }
}
