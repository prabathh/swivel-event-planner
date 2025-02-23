import 'package:logger/logger.dart';

class LogService {
  // Main Logger
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  // Info Logger
  static void info(String message) {
    _logger.i(message);
  }

  // Debug Logger
  static void debug(String message) {
    _logger.d(message);
  }

  // Warning Logger
  static void warning(String message) {
    _logger.w(message);
  }

  // Error Logger
  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}