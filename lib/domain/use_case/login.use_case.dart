import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/authentication.repository.impl.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/authentication.repository.dart';
import 'package:squirrel/domain/use_case/future.usecases.dart';
import 'package:squirrel/domain/use_case/results.usecases.dart';

part 'login.use_case.g.dart';

/// Login Params
class LoginUseCaseParams {
  /// Constructor
  /// @param [licenseKey] license key
  ///
  LoginUseCaseParams({required this.licenseKey});

  /// License Key
  final String licenseKey;
}

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

/// Login Use Case Provider 
/// @param [ref] ref
/// @param [params] params
/// @return [ResultState<Future<LoginResult>>] result
///
@Riverpod(
  dependencies: <Object>[
    AuthenticationRepositoryImpl,
  ],
)
Future<ResultState<Future<LoginResult>>> loginUseCase(
  Ref ref,
  LoginUseCaseParams params,
) {
  final AuthenticationRepository repository = ref.watch(
    authenticationRepositoryImplProvider.notifier,
  );
  return LoginUseCase(repository: repository).execute(params);
}
