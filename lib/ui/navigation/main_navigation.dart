import 'package:flutter/material.dart';

import '../widgets/app/app.dart';
import 'main_navigation_route_names.dart';

abstract class ScreenFactory {
  Widget makeTypeListScreen();
  Widget makeNotesScreen();
  Widget makeSubtypeListScreen(int id);
  Widget makeDocListScreen(int id);
  Widget makeChapterListScreen(int id);
  Widget makeChapterScreen(String url);
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
        final id = arguments is int ? arguments : 0;

        return MaterialPageRoute(
          builder: (_) => screenFactory.makeSubtypeListScreen(id),
        );
      case MainNavigationRouteNames.docListScreen:
        final arguments = settings.arguments;
        final id = arguments is int ? arguments : 0;

        return MaterialPageRoute(
          builder: (_) => screenFactory.makeDocListScreen(id),
        );
      case MainNavigationRouteNames.chapterListScreen:
        final arguments = settings.arguments;
        final id = arguments is int ? arguments : 0;

        return MaterialPageRoute(
          builder: (_) => screenFactory.makeChapterListScreen(id),
        );
      case MainNavigationRouteNames.chapterScreen:
        final arguments = settings.arguments;
        final url = arguments is String ? arguments : "0";

        return MaterialPageRoute(
          builder: (_) => screenFactory.makeChapterScreen(url),
        );

      case MainNavigationRouteNames.notesScreen:
        return MaterialPageRoute(
          builder: (_) => screenFactory.makeNotesScreen(),
        );

      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}
