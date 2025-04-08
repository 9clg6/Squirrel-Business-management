import 'dart:async';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/entities/request.entity.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/state/auth.state.dart';
import 'package:squirrel/domain/use_case/check_validity.use_case.dart';
import 'package:squirrel/domain/use_case/get_app_lock_state.use_case.dart';
import 'package:squirrel/domain/use_case/get_fail_count.use_case.dart';
import 'package:squirrel/domain/use_case/get_license.use_case.dart';
import 'package:squirrel/domain/use_case/login.use_case.dart';
import 'package:squirrel/domain/use_case/results.usecases.dart';
import 'package:squirrel/domain/use_case/save_license.use_case.dart';
import 'package:squirrel/domain/use_case/set_app_lock_state.use_case.dart';
import 'package:squirrel/domain/use_case/set_fail_count.use_case.dart';
import 'package:squirrel/domain/use_case/set_last_check_success.use_case.dart';
import 'package:squirrel/domain/use_case/set_last_known_time.use_case.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';

part 'auth.service.g.dart';

/// [AuthService]
@Riverpod(
  keepAlive: true,
  dependencies: <Object>[
    RequestService,
    DialogService,
    NavigatorService,
    HiveSecureStorageService,
    getFailCountUseCase,
  ],
)
class AuthService extends _$AuthService {
  static const int _maxFailedChecks = 3;

  RequestService? _requestService;
  Timer? _timer;
  int _failedChecksCount = 0;
  DateTime? _lastKnownTime;
  bool _isAppLocked = false;

  /// Build
  ///
  @override
  Future<AuthState> build() async {
    if (!state.hasValue || state.value == null) {
      state = AsyncData<AuthState>(AuthState.initial(isInitialized: false));
    }

    await _initializeServices();

    return state.value ?? AuthState.initial(isInitialized: true);
  }

  /// Initialize services
  /// @return [Future<void>]
  ///
  Future<void> _initializeServices() async {
    log('🔌 Initializing AuthService');

    if (!state.hasValue || state.value == null) {
      state = AsyncData<AuthState>(
        AuthState.initial(isInitialized: false),
      );
    }

    await _initDependencies();
    await _loadFailedChecksCount();
    await _loadAppLockedState();

    await loadUser();

    state = AsyncData<AuthState>(
      state.value!.copyWith(isInitialized: true),
    );

    _startPeriodicCheck();

    log('🔌✅ AuthService fully initialized with auth state');
  }

  /// Initialize dependencies
  /// @return [Future<void>]
  ///
  Future<void> _initDependencies() async {
    _requestService ??= ref.read(requestServiceProvider.notifier);
    log('🔌✅ AuthService initialized');
  }

  /// Load user from local storage
  /// @return [Future<AuthState?>] auth state
  ///
  Future<void> loadUser() async {
    log('🔐 Loading user');
    try {
      if (_isAppLocked) {
        if (state.value == null) {
          state = AsyncData<AuthState>(AuthState.initial(isAppLocked: true));
        } else {
          state = AsyncData<AuthState>(
            state.value!.copyWith(isAppLocked: true),
          );
        }

        ref.read(dialogServiceProvider.notifier).showError(
              LocaleKeys.appLocked.tr(),
            );
        return;
      }

      final LoginResult? licenseResult =
          await ref.read(getLicenseUseCaseProvider.future);

      log('🔐 License found: ${licenseResult?.licenseKey}');

      if (licenseResult != null) {
        if (_failedChecksCount >= _maxFailedChecks) {
          log('🔐❌ License found but failed checks count is too high, locking');
          await _lockApp();
          return;
        }

        if (await _detectTimeTampering()) {
          await _lockApp(LocaleKeys.systemDateModified.tr());
          log('🔐❌ System date modified, locking');
          return;
        }
        _setUserAuthenticated(
          true,
          licenseId: licenseResult.licenseKey,
          expirationDate: licenseResult.expirationDate,
        );
      } else {
        _setUserAuthenticated(false);
        ref.read(navigatorServiceProvider.notifier).navigateToAuth();
      }
    } on Exception catch (e) {
      log('🔐❌ Error when loading user: $e');
      _setUserAuthenticated(false);
    }
  }

