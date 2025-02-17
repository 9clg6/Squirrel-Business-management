import 'package:init/data/repository/auth/authentication.repository.dart';

class LoginUseCase {
  final AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  Future<bool> login(String licenseKey) async {
    return await _authenticationRepository.login(licenseKey);
  }
}
