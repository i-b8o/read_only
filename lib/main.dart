import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'di/di_container.dart';

const ttsChannel = MethodChannel("com.b8o.read_only/tts");

// TODO styling for html
// TODO SafeArea
abstract class AppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = appFactory.makeApp();

  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn = Configuration.sentryUrl;
  //     options.tracesSampleRate = 1.0;
  //   },
  //   appRunner: () => runApp(app),
  // );
  runApp(app);
}
