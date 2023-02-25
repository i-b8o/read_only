import 'package:flutter/material.dart';
import 'package:read_only/domain/entity/type.dart';
import 'package:read_only/domain/service/connection_service.dart';
import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class TypesListViewModelService {
  Future<List<Type>> getAll();
}

class TypeListViewModel extends ChangeNotifier {
  final TypesListViewModelService typesProvider;

  final ConnectionStatusService connectionService;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  var _types = <Type>[];
  List<Type> get types => List.unmodifiable(_types);

  TypeListViewModel(
      {required this.typesProvider, required this.connectionService}) {
    asyncInit();
    connectionService.connectionStatusStream.listen(onConnectionStatus);
  }

  void onConnectionStatus(AppConnectionStatus status) {
    switch (status) {
      case AppConnectionStatus.serverIsFine:
        _errorMessage = null;
        break;
      case AppConnectionStatus.serverIsNotAccessible:
        _errorMessage = 'gRPC server is not accessible';
        break;
      case AppConnectionStatus.internetConnected:
        // _errorMessage = null;
        break;
      case AppConnectionStatus.internetDisconnected:
        _errorMessage = 'Internet disconnected';
        break;
    }
    notifyListeners();
  }

  Future<void> asyncInit() async {
    await getAll();
    notifyListeners();
  }

  Future<void> getAll() async {
    _types = await typesProvider.getAll();
  }

  void onTap(BuildContext context, int id) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.subtypeListScreen,
      arguments: id,
    );
  }
}
