import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/authentication.repository.dart';
import 'package:squirrel/domain/use_case/login.use_case.dart';
import 'package:squirrel/domain/use_case/params/login.use_case.params.dart';
import 'package:squirrel/domain/use_case/results.usecases.dart';
import 'package:squirrel/foundation/providers/repositories/authentication.repository.provider.dart';

part 'login.use_case.provider.g.dart';

/// Login Use Case Provider 
/// @param [ref] ref
/// @param [params] params
/// @return [ResultState<Future<LoginResult>>] result
///
@riverpod
Future<ResultState<Future<LoginResult>>> loginUseCase(
  Ref ref,
  LoginUseCaseParams params,
) {
  final AuthenticationRepository repository = ref.watch(
    authenticationRepositoryImplProvider,
  );
  return LoginUseCase(repository: repository).execute(params);
}
