import 'package:flutter/material.dart';
import 'di/di_container.dart';

// TODO styling for html
// TODO SafeArea
abstract class AppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

void main() {
  final app = appFactory.makeApp();
  runApp(app);
}
