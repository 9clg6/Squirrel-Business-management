import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/authentication.repository.dart';
import 'package:squirrel/domain/use_case/future.usecases.dart';
import 'package:squirrel/domain/use_case/params/login.use_case.params.dart';

/// Login Use Case Implementation
class LoginUseCase
    extends FutureUseCaseWithParams<Future<LoginResult>, LoginUseCaseParams> {
  // Constructor
  /// @param [repository] repository
  ///
  LoginUseCase({
    required AuthenticationRepository repository,
  }) : _repository = repository;

  /// Repository
  final AuthenticationRepository _repository;

  /// Execute Login Use Case
  /// @param [params] params
  /// @return [Future<LoginResult>] result
  ///
  @override
  Future<Future<LoginResult>> invoke(LoginUseCaseParams params) async {
    return _repository.login(params.licenseKey);
  }
}
