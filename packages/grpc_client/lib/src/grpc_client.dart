import 'package:grpc/grpc.dart';

class GrpcClient {
  static late ClientChannel _channel;
  ClientChannel channel() => _channel;

  GrpcClient();

  void init(
      {required String host,
      required int port,
      options =
          const ChannelOptions(credentials: ChannelCredentials.insecure())}) {
    _channel = ClientChannel(
      host,
      port: port,
      options: options,
    );
  }
}