  /// Check validity
  /// @return [Future<bool>] true if validity is checked
  ///
  Future<bool> _checkValidity() async {
    log('🔐 Checking validity');
    final LoginResult? licenseResult =
        await ref.read(getLicenseUseCaseProvider.future);

    if (licenseResult == null) return false;

    final bool hasReachedMaxFailedChecks =
        _failedChecksCount >= _maxFailedChecks;

    if (hasReachedMaxFailedChecks) {
      log('🔐❌ Failed checks count reached max, locking');
      await _lockApp();
      return false;
    }

    final ResultState<Future<CheckValidityEntity>> checkValidityResult =
        await ref.read(
      checkValidityUseCaseProvider(
        CheckValidityUseCaseParams(licenseKey: licenseResult.licenseKey),
      ).future,
    );

    checkValidityResult.when(
      success: (Future<CheckValidityEntity> data) async {
        final CheckValidityEntity r = await data;

        log('🔐✅ License valid, reset security');
        _failedChecksCount = 0;
        await ref.read(
          setFailCountUseCaseProvider(
            count: 0,
          ).future,
        );
        _isAppLocked = false;

        await ref.read(
          setLastCheckSuccessUseCaseProvider(
            date: DateTime.now().toIso8601String(),
          ).future,
        );

        _lastKnownTime = DateTime.now();
        await ref.read(
          setLastKnownTimeUseCaseProvider(
            date: _lastKnownTime!,
          ).future,
        );

        _isAppLocked = false;
        await ref.read(
          setAppLockStateUseCaseProvider(
            isLocked: false,
          ).future,
        );

        _setUserAuthenticated(
          true,
          licenseId: licenseResult.licenseKey,
          expirationDate: r.expirationDate,
        );

        return true;
      },
      failure: _handleFailedCheck,
      otherwise: () {
        return false;
      },
    );

    return false;
  }

  /// Handle failed check
  /// @return [Future<bool>]
  ///
  Future<bool> _handleFailedCheck(Exception e) async {
    log('🔐❌ License invalid, handle failed check');
    _setUserAuthenticated(
      false,
      isAppLocked: false,
    );
    _failedChecksCount++;

    await ref.read(
      setFailCountUseCaseProvider(
        count: _failedChecksCount,
      ).future,
    );

    if (_failedChecksCount >= _maxFailedChecks) {
      await _lockApp();
    }

    return false;
  }

  /// Lock app
  /// @param [message] message
  /// @return [Future<void>]
  ///
  Future<void> _lockApp([
    String message = LocaleKeys.licenseValidationFailedTooManyTimes,
  ]) async {
    log('🔐 Locking app');
    _isAppLocked = true;
    await ref.read(
      setAppLockStateUseCaseProvider(
        isLocked: true,
      ).future,
    );

    if (state.value == null) {
      state = AsyncData<AuthState>(
        AuthState.initial(isAppLocked: true),
      );
    } else {
      state = AsyncData<AuthState>(
        state.value!.copyWith(
          isAppLocked: true,
        ),
      );
    }

    log('🔐✅ App locked');

    ref.read(dialogServiceProvider.notifier).showError(message.tr());
  }

  /// Load failed checks count
  /// @return [Future<void>]
  ///
  Future<void> _loadFailedChecksCount() async {
    log('🔌 Loading "failed checks" count');
    final int? count = await ref.read(getFailCountUseCaseProvider.future);
    log('🔌✅ Failed checks count loaded: $count');
    _failedChecksCount = count ?? 0;
  }

  /// Load app locked state
  /// @return [Future<void>]
  ///
  Future<void> _loadAppLockedState() async {
    log('🔌 Loading app locked state');
    final bool? locked = await ref.read(getAppLockStateUseCaseProvider.future);
    log('🔌✅ App locked state loaded: $locked');
    _isAppLocked = locked ?? false;
  }

  /// Detect time tampering
  /// @return [bool] true if time tampering is detected
  ///
  Future<bool> _detectTimeTampering() async {
    if (_lastKnownTime == null) {
      _lastKnownTime = DateTime.now();
      await ref.read(
        setLastKnownTimeUseCaseProvider(
          date: _lastKnownTime!,
        ).future,
      );
      return false;
    }

    final DateTime now = DateTime.now();

    if (now.isBefore(_lastKnownTime!)) {
      return true;
    }

    _lastKnownTime = now;
    await ref.read(
      setLastKnownTimeUseCaseProvider(
        date: _lastKnownTime!,
      ).future,
    );

    return false;
  }

