import 'package:grpc/grpc.dart';

class GrpcClient {
  static late final Map<String, ClientChannel> _channels = {};

  ClientChannel channel(String name) => _channels[name]!;

  GrpcClient();

  void init({
    required String name,
    required String host,
    required int port,
    options = const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  }) {
    _channels[name] = ClientChannel(
      host,
      port: port,
      options: options,
    );
  }

  static void addChannel({
    required String name,
    required String host,
    required int port,
    options = const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  }) {
    _channels[name] = ClientChannel(
      host,
      port: port,
      options: options,
    );
  }

  @override
  Future<void> dispose() async {
    await Future.wait(
      _channels.values.map((channel) => channel.shutdown()),
    );
    _channels.clear();
  }
}
