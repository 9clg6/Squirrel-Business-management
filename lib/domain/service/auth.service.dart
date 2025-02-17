import 'package:init/domain/use_case/login.use_case.dart';

class AuthService {
  final LoginUseCase _loginUseCase;

  bool _isUserAuthenticated = false;

  AuthService(this._loginUseCase);

  bool get isUserAuthenticated => _isUserAuthenticated;

  void setUserAuthenticated(bool isAuthenticated) {
    _isUserAuthenticated = isAuthenticated;
  }

  Future<bool> login(String licenseKey) async {
    return await _loginUseCase.login(licenseKey);
  }
}
