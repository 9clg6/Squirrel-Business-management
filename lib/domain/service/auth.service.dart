class AuthService {
  bool _isUserAuthenticated = false;

  AuthService();

  bool get isUserAuthenticated => _isUserAuthenticated;

  void setUserAuthenticated(bool isAuthenticated) {
    _isUserAuthenticated = isAuthenticated;
  }

  login(String licenseKey) {}
}
