import 'package:squirrel/data/repository/auth/authentication.repository.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/use_case/abstraction/use_case_abs.dart';

class CheckValidityUseCase implements UseCaseWithParams<Future<CheckValidityEntity>, String> {
  /// Authentication repository
  final AuthenticationRepository _authenticationRepository;

  /// Constructor
  CheckValidityUseCase(this._authenticationRepository);

  /// Execute use case
  /// @param [params] params
  /// @return [CheckValidityEntity] check validity entity
  ///
  @override
  Future<CheckValidityEntity> execute(String params) async {
    return await _authenticationRepository.checkValidity(params);
  }

}