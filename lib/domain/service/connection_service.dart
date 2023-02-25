import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:grpc/grpc.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:my_logger/my_logger.dart';

enum AppConnectionStatus {
  internetConnected,
  internetDisconnected,
  serverIsNotAccessible,
  serverIsFine
}

class ConnectionStatusService {
  Stream<AppConnectionStatus> get connectionStatusStream =>
      _connectionStatusController.stream;

  final Connectivity _connectivity = Connectivity();
  final StreamController<AppConnectionStatus> _connectionStatusController =
      StreamController<AppConnectionStatus>();
  final ClientChannel _grpcChannel;
  late AppConnectionStatus _status = AppConnectionStatus.internetDisconnected;

  ConnectionStatusService() : _grpcChannel = GrpcClient().channel() {
    _connectivity.onConnectivityChanged.listen(_updateInternetConnectionStatus);
    _grpcChannel.onConnectionStateChanged.listen(_updateGrpcServerStatus);
  }
  void _updateGrpcServerStatus(ConnectionState state) {
    L.info("grpc $state");
    switch (state) {
      case ConnectionState.idle:
      case ConnectionState.connecting:
      case ConnectionState.transientFailure:
      case ConnectionState.shutdown:
        if (_status != AppConnectionStatus.internetDisconnected) {
          _status = AppConnectionStatus.serverIsNotAccessible;
        }
        break;
      case ConnectionState.ready:
        _status = AppConnectionStatus.serverIsFine;
        break;
    }
    _connectionStatusController.add(_status);
  }

  void _updateInternetConnectionStatus(ConnectivityResult state) {
    L.info("inet $state");
    switch (state) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        if (_status == AppConnectionStatus.internetDisconnected) {
          _status = AppConnectionStatus.internetConnected;
        }
        break;
      case ConnectivityResult.none:
        _status = AppConnectionStatus.internetDisconnected;
        break;
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.ethernet:
        break;
      case ConnectivityResult.vpn:
        break;
      case ConnectivityResult.other:
        break;
    }
    _connectionStatusController.add(_status);
  }

  void dispose() {
    _connectionStatusController.close();
  }
}
