import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:squirrel/application/config/app_config.dart';
import 'package:squirrel/foundation/enums/env_field.enum.dart';
import 'package:squirrel/foundation/utils/logger.util.dart';
import 'package:squirrel/ui/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';

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
        build(
          const ProviderScope(
            child: App(),
          ),
        ),
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

    await windowManager.ensureInitialized();

    const WindowOptions windowOptions = WindowOptions(
      center: true,
      skipTaskbar: false,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.maximize();
      await windowManager.setMinimumSize(const Size(1024, 768));
    });

    await dotenv.load();

    // Initialisation de Supabase
    await Supabase.initialize(
      url: dotenv.env[EnvField.supabaseUrl.path]!,
      anonKey: dotenv.env[EnvField.supabaseAnonKey.path]!,
    );

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
