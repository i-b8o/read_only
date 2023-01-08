import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/domain/service/type.dart';
import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/ui/widgets/type_list/type_list_widget.dart';

import '../data_providers/grpc/types.dart';
import '../main.dart';
import '../ui/navigation/main_navigation.dart';
import '../ui/widgets/app/app.dart';
import '../ui/widgets/type_list/type_list_model.dart';

AppFactory makeAppFactory() => _AppFactoryDefault();

class _AppFactoryDefault implements AppFactory {
  final _diContainer = _DIContainer();

  _AppFactoryDefault();
  @override
  Widget makeApp() => App(navigation: _diContainer._makeAppNavigation());
}

class _DIContainer {
  ScreenFactory _makeScreenFactory() => ScreenFactoryDefault(this);

  AppNavigation _makeAppNavigation() => MainNavigation(_makeScreenFactory());

  GrpcClient _makeGrpcClient() => GrpcClient();
  TypeDataProvider _makeTypeDataProvider() =>
      TypeDataProvider(client: _makeGrpcClient());
  TypeService _makeAuthService() =>
      TypeService(typeDataProvider: _makeTypeDataProvider());
  TypeListViewModel _makeTypeListViewModel() =>
      TypeListViewModel(typesProvider: _makeAuthService());
}

class ScreenFactoryDefault implements ScreenFactory {
  final _DIContainer _diContainer;
  const ScreenFactoryDefault(this._diContainer);

  @override
  Widget makeTypeListScreen() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeTypeListViewModel(),
      lazy: false,
      child: const TypeListWidget(),
    );
  }

  // @override
  // Widget makeMainScreen() {
  //   // TODO: implement makeMainScreen
  //   throw UnimplementedError();
  // }

  // @override
  // Widget makeTypesScreen() {
  //   // TODO: implement makeTypesScreen
  //   throw UnimplementedError();
  // }
}
