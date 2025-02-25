import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/entities/request.entity.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/use_case/check_validity.use_case.dart';
import 'package:squirrel/domain/use_case/login.use_case.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';
import 'package:squirrel/foundation/routing/app_router.dart';

/// [AuthService]
class AuthService {
  /// License id key
  static const String _license = 'licenseKey';

  /// Login use case
  final LoginUseCase _loginUseCase;

  /// Check validity use case
  final CheckValidityUseCase _checkValidityUseCase;

  /// Secure storage service
  late final StorageInterface _secureStorageService;

  /// Request service
  late final RequestService _requestService;

  /// Is user authenticated
  bool _isUserAuthenticated = false;
  bool get isUserAuthenticated => _isUserAuthenticated;

  /// License id
  String? _licenseId;
  String? get licenseId => _licenseId;

  /// Expiration date
  DateTime? _expirationDate;
  DateTime? get expirationDate => _expirationDate;

  Timer? _timer;

  /// Constructor
  /// @param [_loginUseCase] login use case
  /// @param [_secureStorageService] secure storage service
  /// @param [_requestService] request service
  /// @param [_checkValidityUseCase] check validity use case
  ///
  AuthService._(
    this._loginUseCase,
    this._checkValidityUseCase,
    this._secureStorageService,
    this._requestService,
  );

  /// Inject auth service
  /// @param [loginUseCase] login use case
  /// @param [secureStorageService] secure storage service
  /// @param [requestService] request service
  /// @param [checkValidityUseCase] check validity use case
  /// @return [AuthService] auth service
  ///
  static Future<AuthService> inject(
    LoginUseCase loginUseCase,
    CheckValidityUseCase checkValidityUseCase,
    StorageInterface secureStorageService,
    RequestService requestService,
  ) async {
    final authService = AuthService._(
      loginUseCase,
      checkValidityUseCase,
      secureStorageService,
      requestService,
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

      final bool isValid = await _checkValidityUseCase.execute(
        loginResult.licenseKey,
      );

      _requestService.addRequest(
        Request(
          name: 'Check license validity',
          description: 'Vérification de la validité de la licence',
          destination: 'Serveur de validation',
          parameters: {
            'licenseKey': loginResult.licenseKey,
          },
          date: DateTime.now(),
        ),
      );

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

  /// Dispose
  /// @return [void]
  ///
  void dispose() {
    _timer?.cancel();
  }

  /// Periodic check validity
  /// @return [void]
  ///
  void _periodicCheckValidity() {
    _timer = Timer.periodic(const Duration(hours: 5), (timer) async {
      try {
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
      } on Exception catch (e) {
        log('Error during periodic check validity: $e');
        if (_expirationDate != null && _expirationDate!.isAfter(DateTime.now())) {
          log('License is not valid');
          _setUserAuthenticated(
            false,
            licenseId: null,
          );
          _timer?.cancel();
          appRouter.go('/auth');
        }
      }
    });
  }

  /// Check if license is expired locally
  /// @return [bool] true if expired
  ///
  bool isLicenseExpiredLocally() {
    if (_expirationDate == null) {
      return true;
    }
    return DateTime.now().isAfter(_expirationDate!);
  }

  /// Check validity of license
  /// @return [bool] validity
  ///
  Future<bool> checkValidity() async {
    log('Start check validity');
    
    // Vérification locale de l'expiration avant d'appeler le serveur
    if (isLicenseExpiredLocally()) {
      log('License is expired locally');
      return false;
    }
    
    final String? license = await _secureStorageService.get(_license);

    if (license == null) {
      log('License not found');
      return false;
    }
    log('License found: $license');
    final LoginResultLocalModel loginResult =
        LoginResultLocalModel.fromJson(jsonDecode(license));

    _requestService.addRequest(
      Request(
        name: 'Check license validity',
        description: 'Vérification de la validité de la licence',
        destination: 'Serveur de validation',
        parameters: {
          'licenseKey': loginResult.licenseKey,
        },
        date: DateTime.now(),
      ),
    );

    return _checkValidityUseCase.execute(loginResult.licenseKey);
  }

  /// Set user authenticated
  /// @param [isAuthenticated] is user authenticated
  /// @param [licenseId] license id
  /// @param [expirationDate] expiration date
  ///
  void _setUserAuthenticated(
    bool isAuthenticated, {
    String? licenseId,
    DateTime? expirationDate,
  }) {
    log('Set user authenticated: $isAuthenticated');
    _isUserAuthenticated = isAuthenticated;
    _licenseId = licenseId;
    _expirationDate = expirationDate;
  }

  /// Login
  /// @param [licenseKey] license key
  /// @return [bool] login result
  ///
  Future<bool> login(String licenseKey) async {
    log('Start login');

    _requestService.addRequest(
      Request(
        name: 'Login',
        description: 'Connexion à l\'application',
        destination: 'Serveur de connexion',
        parameters: {
          'licenseKey': licenseKey,
        },
        date: DateTime.now(),
      ),
    );

    final LoginResultEntity loginResult =
        await _loginUseCase.execute(licenseKey);

    if (loginResult.valid) {
      log('Login successful');
      if (_timer != null && !_timer!.isActive) {
        _periodicCheckValidity();
      }
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
