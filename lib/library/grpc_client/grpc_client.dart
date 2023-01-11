import 'package:grpc/grpc.dart';
import 'package:read_only/configuration/configuration.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pbgrpc.dart';

class GrpcClient {
  late final ClientChannel _channel;
  static late final TypeGRPCClient typeStub;
  static late final SubGRPCClient subtypeStub;
  static late final DocGRPCClient docStub;
  static late final ChapterGRPCClient chapterStub;
  // static ConnectionState _connectionState = ConnectionState.connecting;

  GrpcClient() {
    _channel = ClientChannel(
      Configuration.host,
      port: Configuration.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    // TODO add check connection and restart
    // _channel.onConnectionStateChanged.listen((event) {
    //   _connectionState = event;
    // });

    typeStub = TypeGRPCClient(_channel);
    subtypeStub = SubGRPCClient(_channel);
    docStub = DocGRPCClient(_channel);
    chapterStub = ChapterGRPCClient(_channel);
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
