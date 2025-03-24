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

  /// Timer
  Timer? _timer;

  /// Build
  ///
  @override
  Future<AuthState> build() async {
    _initDependencies();
    
    // Définir un état initial "en cours de chargement" avec isInitialized = false
    state = AsyncData(AuthState.initial(isInitialized: false));
    
    // Charger l'utilisateur de manière asynchrone
    await loadUser();
    
    return state.value ?? AuthState.initial(isInitialized: true);
  }

  Future<AuthState?> loadUser() async {
    try {
      final licenseResult = await loadLicense();
      
      if (licenseResult != null) {
        final (isValid, licenseKey, expirationDate) = licenseResult;
        
        if (isValid) {
          _setUserAuthenticated(
            true,
            licenseId: licenseKey,
            expirationDate: expirationDate,
          );
        } else {
          _setUserAuthenticated(false);
        }
      } else {
        // Si pas de licence trouvée, définir explicitement non authentifié
        _setUserAuthenticated(false);
      }
      
      // Vérifier la validité après avoir chargé la licence
      await checkValidity();
      
      // Démarrer la vérification périodique
      _periodicCheckValidity();
      
      return state.value;
    } catch (e) {
      log('Erreur lors du chargement de l\'utilisateur: $e');
      _setUserAuthenticated(false);
      return state.value;
    }
  }

  /// Initialize dependencies
  /// @return [void]
  ///
  void _initDependencies() {
    log('🔌 Initializing AuthService');
    _secureStorageService = injector.get<HiveSecureStorage>();
    _requestService = ref.watch(requestServiceProvider.notifier);
    _navigatorKey = injector.get<GlobalKey<NavigatorState>>();
    _checkValidityUseCase = ref.watch(checkValidityUseCaseProvider.notifier);
  }

  /// Periodic check validity
  /// @return [void]
  ///
  void _periodicCheckValidity() {
    _timer = Timer.periodic(const Duration(hours: 5), (timer) async {
      try {
        log('Start periodic check validity');
        
        // Capturer le contexte et vérifier avant les opérations asynchrones
        bool isAlreadyOnAuthScreen = false;
        final BuildContext? currentContext = _navigatorKey.currentContext;
        if (currentContext != null) {
          final String currentRoute = GoRouterState.of(currentContext).matchedLocation;
          isAlreadyOnAuthScreen = currentRoute == '/auth';
        }
        
        // Si déjà sur l'écran d'auth, ne pas vérifier à nouveau la validité
        if (isAlreadyOnAuthScreen) {
          return;
        }
        
        await checkValidity();
      } on Exception catch (e) {
        log('Error during periodic check validity: $e');
        
        // Vérifier si la licence est encore valide malgré l'erreur
        if (state.value?.expirationDate != null &&
            state.value!.expirationDate!.isBefore(DateTime.now())) {
          log('License is expired during periodic check');
          _setUserAuthenticated(
            false,
            licenseId: null,
          );
          _timer?.cancel();
          
          // Éviter d'utiliser le contexte après une opération asynchrone
          // Capture un nouveau contexte au moment de la navigation
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final BuildContext? contextAfterAsync = _navigatorKey.currentContext;
            if (contextAfterAsync != null) {
              final String currentRoute = GoRouterState.of(contextAfterAsync).matchedLocation;
              if (currentRoute != '/auth') {
                contextAfterAsync.goNamed('auth');
              }
            }
          });
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

  /// Check validity
  /// @return [void]
  ///
  Future<void> checkValidity() async {
    final String? license = await _secureStorageService.get(_license);

    if (license == null) {
      log('Aucune licence trouvée lors de la vérification de validité');
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

      try {
        final CheckValidityEntity result =
            await _checkValidityUseCase.execute(localLicense.licenseKey);

        log('Check validity result: valid=${result.valid}, expiration=${result.expirationDate}');

        if (result.valid) {
          _setUserAuthenticated(
            true,
            licenseId: localLicense.licenseKey,
            expirationDate: result.expirationDate,
          );
        } else {
          // Si la licence n'est plus valide, déconnecter l'utilisateur
          _setUserAuthenticated(
            false,
            licenseId: null,
          );
          
          // Rediriger vers l'écran d'authentification si nécessaire
          // Utilise WidgetsBinding pour gérer le contexte de manière sûre
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final BuildContext? contextAfterAsync = _navigatorKey.currentContext;
            if (contextAfterAsync != null) {
              contextAfterAsync.goNamed('auth');
            }
          });
        }
      } catch (e) {
        log('Erreur lors de la vérification de la validité: $e');
        // En cas d'erreur de vérification, conserver l'état d'authentification actuel
        // Ne pas déconnecter l'utilisateur immédiatement
        // Sauf si la date d'expiration locale est dépassée
        if (localLicense.expirationDate != null &&
            localLicense.expirationDate!.isBefore(DateTime.now())) {
          _setUserAuthenticated(
            false,
            licenseId: null,
          );
          
          // Utilise WidgetsBinding pour gérer le contexte de manière sûre
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final BuildContext? contextAfterAsync = _navigatorKey.currentContext;
            if (contextAfterAsync != null) {
              contextAfterAsync.goNamed('auth');
            }
          });
        }
      }
    } catch (e) {
      log('Erreur lors du décodage de la licence: $e');
      // Ne pas déconnecter si simplement on n'arrive pas à décoder
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

        if (state.value?.isInitialized == true) {
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
        if (state.value?.isInitialized == true) {
          _setUserAuthenticated(false);
        } else {
          return null;
        }
      }
    }

    return null;
  }
}
