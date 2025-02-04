import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:init/data/repository/preferences/preferences.repository.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/domain/service/secure_storage.service.dart';
import 'package:init/domain/service/theme.service.dart';
import 'package:init/domain/use_case/get_theme.use_case.dart';
import 'package:init/foundation/interfaces/theme.service_interface.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DomainModule {
  /// Allow to inject [ThemeService]
  @Singleton(as: IThemeService)
  @preResolve
  Future<ThemeService> themeService(GetThemeUseCase useCase) =>
      ThemeService.inject(useCase);

  ///
  @injectable
  FlutterSecureStorage storage() => const FlutterSecureStorage(
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      );

  /// Allow to inject [SecureStorageService]
  @singleton
  @preResolve
  Future<SecureStorageService> secureStorageService(
    FlutterSecureStorage storage,
  ) async =>
      SecureStorageService.inject(storage);

  /// Allow to inject [GetThemeUseCase]
  @injectable
  GetThemeUseCase getThemeUseCase(
    PreferencesRepository preferencesRepository,
  ) =>
      GetThemeUseCase(preferencesRepository);

  /// Allow to inject [OrderService]
  @singleton
  OrderService orderService() => OrderService();
}
