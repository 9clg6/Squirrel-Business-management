import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:squirrel/application/config/app_config.dart';
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
  ],
)
Future<GetIt> initializeInjections(String environment) async =>
    GetIt.I.init(environment: environment);
