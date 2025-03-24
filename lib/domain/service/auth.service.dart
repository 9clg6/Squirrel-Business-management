import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/entities/request.entity.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
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
    HiveSecureStorageService,
  ],
)
class AuthService extends _$AuthService {
  static const String _license = 'licenseKey';
  late final GlobalKey<NavigatorState> _navigatorKey;
  late final CheckValidityUseCase _checkValidityUseCase;
  late final StorageInterface _secureStorageService;
  late final RequestService _requestService;
  Timer? _timer;
  bool _isInitialized = false;
  LoginResultLocalModel? _cachedLicense;
  DateTime? _lastValidityCheck;

  /// Build
  ///
  @override
  Future<AuthState> build() async {
    if (!_isInitialized) {
      await _initializeServices();
    }
    return state.value ?? AuthState.initial(isInitialized: true);
  }

  Future<void> _initializeServices() async {
    log('🔌 Initializing AuthService');
    await _initDependencies();
    _isInitialized = true;
    await loadUser();
  }

  /// Initialize dependencies
  /// @return [Future<void>]
  ///
  Future<void> _initDependencies() async {
    // Initialiser les services
    _secureStorageService = ref.read(hiveSecureStorageServiceProvider.notifier);
    _requestService = ref.read(requestServiceProvider.notifier);
    _navigatorKey = injector.get<GlobalKey<NavigatorState>>();
    _checkValidityUseCase = ref.read(checkValidityUseCaseProvider.notifier);
    
    // Attendre l'initialisation du storage service qui est critique
    await ref.read(hiveSecureStorageServiceProvider.future);
  }

  /// Load user
  /// @return [Future<AuthState?>] auth state
  ///
  Future<AuthState?> loadUser() async {
    try {
      final licenseResult = await _loadLicenseFromStorage();
      
      if (licenseResult != null) {
        await _handleLicenseResult(licenseResult);
      } else {
        _setUserAuthenticated(false);
      }
      
      return state.value;
    } catch (e) {
      log('Erreur lors du chargement de l\'utilisateur: $e');
      _setUserAuthenticated(false);
      return state.value;
    }
  }

  Future<LoginResultLocalModel?> _loadLicenseFromStorage() async {
    if (_cachedLicense != null) {
      return _cachedLicense;
    }

    final String? license = await _secureStorageService.get(_license);
    if (license == null) return null;

    try {
      _cachedLicense = LoginResultLocalModel.fromJson(jsonDecode(license));
      return _cachedLicense;
    } catch (e) {
      log('Erreur lors du décodage de la licence: $e');
      return null;
    }
  }

  Future<void> _handleLicenseResult(LoginResultLocalModel license) async {
    log('Chargement de la licence: ${license.licenseKey}');
    
    final shouldCheckValidity = _lastValidityCheck == null || 
        DateTime.now().difference(_lastValidityCheck!) > const Duration(hours: 1);

    if (shouldCheckValidity) {
      await _checkValidity(license.licenseKey);
      _lastValidityCheck = DateTime.now();
    } else {
      _setUserAuthenticated(
        true,
        licenseId: license.licenseKey,
        expirationDate: license.expirationDate,
      );
    }
  }

  /// Check validity
  /// @return [void]
  ///
  Future<void> _checkValidity(String licenseKey) async {
    try {
      final result = await _checkValidityUseCase.execute(licenseKey);
      
      if (result.valid) {
        _setUserAuthenticated(
          true,
          licenseId: licenseKey,
          expirationDate: result.expirationDate,
        );
        _startPeriodicCheck();
      } else {
        _setUserAuthenticated(false);
        _navigateToAuth();
      }
    } catch (e) {
      log('Erreur lors de la vérification de validité: $e');
      // Conserver l'état actuel en cas d'erreur de connexion
    }
  }

  void _startPeriodicCheck() {
    if (_timer?.isActive ?? false) return;
    
    _timer = Timer.periodic(const Duration(hours: 5), (timer) async {
      final currentLicense = await _loadLicenseFromStorage();
      if (currentLicense != null) {
        await _checkValidity(currentLicense.licenseKey);
      }
    });
  }

  void _navigateToAuth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _navigatorKey.currentContext;
      if (context != null && GoRouterState.of(context).matchedLocation != '/auth') {
        context.goNamed('auth');
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
              isInitialized: true,
            )
          : AuthState.initial(
              isUserAuthenticated: isAuthenticated,
              licenseId: licenseId,
              expirationDate: localExpirationDate,
              isInitialized: true,
            ),
    );
  }

  /// Login
  /// @param [licenseKey] license key
  /// @return [Future<bool>] login result
  ///
  Future<bool> login(String licenseKey) async {
    log('Start login');

    if (!_isInitialized) {
      await _initializeServices();
    }

    try {
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
          _startPeriodicCheck();
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
    } catch (e) {
      log('Erreur lors de la connexion: $e');
      return false;
    }
  }
}
