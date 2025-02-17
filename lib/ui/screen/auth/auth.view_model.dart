import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/service/auth.service.dart';
import 'package:init/domain/service/dialog.service.dart';
import 'package:init/domain/service/navigator.service.dart';
import 'package:init/ui/screen/auth/auth.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  @override
  AuthState build() => AuthState.initial();

  Future<void> login(String licenseKey) async {
    final bool result = await _authService.login(licenseKey);

    if (result) {
      final result = await _dialogService.showUseConditions();
      if (result == true) {
        _authService.setUserAuthenticated(true);
        _navigatorService.navigateToHome();
      }
    } else {
      _dialogService.showError('Impossible de se connecter');
    }
  }
}
