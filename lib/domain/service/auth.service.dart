import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:init/data/model/local/login_result.local_model.dart';
import 'package:init/data/storage/hive_secure_storage.dart';
import 'package:init/domain/entities/login_result.entity.dart';
import 'package:init/domain/use_case/check_validity.use_case.dart';
import 'package:init/domain/use_case/login.use_case.dart';
import 'package:init/foundation/routing/app_router.dart';

/// [AuthService]
class AuthService {
  /// License id key
  static const String _license = 'licenseKey';

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
    log('Start get saved licence and check validity');
    final String? license = await _secureStorageService.get(_license);

    if (license != null) {
      log('License found: $license');
      final LoginResultLocalModel loginResult =
          LoginResultLocalModel.fromJson(jsonDecode(license));
          
      final bool isValid = await _checkValidityUseCase.execute(loginResult.licenseKey);

      if (isValid) {
        log('License is valid');
        _setUserAuthenticated(
          true,
          licenseId: loginResult.licenseKey,
          expirationDate: loginResult.expirationDate,
        );
      } else {
        log('License is not valid');
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
      log('Start periodic check validity');
      final bool isValid = await checkValidity();
      if (!isValid) {
        log('License is not valid');
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
    log('Start check validity');
    final String? license = await _secureStorageService.get(_license);

    if (license == null) {
      log('License not found');
      return false;
    }
    log('License found: $license');
    final LoginResultLocalModel loginResult =
        LoginResultLocalModel.fromJson(jsonDecode(license));

    return _checkValidityUseCase.execute(loginResult.licenseKey);
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
    log('Set user authenticated: $isAuthenticated');
    _isUserAuthenticated = isAuthenticated;
    this.licenseId = licenseId;
    this.expirationDate = expirationDate;
  }

  /// Login
  /// @param [licenseKey] license key
  /// @return [bool] login result
  ///
  Future<bool> login(String licenseKey) async {
    log('Start login');
    final LoginResultEntity loginResult =
        await _loginUseCase.execute(licenseKey);

    if (loginResult.valid) {
      log('Login successful');
      await _secureStorageService.set(
        _license,
        jsonEncode(loginResult.toLocalModel().toJson()),
      );
      _setUserAuthenticated(
        true,
        licenseId: licenseKey,
        expirationDate: loginResult.expirationDate,
      );
    } else {
      log('Login failed');
    }

    return loginResult.valid;
  }
}
