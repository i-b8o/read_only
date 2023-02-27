import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/theme/theme.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';

import '../../navigation/main_navigation_route_names.dart';

abstract class AppNavigation {
  Route<Object> onGenerateRoute(RouteSettings settings);
}

abstract class AppService {
  bool isDarkModeOn();
}

class App extends StatelessWidget {
  final AppNavigation navigation;
  const App({
    super.key,
    required this.navigation,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DrawerViewModel>();
    final settings = model.appSettings;
    if (settings == null) {
      return const MaterialApp(
          home: Center(
        child: Text("Что-то пошло не так"),
      ));
    }
    return MaterialApp(
      theme: model.appSettings!.darkModeOn
          ? ReadOnlyTheme.dark
          : ReadOnlyTheme.light,
      darkTheme: ReadOnlyTheme.dark,
      initialRoute: MainNavigationRouteNames.typeListScreen,
      onGenerateRoute: navigation.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
