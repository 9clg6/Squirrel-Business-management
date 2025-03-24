// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:squirrel/application/env/env.dart' as _i714;
import 'package:squirrel/application/injection/data.module.dart' as _i70;
import 'package:squirrel/application/injection/domain.module.dart' as _i844;
import 'package:squirrel/data/local_data_source/preferences/preferences_local.data_source.dart'
    as _i939;
import 'package:squirrel/data/repository/preferences/preferences.repository.dart'
    as _i513;
import 'package:squirrel/data/storage/hive_secure_storage.dart' as _i241;
import 'package:squirrel/domain/service/dialog.service.dart' as _i635;
import 'package:squirrel/domain/service/hive_secure_storage.service.dart'
    as _i1041;
import 'package:squirrel/domain/service/navigator.service.dart' as _i216;
import 'package:squirrel/domain/service/request_service.dart' as _i392;
import 'package:squirrel/domain/service/secure_storage.service.dart' as _i1072;
import 'package:squirrel/domain/use_case/get_theme.use_case.dart' as _i173;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final domainModule = _$DomainModule();
    final dataModule = _$DataModule();
    await gh.factoryAsync<_i714.EnvService>(
      () => domainModule.envService(),
      preResolve: true,
    );
    gh.factory<_i558.FlutterSecureStorage>(() => domainModule.storage());
    gh.singleton<_i392.RequestService>(() => domainModule.requestService());
    gh.singleton<_i409.GlobalKey<_i409.NavigatorState>>(
        () => domainModule.provideShellNavigatorKey());
    gh.singleton<_i635.DialogService>(() => domainModule
        .dialogService(gh<_i409.GlobalKey<_i409.NavigatorState>>()));
    gh.singleton<_i216.NavigatorService>(() => domainModule
        .navigatorService(gh<_i409.GlobalKey<_i409.NavigatorState>>()));
    await gh.singletonAsync<_i1072.SecureStorageService>(
      () => domainModule.secureStorageService(gh<_i558.FlutterSecureStorage>()),
      preResolve: true,
    );
    await gh.singletonAsync<_i1041.HiveSecureStorageService>(
      () => domainModule
          .hiveSecureStorageService(gh<_i1072.SecureStorageService>()),
      preResolve: true,
    );
    await gh.singletonAsync<_i241.HiveSecureStorage>(
      () => dataModule.hiveSecureStorage(gh<_i1072.SecureStorageService>()),
      preResolve: true,
    );
    gh.factory<_i939.PreferencesLocalDataSource>(() => dataModule
        .preferencesLocalDataSourcesImpl(gh<_i241.HiveSecureStorage>()));
    gh.factory<_i513.PreferencesRepository>(() => dataModule
        .preferencesRepository(gh<_i939.PreferencesLocalDataSource>()));
    gh.factory<_i173.GetThemeUseCase>(
        () => domainModule.getThemeUseCase(gh<_i513.PreferencesRepository>()));
    return this;
  }
}

class _$DomainModule extends _i844.DomainModule {}

class _$DataModule extends _i70.DataModule {}
