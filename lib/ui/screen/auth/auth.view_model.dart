import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/screen/auth/auth.view_state.dart';

part 'auth.view_model.g.dart';

/// [Auth]
@Riverpod(
  keepAlive: true,
  dependencies: [
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
      log('🔌 Initializing AuthViewModel');
      _dialogService = injector<DialogService>();
      _navigatorService = injector<NavigatorService>();
      _authService = ref.watch(authServiceProvider.notifier);
      _isInitialized = true;
    }

    return AuthScreenState.initial(l: false);
  }

  /// Login
  /// @param [licenseKey] license key
  ///
  Future<void> login(String licenseKey) async {
    state = state.copyWith(loading: true);
    final bool result = await _authService.login(licenseKey);

    if (result) {
      final useConditionsResult = await _dialogService.showUseConditions();
      if (useConditionsResult == true) {
        _navigatorService.navigateToHome();
      } else if (useConditionsResult == null) {
        log('Impossible d\'afficher les conditions d\'utilisation: contexte null');
        _dialogService.showError(LocaleKeys.impossibleToConnect.tr());
      }
    } else {
      _dialogService.showError(LocaleKeys.impossibleToConnect.tr());
    }
    state = state.copyWith(loading: false);
  }
}
