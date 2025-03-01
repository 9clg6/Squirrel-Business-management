import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:squirrel/application/config/app_config.dart';
import 'package:squirrel/application/providers/initializer.config.dart';
import 'package:squirrel/foundation/utils/logger.util.dart';

///
/// The injector instance
///
final GetIt injector = GetIt.instance;

///
/// Setup injector
///
@InjectableInit(
  ignoreUnregisteredTypes: <Type>[
    AppConfig,
  ],
)
Future<GetIt> initializeInjections(String environment) async {
  try {
    logInfo('Initialisation des injections...');
    logInfo('Environnement: $environment');
    
    final getIt = await GetIt.I.init(
      environment: environment,
    );
    
    logInfo('Injections initialisées avec succès');
    return getIt;
  } catch (e, stackTrace) {
    logException(e, stackTrace, 'Erreur lors de l\'initialisation des injections');
    rethrow;
  }
}
