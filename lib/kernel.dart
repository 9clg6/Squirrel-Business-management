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
    _run();
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
    await _ensureInitialized();
  }

  /// Ensure all initialization is done
  ///
  Future<void> _ensureInitialized() async {
    logInfo('Début de l\'initialisation');
    WidgetsFlutterBinding.ensureInitialized();
    //await SelectiveFileOutput.initLogFile();

    await Hive.initFlutter();
    injector.registerSingleton<AppConfig>(appConfig);
    injector.registerSingletonAsync<EnvService>(
      () async => await EnvService.injector(),
    );

    final GetIt getIt = await initializeInjections();
    await getIt.allReady();

    final EnvService envService = injector<EnvService>();
    await Supabase.initialize(
      url: envService.supabaseUrl,
      anonKey: envService.supabaseAnonKey,
    );

    await EasyLocalization.ensureInitialized();
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
