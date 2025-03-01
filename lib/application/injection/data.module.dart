import 'package:injectable/injectable.dart';
import 'package:squirrel/application/env/env.dart';
import 'package:squirrel/data/local_data_source/preferences/impl/preferences_local.data_source.impl.dart';
import 'package:squirrel/data/local_data_source/preferences/preferences_local.data_source.dart';
import 'package:squirrel/data/remote_data_source/authentication.data_source.dart';
import 'package:squirrel/data/remote_data_source/impl/authentication.data_source.impl.dart';
import 'package:squirrel/data/repository/auth/authentication.repository.dart';
import 'package:squirrel/data/repository/auth/impl/authentication.repository.impl.dart';
import 'package:squirrel/data/repository/preferences/impl/preferences_repository_impl.dart';
import 'package:squirrel/data/repository/preferences/preferences.repository.dart';
import 'package:squirrel/data/storage/hive_secure_storage.dart';
import 'package:squirrel/domain/service/secure_storage.service.dart';


@module
abstract class DataModule {

  /// Allow to inject [EnvService]
  @singleton
  @preResolve
  Future<EnvService> envService() async => await EnvService.injector();

  /// Allow to inject [HiveSecureStorage]
  @singleton
  @preResolve
  Future<HiveSecureStorage> hiveSecureStorage(
    SecureStorageService secureStorageService,
  ) async =>
      HiveSecureStorage.inject(secureStorageService);

  /// Allow to inject [PreferencesLocalDataSourcesImpl]
  @Injectable(as: PreferencesLocalDataSource)
  PreferencesLocalDataSourcesImpl preferencesLocalDataSourcesImpl(
    HiveSecureStorage storage,
  ) =>
      PreferencesLocalDataSourcesImpl(storage);

  /// Allow to inject [PreferencesRepositoryImpl]
  @Injectable(as: PreferencesRepository)
  PreferencesRepositoryImpl preferencesRepository(
    PreferencesLocalDataSource localDataSource,
  ) =>
      PreferencesRepositoryImpl(localDataSource);

  /// Allow to inject [AuthenticationDataSourceImpl]
  @Injectable(as: AuthenticationDataSource)
  AuthenticationDataSourceImpl authenticationDataSourceImpl() =>
      AuthenticationDataSourceImpl();

  /// Allow to inject [AuthenticationRepositoryImpl]
  @Injectable(as: AuthenticationRepository)
  AuthenticationRepositoryImpl authenticationRepository(
    AuthenticationDataSource authenticationDataSource,
  ) =>
      AuthenticationRepositoryImpl(authenticationDataSource);

}
