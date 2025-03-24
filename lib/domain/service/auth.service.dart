import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/data/storage/hive_secure_storage.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/entities/request.entity.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/state/auth.state.dart';
import 'package:squirrel/domain/use_case/check_validity.use_case.dart';
import 'package:squirrel/domain/use_case/login.use_case.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

part 'auth.service.g.dart';

/// [AuthService]
@Riverpod(
  keepAlive: true,
  dependencies: [
    RequestService,
    LoginUseCase,
    CheckValidityUseCase,
  ],
)
class AuthService extends _$AuthService {
  /// License id key
  static const String _license = 'licenseKey';

  /// Navigator key
  late final GlobalKey<NavigatorState> _navigatorKey;

  /// Check validity use case
  late final CheckValidityUseCase _checkValidityUseCase;

  /// Secure storage service
  late final StorageInterface _secureStorageService;

  /// Request service
  late final RequestService _requestService;

  /// Is initialized
  bool _isInitialized = false;

  /// Timer
  Timer? _timer;

  /// Build
  ///
  @override
  Future<AuthState> build() async {
    if (!_isInitialized) {
      log('🔌 Initializing AuthService');
      _secureStorageService = injector.get<HiveSecureStorage>();
      _requestService = ref.watch(requestServiceProvider.notifier);
      _navigatorKey =
          injector.get<GlobalKey<NavigatorState>>(instanceName: 'root');
      _checkValidityUseCase = ref.watch(checkValidityUseCaseProvider.notifier);

      _isInitialized = true;
    }

    await loadLicense();
    await checkValidity();
    _periodicCheckValidity();

    return AuthState.initial();
  }

  /// Periodic check validity
  /// @return [void]
  ///
  void _periodicCheckValidity() {
    _timer = Timer.periodic(const Duration(hours: 5), (timer) async {
      try {
        log('Start periodic check validity');
        await checkValidity();
      } on Exception catch (e) {
        log('Error during periodic check validity: $e');
        if (state.value?.expirationDate != null &&
            state.value!.expirationDate!.isAfter(DateTime.now())) {
          log('License is not valid');
          _setUserAuthenticated(
            false,
            licenseId: null,
          );
          _timer?.cancel();
          _navigatorKey.currentContext?.goNamed('auth');
        }
      }
    });
  }

  /// Check if license is expired locally
  /// @return [bool] true if expired
  ///
  bool isLicenseExpiredLocally() {
    if (state.value?.expirationDate == null) {
      return true;
    }

    // Conversion en UTC pour éviter les problèmes de fuseau horaire
    final DateTime now = DateTime.now().toUtc();
    final DateTime expirationDate = state.value!.expirationDate!.toUtc();

    // On crée une date d'expiration qui inclut toute la journée (23:59:59)
    final DateTime endOfExpirationDay = DateTime.utc(
      expirationDate.year,
      expirationDate.month,
      expirationDate.day,
      23,
      59,
      59,
    );

    // Ajout de logs pour le débogage
    log('Date actuelle (UTC): $now');
    log('Date d\'expiration (UTC): $endOfExpirationDay');

    return now.isAfter(endOfExpirationDay);
  }

  /// Check validity of license
  /// @return [void]
  ///
  Future<void> checkValidity() async {
    log('Start check validity');

    // Vérification locale de l'expiration avant d'appeler le serveur
    if (isLicenseExpiredLocally()) {
      log('License is expired locally');
      _setUserAuthenticated(
        false,
        licenseId: null,
      );
      _navigatorKey.currentContext?.goNamed('auth');
      return;
    }

    final String? license = await _secureStorageService.get(_license);

    if (license == null) {
      log('License not found');
      _setUserAuthenticated(
        false,
        licenseId: null,
      );
      return;
    }

    try {
      final LoginResultLocalModel localLicense =
          LoginResultLocalModel.fromJson(jsonDecode(license));

      log('License found: ${localLicense.licenseKey}');
      log('Expiration date from storage: ${localLicense.expirationDate}');

      _requestService.addRequest(
        Request(
          name: 'Check license validity',
          description: 'Vérification de la validité de la licence',
          destination: 'Serveur de validation',
          parameters: {
            'licenseKey': localLicense.licenseKey,
          },
          date: DateTime.now(),
        ),
      );

      final CheckValidityEntity result =
          await _checkValidityUseCase.execute(localLicense.licenseKey);

      log('Check validity result: valid=${result.valid}, expiration=${result.expirationDate}');

      if (result.valid) {
        _setUserAuthenticated(
          true,
          licenseId: localLicense.licenseKey,
          expirationDate: result.expirationDate,
        );
      }
    } catch (e) {
      log('Error during check validity: $e');
      _setUserAuthenticated(
        false,
        licenseId: null,
      );
      return;
    }
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
    log('Set user $licenseId authenticate state to $isAuthenticated and expiration date to $expirationDate');

    // S'assurer que la date d'expiration est en UTC avant de la stocker
    final DateTime? localExpirationDate = expirationDate?.toUtc();

    if (localExpirationDate != null) {
      log('Date d\'expiration convertie en UTC: $localExpirationDate');
    }

    state = AsyncData(
      state.hasValue
          ? state.value!.copyWith(
              isUserAuthenticated: isAuthenticated,
              licenseId: licenseId,
              expirationDate: localExpirationDate,
            )
          : AuthState(
              isUserAuthenticated: false,
              licenseId: licenseId,
              expirationDate: expirationDate,
            ),
    );
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
        await ref.read(loginUseCaseProvider.notifier).execute(licenseKey);

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

  /// Load license
  /// @return [void]
  ///
  Future<(bool, String, DateTime?)?> loadLicense() async {
    final String? license = await _secureStorageService.get(_license);

    if (license != null) {
      try {
        final LoginResultLocalModel localLicense =
            LoginResultLocalModel.fromJson(jsonDecode(license));

        log('Chargement de la licence: ${localLicense.licenseKey}');
        log('Date d\'expiration chargée: ${localLicense.expirationDate}');

        if (_isInitialized) {
          _setUserAuthenticated(
            true,
            licenseId: localLicense.licenseKey,
            expirationDate: localLicense.expirationDate,
          );
          return null;
        } else {
          return (
            true,
            localLicense.licenseKey,
            localLicense.expirationDate,
          );
        }
      } catch (e) {
        log('Erreur lors du chargement de la licence: $e');
        // En cas d'erreur, on considère qu'il n'y a pas de licence valide
        if (_isInitialized) {
          _setUserAuthenticated(false);
        } else {
          return null;
        }
      }
    }

    return null;
  }
}
