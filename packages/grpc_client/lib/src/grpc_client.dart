import 'package:grpc/grpc.dart';

class GrpcClient {
  late final ClientChannel _channel;
  @override
  ClientChannel channel() => _channel;

  bool _connected = false;
  bool check() => _connected;
  final String _host;
  final int _port;
  final ChannelOptions _options;

  GrpcClient(
      {required String host,
      required int port,
      options =
          const ChannelOptions(credentials: ChannelCredentials.insecure())})
      : _host = host,
        _port = port,
        _options = options {
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
      _recreateChannel();
    });
  }

  void _recreateChannel() {
    _channel = ClientChannel(
      _host,
      port: _port,
      options: _options,
    );
  }
}
