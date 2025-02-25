import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/screen/auth/auth.view_state.dart';

part 'auth.view_model.g.dart';

/// [Auth]
///
@riverpod
class Auth extends _$Auth {
  late final DialogService _dialogService;
  late final NavigatorService _navigatorService;
  late final AuthService _authService;

  /// Constructor
  ///
  Auth() {
    _dialogService = injector<DialogService>();
    _navigatorService = injector<NavigatorService>();
    _authService = injector<AuthService>();
  }

  /// Build
  /// @return [AuthState]
  ///
  @override
  AuthState build() => AuthState.initial();

  /// Login
  /// @param [licenseKey] license key
  /// 
  Future<void> login(String licenseKey) async {
    final bool result = await _authService.login(licenseKey);

    if (result) {
      final result = await _dialogService.showUseConditions();
      if (result == true) {
        _navigatorService.navigateToHome();
      }
    } else {
      _dialogService.showError(LocaleKeys.impossibleToConnect.tr());
    }
  }
}
