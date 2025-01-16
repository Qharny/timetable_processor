import 'package:logger/logger.dart';

Logger? _logger;

Logger getLogger() {
  _logger ??= Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );
  return _logger!;
}
