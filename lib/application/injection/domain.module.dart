import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:squirrel/data/repository/auth/authentication.repository.dart';
import 'package:squirrel/data/repository/preferences/preferences.repository.dart';
import 'package:squirrel/data/storage/hive_secure_storage.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/service/secure_storage.service.dart';
import 'package:squirrel/domain/use_case/check_validity.use_case.dart';
import 'package:squirrel/domain/use_case/get_theme.use_case.dart';
import 'package:squirrel/domain/use_case/login.use_case.dart';
import 'package:squirrel/foundation/routing/app_router.dart';

@module
abstract class DomainModule {
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

  /// Allow to inject [HiveSecureStorageService]
  @singleton
  @preResolve
  Future<HiveSecureStorageService> hiveSecureStorageService(
          SecureStorageService secureStorageService) =>
      HiveSecureStorageService.inject(secureStorageService);

  /// Allow to inject [RequestService]
  @singleton
  RequestService requestService() => RequestService();

  /// Allow to inject [AuthService]
  @singleton
  @preResolve
  Future<AuthService> authService(
    LoginUseCase loginUseCase,
    CheckValidityUseCase checkValidityUseCase,
    HiveSecureStorage hiveSecureStorage,
    RequestService requestService,
  ) async =>
      AuthService.inject(
        loginUseCase,
        checkValidityUseCase,
        hiveSecureStorage,
        requestService,
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
  OrderService orderService(
    HiveSecureStorage hiveService,
    ClientService clientService,
  ) =>
      OrderService(hiveService, clientService);

  /// Allow to inject [DialogService]
  @singleton
  DialogService dialogService(GlobalKey<NavigatorState> navigatorKey) =>
      DialogService(navigatorKey);

  /// Allow to inject [NavigatorService]
  @singleton
  NavigatorService navigatorService() => NavigatorService();

  /// Allow to inject [BusinessTypeService]
  @singleton
  @preResolve
  Future<BusinessTypeService> serviceTypeService(
          HiveSecureStorageService secureStorageService) =>
      BusinessTypeService.inject(secureStorageService);

  /// Allow to inject [ClientService]
  @singleton
  ClientService clientService() => ClientService();
}
