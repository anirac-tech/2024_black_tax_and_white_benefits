import 'package:logger/logger.dart';

// Not a singleton class
class WpaLogger {
  final _logger = Logger();

  void d(String message) {
    _logger.d(message);
  }

  void e(Object e, {StackTrace? stackTrace}) => switch (e) {
        String => _logger.e(e, stackTrace: stackTrace),
        Exception => _logger.e(e.toString(), error: e, stackTrace: stackTrace),
        Object() => _logger.e(e.toString(), stackTrace: stackTrace),
      };
}

final logger = WpaLogger();
