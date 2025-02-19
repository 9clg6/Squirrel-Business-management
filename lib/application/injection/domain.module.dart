import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:init/data/repository/auth/authentication.repository.dart';
import 'package:init/data/repository/preferences/preferences.repository.dart';
import 'package:init/data/storage/hive_secure_storage.dart';
import 'package:init/domain/service/auth.service.dart';
import 'package:init/domain/service/dialog.service.dart';
import 'package:init/domain/service/navigator.service.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/domain/service/secure_storage.service.dart';
import 'package:init/domain/use_case/get_theme.use_case.dart';
import 'package:init/domain/use_case/login.use_case.dart';
import 'package:init/foundation/routing/app_router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DomainModule {
  /// Allow to inject [LoginUseCase]
  @injectable
  LoginUseCase loginUseCase(
    AuthenticationRepository authenticationRepository,
  ) =>
      LoginUseCase(authenticationRepository);

  ///
  @injectable
  FlutterSecureStorage storage() => const FlutterSecureStorage(
        mOptions: MacOsOptions(
          accessibility: KeychainAccessibility.unlocked,
        ),
      );

  /// Allow to inject [SecureStorageService]
  @singleton
  @preResolve
  Future<SecureStorageService> secureStorageService(
    FlutterSecureStorage storage,
  ) async =>
      SecureStorageService.inject(storage);

  /// Allow to inject [AuthService]
  @singleton
  AuthService authService(
    LoginUseCase loginUseCase,
    HiveSecureStorage hiveSecureStorage,
  ) =>
      AuthService(
        loginUseCase,
        hiveSecureStorage,
      );

  /// Provide the navigatorKey
  @singleton
  GlobalKey<NavigatorState> provideNavigatorKey() => rootNavigatorKey;

  /// Allow to inject [GetThemeUseCase]
  @injectable
  GetThemeUseCase getThemeUseCase(
    PreferencesRepository preferencesRepository,
  ) =>
      GetThemeUseCase(preferencesRepository);

  /// Allow to inject [OrderService]
  @singleton
  OrderService orderService() => OrderService();

  /// Allow to inject [DialogService]
  @singleton
  DialogService dialogService(GlobalKey<NavigatorState> navigatorKey) =>
      DialogService(navigatorKey);

  /// Allow to inject [NavigatorService]
  @singleton
  NavigatorService navigatorService() => NavigatorService();
}
