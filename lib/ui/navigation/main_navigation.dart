import 'package:flutter/material.dart';

import '../widgets/app/app.dart';
import 'main_navigation_route_names.dart';

abstract class ScreenFactory {
  Widget makeTypeListScreen();
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

      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}
