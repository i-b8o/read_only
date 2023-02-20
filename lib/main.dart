import 'dart:isolate';

import 'package:flutter/material.dart';

import 'di/di_container.dart';

abstract class AppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = appFactory.makeApp();
  runApp(app);
}
