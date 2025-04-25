import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:squirrel/foundation/constants/constants.dart';

/// A service for logging messages
class LoggerService {
  /// Private constructor
  /// @param [Logger] consoleLogger
  /// @param [Logger] fileLogger
  /// @return [LoggerService]
  ///
  LoggerService._internal(this._consoleLogger, this._fileLogger);

  /// The instance
  static LoggerService get instance {
    if (_instance == null) {
      throw Exception(
        'LoggerService non initialisé. Appelle LoggerService.init() avant toute utilisation.',
      );
    }
    return _instance!;
  }

  /// The log file name
  static const String _logFileName = 'app.log';

  static LoggerService? _instance;

  /// Initialize the logger
  /// @return [void]
  ///
  static Future<void> init() async {
    // --- File Logger Setup ---
    final Directory dir = await getApplicationDocumentsDirectory();
    final Directory createdDirectory =
        await Directory('${dir.path}/$appFolderName').create(recursive: true);

    final File file = File('${createdDirectory.path}/$_logFileName');

    final CustomFileLogger fileOutput = CustomFileLogger(file: file);
    final Logger fileLogger = Logger(
      printer: SimpleFilePrinter(),
      output: fileOutput,
      level: Level.trace,
    );

    // --- Console Logger Setup ---
    final ConsoleOutput consoleOutput = ConsoleOutput();
    final Logger consoleLogger = Logger(
      printer: PrettyPrinter(),
      output: consoleOutput,
      level: Level.debug,
    );

    _instance = LoggerService._internal(consoleLogger, fileLogger);
    instance.i('===== Logger Service Initialized =====');
  }

  /// The logger instance for console
  final Logger _consoleLogger;

  /// The logger instance for file
  final Logger _fileLogger;

  /// Log a debug message
  /// @param [dynamic] message
  /// @return [void]
  ///
  void d(dynamic message) {
    _consoleLogger.d(message);
    _fileLogger.d(message);
  }

  /// Log an info message
  /// @param [dynamic] message
  /// @return [void]
  ///
  void i(dynamic message) {
    _consoleLogger.i(message);
    _fileLogger.i(message);
  }

  /// Log a warning message
  /// @param [dynamic] message
  /// @return [void]
  ///
  void w(dynamic message) {
    _consoleLogger.w(message);
    _fileLogger.w(message);
  }

  /// Log an error message
  /// @param [dynamic] message
  /// @param [dynamic] error
  /// @param [StackTrace] stackTrace
  /// @return [void]
  ///
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _consoleLogger.e(message, error: error, stackTrace: stackTrace);
    _fileLogger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a fatal message
  /// @param [dynamic] message
  /// @param [dynamic] error
  /// @param [StackTrace] stackTrace
  /// @return [void]
  ///
  void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _consoleLogger.f(message, error: error, stackTrace: stackTrace);
    _fileLogger.f(message, error: error, stackTrace: stackTrace);
  }
}

/// A custom file logger that handles daily rotation and simple formatting.
class CustomFileLogger extends LogOutput {
  /// Constructor
  /// @param [File] file
  /// @return [CustomFileLogger]
  ///
  CustomFileLogger({required this.file});

  /// The file
  final File file;

  // Note: We don't need a printer here anymore,
  // as the formatting is done by the Logger instance using SimpleFilePrinter.

  /// Output the event
  /// @param [OutputEvent] event
  /// @return [void]
  ///
  @override
  void output(OutputEvent event) {
    final DateTime now = DateTime.now();
    final String todayString =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    String? firstLine;
    if (file.existsSync()) {
      final List<String> lines = file.readAsLinesSync();
      if (lines.isNotEmpty) {
        firstLine = lines.first;
      }
    }

    bool writeHeader = false;
    if (firstLine == null || !firstLine.contains(todayString)) {
      // Write header in write mode (overwrite)
      file.writeAsStringSync(
        '=== Session de log démarrée le $todayString ===\n',
        flush: true,
      );
      writeHeader = true;
    }

    // Append logs
    // Use FileMode.append only if we didn't just write the header
    final FileMode mode = writeHeader ? FileMode.write : FileMode.append;
    for (final String line in event.lines) {
      // event.lines now contain the simply formatted logs from SimpleFilePrinter
      final String logLine = '[${now.toIso8601String()}] $line\n';
      file.writeAsStringSync(logLine, mode: mode, flush: true);
    }
  }
}

/// A simple file printer
class SimpleFilePrinter extends LogPrinter {
  /// Constructor
  /// @return [SimpleFilePrinter]
  ///
  SimpleFilePrinter();

  /// Log the event
  @override
  List<String> log(LogEvent event) {
    // Customize the simple format here if needed
    final dynamic messageStr = event.message is Function
        ? (event.message as Function)()
        : event.message;
    final String errorStr =
        event.error != null ? '\nError: ${event.error}' : '';
    final String stackTraceStr =
        event.stackTrace != null ? '\nStackTrace: ${event.stackTrace}' : '';
    return <String>[
      '[${event.level.name.toUpperCase()}] $messageStr$errorStr$stackTraceStr',
    ];
  }
}
