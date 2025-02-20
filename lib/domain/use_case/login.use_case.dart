import 'package:init/data/repository/auth/authentication.repository.dart';
import 'package:init/domain/entities/login_result.entity.dart';
import 'package:init/domain/use_case/abstraction/use_case_abs.dart';

/// [LoginUseCase]
class LoginUseCase implements UseCaseWithParams<Future<LoginResultEntity>, String> {
  /// Authentication repository
  final AuthenticationRepository _authenticationRepository;

  /// Constructor
  /// @param [_authenticationRepository] authentication repository
  ///
  LoginUseCase(this._authenticationRepository);

  /// Login
  /// @param [licenseKey] license key
  /// @return [LoginResultEntity] login result entity
  ///
  @override
  Future<LoginResultEntity> execute(String licenseKey) async {
    return await _authenticationRepository.login(licenseKey);
  }
}
