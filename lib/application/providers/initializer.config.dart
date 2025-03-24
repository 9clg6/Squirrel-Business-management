// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:squirrel/application/env/env.dart' as _i714;
import 'package:squirrel/application/injection/domain.module.dart' as _i844;
import 'package:squirrel/domain/service/dialog.service.dart' as _i635;
import 'package:squirrel/domain/service/navigator.service.dart' as _i216;

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
    await gh.factoryAsync<_i714.EnvService>(
      () => domainModule.envService(),
      preResolve: true,
    );
    gh.singleton<_i409.GlobalKey<_i409.NavigatorState>>(
        () => domainModule.provideShellNavigatorKey());
    gh.singleton<_i635.DialogService>(() => domainModule
        .dialogService(gh<_i409.GlobalKey<_i409.NavigatorState>>()));
    gh.singleton<_i216.NavigatorService>(() => domainModule
        .navigatorService(gh<_i409.GlobalKey<_i409.NavigatorState>>()));
    return this;
  }
}

class _$DomainModule extends _i844.DomainModule {}
