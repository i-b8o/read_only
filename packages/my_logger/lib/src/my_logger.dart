import 'package:logging/logging.dart';

class L {
  static final Logger _logger = Logger('MyApp');

  static void initialize() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  static void info(dynamic message) {
    _logger.info(message);
  }

  static void warning(dynamic message) {
    _logger.warning(message);
  }

  static void error(dynamic message) {
    _logger.severe(message);
  }

  static void debug(dynamic message) {
    _logger.fine(message);
  }
}
