import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:squirrel/application/config/app_config.dart';
import 'package:squirrel/foundation/utils/logger.util.dart';
import 'package:squirrel/ui/app.dart';

/// The kernel of the application.
class Kernel {
  /// Constructor
  /// @param [appConfig] app config
  ///
  Kernel({
    required this.appConfig,
  });

  /// Constructor for testing
  ///
  Kernel.test() : appConfig = AppConfig.test();

  /// App config
  final AppConfig appConfig;

  /// Run the application
  ///
  void run() {
    _run();
  }

  /// Run the application
  ///
  void _run() {
    initializeDateFormatting('fr_FR').then(
      (_) => runApp(
        build(const App()),
      ),
    );
  }

  /// Proceed to all initialization
  ///
  Future<void> bootstrap() async {
    await _ensureInitialized();
  }

  /// Ensure all initialization is done
  ///
  Future<void> _ensureInitialized() async {
    logInfo("Début de l'initialisation");

    // Initialisation de base de Flutter
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    // Initialisation de Hive
    await Hive.initFlutter();
  }

  /// Build [app] surrounded by all necessary widgets
  /// @param [app] app
  /// @return [Widget] widget of the app
  ///
  Widget build(Widget app) {
    return EasyLocalization(
      supportedLocales: const <Locale>[Locale('fr')],
      path: 'assets/translations',
      child: app,
    );
  }
}
