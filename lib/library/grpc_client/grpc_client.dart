import 'package:grpc/grpc.dart';

abstract class GrpcClient {
  ClientChannel channel();
}

class GrpcClientDefault implements GrpcClient {
  late final ClientChannel _channel;
  @override
  ClientChannel channel() => _channel;

  GrpcClientDefault(
      {required host,
      required port,
      options =
          const ChannelOptions(credentials: ChannelCredentials.insecure())}) {
    _channel = ClientChannel(
      host,
      port: port,
      options: options,
    );
    // TODO add check connection and restart
    // _channel.onConnectionStateChanged.listen((event) {
    //   _connectionState = event;
    // });
  }

  // static String? check() {
  //   switch (_connectionState) {
  //     case ConnectionState.idle:
  //       return "not connected";
  //     case ConnectionState.connecting:
  //       return null;
  //       // ignore: dead_code
  //       break;
  //     case ConnectionState.transientFailure:
  //       return "transientFailure";
  //       // ignore: dead_code
  //       break;
  //     case ConnectionState.shutdown:
  //       return "transientFailure";
  //       // ignore: dead_code
  //       break;
  //     case ConnectionState.ready:
  //       return null;
  //   }
  // }
}
