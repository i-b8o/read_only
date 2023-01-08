import 'package:flutter/material.dart';
import 'package:read_only/ui/theme/theme.dart';

import '../../navigation/main_navigation_route_names.dart';

abstract class AppNavigation {
  Route<Object> onGenerateRoute(RouteSettings settings);
}

class App extends StatelessWidget {
  final AppNavigation navigation;

  const App({super.key, required this.navigation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ReadOnlyTheme.light,
      darkTheme: ReadOnlyTheme.dark,
      initialRoute: MainNavigationRouteNames.typeListScreen,
      onGenerateRoute: navigation.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
