import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:squirrel/application/env/env.dart';
import 'package:squirrel/data/repository/auth/authentication.repository.dart';
import 'package:squirrel/data/repository/preferences/preferences.repository.dart';
import 'package:squirrel/data/storage/hive_secure_storage.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/service/secure_storage.service.dart';
import 'package:squirrel/domain/use_case/check_validity.use_case.dart';
import 'package:squirrel/domain/use_case/get_theme.use_case.dart';
import 'package:squirrel/domain/use_case/login.use_case.dart';

@module
abstract class DomainModule {
  /// Allow to inject [EnvService]
  @injectable
  @preResolve
  Future<EnvService> envService() async => await EnvService.injector();

  /// Allow to inject [LoginUseCase]
  @injectable
  LoginUseCase loginUseCase(
    AuthenticationRepository authenticationRepository,
  ) =>
      LoginUseCase(authenticationRepository);

  /// Allow to inject [CheckValidityUseCase]
  @injectable
  CheckValidityUseCase checkValidityUseCase(
    AuthenticationRepository authenticationRepository,
  ) =>
      CheckValidityUseCase(authenticationRepository);

  ///
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

  /// Provide the navigatorKey
  @singleton
  @Named('root')
  GlobalKey<NavigatorState> provideNavigatorKey() =>
      GlobalKey<NavigatorState>(debugLabel: 'root');

  /// Provide the shellNavigatorKey
  @singleton
  @Named('shell')
  GlobalKey<NavigatorState> provideShellNavigatorKey() =>
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  /// Allow to inject [AuthService]
  @singleton
  @preResolve
  Future<AuthService> authService(
    LoginUseCase loginUseCase,
    CheckValidityUseCase checkValidityUseCase,
    HiveSecureStorage hiveSecureStorage,
    RequestService requestService,
    @Named('root') GlobalKey<NavigatorState> navigatorKey,
    EnvService envService,
  ) async =>
      AuthService.inject(
        loginUseCase,
        checkValidityUseCase,
        hiveSecureStorage,
        requestService,
        navigatorKey,
        envService,
      );

  /// Allow to inject [GetThemeUseCase]
  @injectable
  GetThemeUseCase getThemeUseCase(
    PreferencesRepository preferencesRepository,
  ) =>
      GetThemeUseCase(preferencesRepository);

  /// Allow to inject [DialogService]
  @singleton
  DialogService dialogService(
    @Named('root') GlobalKey<NavigatorState> navigatorKey,
  ) =>
      DialogService(navigatorKey);

  /// Allow to inject [NavigatorService]
  @singleton
  NavigatorService navigatorService(
    @Named('root') GlobalKey<NavigatorState> navigatorKey,
  ) =>
      NavigatorService(navigatorKey);

  /// Allow to inject [BusinessTypeService]
  @singleton
  @preResolve
  Future<BusinessTypeService> serviceTypeService(
    HiveSecureStorageService secureStorageService,
  ) =>
      BusinessTypeService.inject(secureStorageService);

}
