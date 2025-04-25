import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/logger.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/providers/service/dialog.service.provider.dart';
import 'package:squirrel/ui/screen/auth/auth.view_state.dart';

part 'auth.view_model.g.dart';

/// [Auth]
@Riverpod(
  keepAlive: true,
  dependencies: <Object>[
    AuthService,
  ],
)
class Auth extends _$Auth {
  late final DialogService _dialogService;
  late final NavigatorService _navigatorService;
  late final AuthService _authService;

  bool _isInitialized = false;

  /// Build
  ///
  @override
  AuthScreenState build() {
    if (!_isInitialized) {
      LoggerService.instance.i('[AuthViewModel] 🔌 Initializing');
      _dialogService = ref.watch(dialogServiceProvider);
      _navigatorService = ref.watch(navigatorServiceProvider.notifier);
      _authService = ref.watch(authServiceProvider.notifier);
      _isInitialized = true;
    }

    return AuthScreenState.initial();
  }

  /// Login
  /// @param [licenseKey] license key
  ///
  Future<void> login(String licenseKey) async {
    state = state.copyWith(loading: true);
    final bool result = await _authService.login(licenseKey);

    if (result) {
      final bool? useConditionsResult =
          await _dialogService.showUseConditions();
      if (useConditionsResult ?? false) {
        unawaited(_navigatorService.navigateToHome());
      } else if (useConditionsResult == null) {
        LoggerService.instance.e(
          "[AuthViewModel] 🔐❌ Impossible d'afficher les conditions d'utilisation: contexte null",
        );
        _dialogService.showError(LocaleKeys.impossibleToConnect.tr());
      }
    } else {
      LoggerService.instance.e(
        '[AuthViewModel] 🔐❌ Impossible de se connecter: $licenseKey',
      );
      _dialogService.showError(LocaleKeys.impossibleToConnect.tr());
    }
    state = state.copyWith(loading: false);
  }
}
