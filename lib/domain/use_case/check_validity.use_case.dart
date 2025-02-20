import 'package:init/data/repository/auth/authentication.repository.dart';
import 'package:init/domain/use_case/abstraction/use_case_abs.dart';

class CheckValidityUseCase implements UseCaseWithParams<Future<bool>, String> {
  /// Authentication repository
  final AuthenticationRepository _authenticationRepository;

  /// Constructor
  CheckValidityUseCase(this._authenticationRepository);

  /// Execute use case
  /// @param [params] params
  /// @return [bool] validity
  ///
  @override
  Future<bool> execute(String params) async {
    return await _authenticationRepository.checkValidity(params);
  }

}