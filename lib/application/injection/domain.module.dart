import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:squirrel/application/env/env.dart';
import 'package:squirrel/data/repository/preferences/preferences.repository.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/service/secure_storage.service.dart';
import 'package:squirrel/domain/use_case/get_theme.use_case.dart';

@module
abstract class DomainModule {
  /// Allow to inject [EnvService]
  @injectable
  @preResolve
  Future<EnvService> envService() async => await EnvService.injector();

  /// Allow to inject [FlutterSecureStorage]
  @injectable
  FlutterSecureStorage storage() => const FlutterSecureStorage(
        wOptions: WindowsOptions(),
        mOptions: MacOsOptions(
          synchronizable: true,
          accessibility: KeychainAccessibility.unlocked,
          accountName: 'squirrel_app_keychain',
        ),
      );

  /// Allow to inject [SecureStorageService]
  @singleton
  @preResolve
  Future<SecureStorageService> secureStorageService(
    FlutterSecureStorage storage,
  ) async =>
      SecureStorageService.inject(storage);

  /// Allow to inject [HiveSecureStorageService]
  @singleton
  @preResolve
  Future<HiveSecureStorageService> hiveSecureStorageService(
          SecureStorageService secureStorageService) =>
      HiveSecureStorageService.inject(secureStorageService);

  /// Allow to inject [RequestService]
  @singleton
  RequestService requestService() => RequestService();

  /// Provide the shellNavigatorKey
  @singleton
  GlobalKey<NavigatorState> provideShellNavigatorKey() =>
      GlobalKey<NavigatorState>();

  /// Allow to inject [GetThemeUseCase]
  @injectable
  GetThemeUseCase getThemeUseCase(
    PreferencesRepository preferencesRepository,
  ) =>
      GetThemeUseCase(preferencesRepository);

  /// Allow to inject [DialogService]
  @singleton
  DialogService dialogService(
    GlobalKey<NavigatorState> navigatorKey,
  ) =>
      DialogService(navigatorKey);

  /// Allow to inject [NavigatorService]
  @singleton
  NavigatorService navigatorService(
    GlobalKey<NavigatorState> navigatorKey,
  ) =>
      NavigatorService(navigatorKey);
}
