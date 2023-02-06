import 'package:grpc/grpc.dart';

class GrpcClient {
  late final ClientChannel _channel;
  @override
  ClientChannel channel() => _channel;

  bool _connected = false;
  bool check() => _connected;

  GrpcClient(
      {required String host,
      required int port,
      options =
          const ChannelOptions(credentials: ChannelCredentials.insecure())}) {
    _channel = ClientChannel(
      host,
      port: port,
      options: options,
    );

    _channel.onConnectionStateChanged.listen((event) {
      if (event == ConnectionState.ready) {
        _connected = true;
        return;
      }
      _connected = false;
    });
  }
}
