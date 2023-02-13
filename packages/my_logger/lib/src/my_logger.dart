import 'package:logging/logging.dart';

class MyLogger {
  static final MyLogger _singleton = MyLogger._internal();
  factory MyLogger() => _singleton;
  MyLogger._internal();

  final Logger _logger = Logger('MyLogger');

  Logger getLogger() => _logger;
}
