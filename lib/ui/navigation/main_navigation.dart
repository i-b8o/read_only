import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';

import '../widgets/app/app.dart';
import 'main_navigation_route_names.dart';

abstract class ScreenFactory {
  Widget makeTypeListScreen();
  Widget makeSubtypeListScreen(Int64 id);
  Widget makeDocListScreen(Int64 id);
}

class MainNavigation implements AppNavigation {
  final ScreenFactory screenFactory;

  const MainNavigation(this.screenFactory);

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.typeListScreen:
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeTypeListScreen(),
        );
      case MainNavigationRouteNames.subtypeListScreen:
        final arguments = settings.arguments;
        final id = arguments is Int64 ? arguments : Int64(0);

        return MaterialPageRoute(
          builder: (_) => screenFactory.makeSubtypeListScreen(id),
        );
      case MainNavigationRouteNames.docListScreen:
        final arguments = settings.arguments;
        final id = arguments is Int64 ? arguments : Int64(0);

        return MaterialPageRoute(
          builder: (_) => screenFactory.makeDocListScreen(id),
        );

      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}
