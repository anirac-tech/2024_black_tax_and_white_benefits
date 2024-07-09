import 'package:logger/logger.dart';

// Not a singleton class
class Log {
  static final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
  ));

  static void d(String message) => logger.d(message);

  static void w(String message) => logger.w(message); // coverage:ignore-line

  static void e(
    String message,
    Object error, {
    StackTrace? stackTrace,
  }) =>
      logger.e(message, error: error, stackTrace: stackTrace);
}
