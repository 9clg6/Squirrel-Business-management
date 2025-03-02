import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:squirrel/application/config/app_config.dart';
import 'package:squirrel/application/env/env.dart';
import 'package:squirrel/application/providers/initializer.config.dart';

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
    EnvService,
  ],
)
Future<GetIt> initializeInjections() async {
  return await GetIt.I.init();
}
