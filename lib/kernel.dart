// ignore_for_file: missing_provider_scope
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:squirrel/application/config/app_config.dart';
import 'package:squirrel/application/env/env.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/foundation/utils/logger.util.dart';
import 'package:squirrel/ui/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The kernel of the application.
class Kernel {
  /// App config
  final AppConfig appConfig;

  /// Constructor
  /// @param [appConfig] app config
  ///
  Kernel({
    required this.appConfig,
  });

  /// Constructor for testing
  ///
  Kernel.test() : appConfig = const AppConfig.test();

  /// Run the application
  ///
  void run() {
    if (!appConfig.isTest) {
      _run();
    }
  }

  /// Run the application
  ///
  void _run() {
    initializeDateFormatting('fr_FR', null).then(
      (_) => runApp(
        build(const App()),
      ),
    );
  }

  /// Proceed to all initialization
  ///
  Future<void> bootstrap() async {
    try {
      await _ensureInitialized();
      logInfo('Initialisation réussie');
    } catch (e, stackTrace) {
      logException(e, stackTrace, 'Erreur lors de l\'initialisation');
      // Continuer malgré l'erreur pour éviter un écran noir
    }
  }

  /// Ensure all initialization is done
  ///
  Future<void> _ensureInitialized() async {
    logInfo('Début de l\'initialisation');
    WidgetsFlutterBinding.ensureInitialized();

    // Initialiser le système de logs le plus tôt possible
    await SelectiveFileOutput.initLogFile();

    // Le système de logs est déjà initialisé dans main.dart
    logInfo('WidgetsFlutterBinding initialisé');

    injector.registerSingleton<AppConfig>(appConfig);
    injector.registerSingletonAsync<EnvService>(
      () async => await EnvService.injector(),
    );

    try {
      await injector.isReady<EnvService>();
      logInfo('EnvService initialisé');

      final EnvService envService = injector<EnvService>();
      logInfo('URL Supabase: ${envService.supabaseUrl}');

      try {
        await Supabase.initialize(
          url: envService.supabaseUrl,
          anonKey: envService.supabaseAnonKey,
        );
        logInfo('Supabase initialisé');
      } catch (e, stackTrace) {
        logException(
            e, stackTrace, 'Erreur lors de l\'initialisation de Supabase');
        // Continuer sans Supabase
      }

      try {
        await Hive.initFlutter();
        logInfo('Hive initialisé');
      } catch (e, stackTrace) {
        logException(e, stackTrace, 'Erreur lors de l\'initialisation de Hive');
        // Continuer sans Hive
      }

      // Register app config
      try {
        final GetIt getIt =
            await initializeInjections(appConfig.environment.name);
        await getIt.allReady();
        logInfo('Injections initialisées');
      } catch (e, stackTrace) {
        logException(
            e, stackTrace, 'Erreur lors de l\'initialisation des injections');
        // Continuer malgré l'erreur
      }

      // Initialize translations
      try {
        await EasyLocalization.ensureInitialized();
        logInfo('Traductions initialisées');
      } catch (e, stackTrace) {
        logException(
            e, stackTrace, 'Erreur lors de l\'initialisation des traductions');
        // Continuer malgré l'erreur
      }
    } catch (e, stackTrace) {
      logException(
          e, stackTrace, 'Erreur lors de l\'initialisation des services');
      // Continuer malgré l'erreur
    }
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
