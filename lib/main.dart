import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'di/di_container.dart';
import 'package:read_only/.configuration/configuration.dart';

// TODO styling for html
// TODO SafeArea
abstract class AppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

Future<void> main() async {
  final app = appFactory.makeApp();
  await SentryFlutter.init(
    (options) {
      options.dsn = Configuration.sentryUrl;
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(app),
  );
}
