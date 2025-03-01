import 'dart:developer';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

/// Filtre personnalisé pour n'afficher que les erreurs et exceptions
class ErrorOnlyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // Ne logger que les niveaux error, wtf et nothing
    return event.level.index >= Level.error.index;
  }
}

/// Output personnalisé qui n'écrit dans le fichier que les erreurs
class SelectiveFileOutput extends LogOutput {
  final File? _logFile;
  static File? _cachedLogFile;
  final ConsoleOutput _consoleOutput = ConsoleOutput();

  SelectiveFileOutput() : _logFile = _cachedLogFile;

  static Future<void> initLogFile() async {
    if (_cachedLogFile != null) return;

    try {
      final Directory documentsDir = await getApplicationDocumentsDirectory();
      final String logFilePath = '${documentsDir.path}/app_logs.txt';
      _cachedLogFile = File(logFilePath);

      // Créer le fichier s'il n'existe pas
      if (!await _cachedLogFile!.exists()) {
        await _cachedLogFile!.create(recursive: true);
      }

      // Ajouter un en-tête avec la date de démarrage
      await _cachedLogFile!.writeAsString(
          '=== Session de log démarrée le ${DateTime.now()} ===\n',
          mode: FileMode.append);
    } catch (e) {
      log('Erreur lors de l\'initialisation du fichier de log: $e');
    }
  }

  @override
  void output(OutputEvent event) {
    // Toujours afficher dans la console
    _consoleOutput.output(event);
    
    // Écrire dans le fichier de log uniquement si c'est une erreur
    if (_logFile != null && event.level.index >= Level.error.index) {
      try {
        for (var line in event.lines) {
          _logFile!.writeAsString(
            '${DateTime.now()} [${event.level}] $line\n',
            mode: FileMode.append,
          );
        }
      } on Exception catch (e) {
        log('Erreur lors de l\'écriture dans le fichier de log: $e');
      }
    }
  }
}

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
    printEmojis: true,
  ),
  output: SelectiveFileOutput(),
);

/// Méthodes utilitaires pour faciliter l'utilisation du logger

/// Log une exception avec sa stack trace
void logException(dynamic exception,
    [StackTrace? stackTrace, String? context]) {
  final message = context != null ? '$context: $exception' : '$exception';
  logger.e(message, error: exception, stackTrace: stackTrace);
}

/// Log une erreur simple
void logError(String message, [dynamic error]) {
  logger.e(message, error: error);
}

/// Log un avertissement
void logWarning(String message) {
  logger.w(message);
}

/// Log une information
void logInfo(String message) {
  logger.i(message);
}

/// Log un message de debug
void logDebug(String message) {
  logger.d(message);
}

/// Wrapper pour exécuter une fonction avec gestion d'erreur et logging
Future<T?> withErrorLogging<T>(
  Future<T> Function() function, {
  String? context,
  T? defaultValue,
}) async {
  try {
    return await function();
  } catch (e, stackTrace) {
    logException(e, stackTrace, context);
    return defaultValue;
  }
}