  /// Start periodic check
  /// @return [void]
  ///
  void _startPeriodicCheck() {
    if (_timer?.isActive ?? false) return;
    log('♻️ Starting periodic check');

    _timer = Timer.periodic(
      const Duration(hours: 1),
      (Timer timer) async {
        await _checkValidity();
      },
    );
  }

  /// Check if license is expired locally
  /// @return [bool] true if expired
  ///
  bool isLicenseExpiredLocally() {
    if (state.value?.expirationDate == null) {
      log('🔐❌ License expired locally: no expiration date');
      return true;
    }

    final DateTime now = DateTime.now().toUtc();
    final DateTime expirationDate = state.value!.expirationDate!.toUtc();

    final DateTime endOfExpirationDay = DateTime.utc(
      expirationDate.year,
      expirationDate.month,
      expirationDate.day,
      23,
      59,
      59,
    );

    final bool test = now.isAfter(endOfExpirationDay);

    log('🔐 Is license expired locally: $test');
    return test;
  }

  /// Set user authenticated
  /// @param [isAuthenticated] is user authenticated
  /// @param [licenseId] license id
  /// @param [expirationDate] expiration date
  /// @param [isAppLocked] override app locked state
  ///
  void _setUserAuthenticated(
    bool isAuthenticated, {
    String? licenseId,
    DateTime? expirationDate,
    bool? isAppLocked,
  }) {
    final bool appLocked = isAppLocked ?? _isAppLocked;

    final DateTime? localExpirationDate = expirationDate?.toUtc();

    log('🔐✅ Setting $licenseId authenticated: $isAuthenticated with'
        ' expiration date: $localExpirationDate');

    state = AsyncData<AuthState>(
      state.hasValue
          ? state.value!.copyWith(
              isUserAuthenticated: isAuthenticated,
              licenseId: licenseId,
              expirationDate: localExpirationDate,
              isInitialized: true,
              isAppLocked: appLocked,
            )
          : AuthState.initial(
              isUserAuthenticated: isAuthenticated,
              licenseId: licenseId,
              expirationDate: localExpirationDate,
              isInitialized: true,
              isAppLocked: appLocked,
            ),
    );
  }

  /// Login
  /// @param [licenseKey] license key
  /// @return [Future<bool>] login result
  ///
  Future<bool> login(String licenseKey) async {
    log('🔐 Start login');

    if ((state.value?.isInitialized ?? false) == false) {
      await _initializeServices();
    }

    if (_isAppLocked) {
      return _checkValidity();
    }

    _requestService?.addRequest(
      Request(
        name: 'Login',
        description: "Connexion à l'application",
        destination: 'Serveur de connexion',
        parameters: <String, String>{
          'licenseKey': licenseKey,
        },
        date: DateTime.now(),
      ),
    );

    final ResultState<Future<LoginResult>> loginResult = await ref.read(
      loginUseCaseProvider(
        LoginUseCaseParams(licenseKey: licenseKey),
      ).future,
    );

    return loginResult.when<Future<bool>>(
      success: _handleSucessLogin,
      failure: (Exception e) {
        log('🔐❌ Error when logging in: $e');
        return Future<bool>.value(false);
      },
      otherwise: () {
        return Future<bool>.value(false);
      },
    );
  }

  /// Check if the app is currently locked
  /// @return [bool] true if the app is locked
  ///
  bool isAppLocked() {
    return _isAppLocked || (state.value?.isAppLocked ?? false);
  }

  Future<bool> _handleSucessLogin(Future<LoginResult> data) async {
    log('🔐✅ Login successful');
    final LoginResult loginResult = await data;

    await ref.read(saveLicenseUseCaseProvider(license: loginResult).future);

    _setUserAuthenticated(
      true,
      licenseId: loginResult.licenseKey,
      expirationDate: loginResult.expirationDate,
    );

    if (_timer == null || !_timer!.isActive) {
      _startPeriodicCheck();
    }

    return true;
  }
}
