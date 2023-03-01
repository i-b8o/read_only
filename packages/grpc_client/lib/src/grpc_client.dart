import 'package:grpc/grpc.dart';

class GrpcClient {
  static late List<ClientChannel> _channels;
  ClientChannel channel(int n) => _channels[n];

  GrpcClient();

  void init(
      {required String host,
      required int port,
      options =
          const ChannelOptions(credentials: ChannelCredentials.insecure())}) {
    _channels = [
      ClientChannel(
        host,
        port: port,
        options: options,
      )
    ];
  }

  static void addChannel(
      {required String host,
      required int port,
      options =
          const ChannelOptions(credentials: ChannelCredentials.insecure())}) {
    _channels.add(ClientChannel(
      host,
      port: port,
      options: options,
    ));
  }
}
