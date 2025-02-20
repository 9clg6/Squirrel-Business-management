import 'dart:async';

import 'package:init/data/storage/hive_secure_storage.dart';
import 'package:init/domain/entities/login_result.entity.dart';
import 'package:init/domain/use_case/check_validity.use_case.dart';
import 'package:init/domain/use_case/login.use_case.dart';
import 'package:init/foundation/routing/app_router.dart';

/// [AuthService]
class AuthService {
  /// License id key
  static const String _licenseIdKey = 'licenseId';

  /// Login use case
  final LoginUseCase _loginUseCase;

  /// Check validity use case
  final CheckValidityUseCase _checkValidityUseCase;

  /// Secure storage service
  late final HiveSecureStorage _secureStorageService;

  /// Is user authenticated
  bool _isUserAuthenticated = false;
  bool get isUserAuthenticated => _isUserAuthenticated;

  /// License id
  String? licenseId;

  /// Expiration date
  DateTime? expirationDate;

  /// Constructor
  /// @param [_loginUseCase] login use case
  /// @param [_secureStorageService] secure storage service
  ///
  AuthService._(
    this._loginUseCase,
    this._checkValidityUseCase,
    this._secureStorageService,
  );

  /// Inject auth service
  /// @param [loginUseCase] login use case
  /// @param [secureStorageService] secure storage service
  /// @return [AuthService] auth service
  ///
  static Future<AuthService> inject(
    LoginUseCase loginUseCase,
    CheckValidityUseCase checkValidityUseCase,
    HiveSecureStorage secureStorageService,
  ) async {
    final authService = AuthService._(
      loginUseCase,
      checkValidityUseCase,
      secureStorageService,
    );

    await authService._getSavedLicenceAndCheckValidity();
    authService._periodicCheckValidity();
    return authService;
  }

  /// Get saved licence
  /// @return [void]
  ///
  Future<void> _getSavedLicenceAndCheckValidity() async {
    final String? license = await _secureStorageService.get(_licenseIdKey);

    if (license != null) {
      final bool isValid = await _checkValidityUseCase.execute(license);

      if (isValid) {
        _setUserAuthenticated(
          true,
          licenseId: license,
        );
      } else {
        _setUserAuthenticated(
          false,
          licenseId: null,
        );
      }
    }
  }

  /// Periodic check validity
  /// @return [void]
  ///
  void _periodicCheckValidity() {
    Timer.periodic(const Duration(hours: 5), (timer) async {
      final bool isValid = await checkValidity();
      if (!isValid) {
        _setUserAuthenticated(
          false,
          licenseId: null,
        );
        appRouter.go('/auth');
      }
    });
  }

  /// Check validity of license
  /// @return [bool] validity
  ///
  Future<bool> checkValidity() async {
    final String? license = await _secureStorageService.get(_licenseIdKey);

    if (license == null) {
      return false;
    }

    return _checkValidityUseCase.execute(license);
  }

  /// Set user authenticated
  /// @param [isAuthenticated] is user authenticated
  /// @param [licenseId] license id
  ///
  void _setUserAuthenticated(
    bool isAuthenticated, {
    String? licenseId,
    DateTime? expirationDate,
  }) {
    _isUserAuthenticated = isAuthenticated;
    this.licenseId = licenseId;
    this.expirationDate = expirationDate;
  }

  /// Login
  /// @param [licenseKey] license key
  /// @return [bool] login result
  ///
  Future<bool> login(String licenseKey) async {
    final LoginResultEntity loginResult =
        await _loginUseCase.execute(licenseKey);

    if (loginResult.valid) {
      await _secureStorageService.set(
        _licenseIdKey,
        licenseKey,
      );
      _setUserAuthenticated(
        true,
        licenseId: licenseKey,
        expirationDate: loginResult.expirationDate,
      );
    }

    return loginResult.valid;
  }
}
