import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/authentification/authentication.repository.provider.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/repositories/authentication.repository.dart';
import 'package:squirrel/domain/use_case/future.usecases.dart';
import 'package:squirrel/domain/use_case/params/check_validity.use_case.params.dart';
import 'package:squirrel/domain/use_case/results.usecases.dart';

part 'check_validity.use_case.g.dart';

/// [CheckValidityUseCase]
class CheckValidityUseCase extends FutureUseCaseWithParams<
    Future<CheckValidityEntity>, CheckValidityUseCaseParams> {
  /// Constructeur
  /// @param [repository] repository
  ///
  CheckValidityUseCase({
    required AuthenticationRepository repository,
  }) : _repository = repository;

  /// Repository
  final AuthenticationRepository _repository;

  /// Execute Check Validity Use Case
  /// @param [params] params
  /// @return [Future<CheckValidityEntity>] result
  ///
  @override
  Future<Future<CheckValidityEntity>> invoke(
    CheckValidityUseCaseParams params,
  ) async {
    return _repository.checkValidity(params.licenseKey);
  }
}

/// Check Validity Use Case Provider
/// @param [ref] ref
/// @param [params] params
/// @return [ResultState<Future<CheckValidityEntity>>] result
///
@riverpod
Future<ResultState<Future<CheckValidityEntity>>> checkValidityUseCase(
  Ref ref,
  CheckValidityUseCaseParams params,
) {
  final AuthenticationRepository repository = ref.watch(
    authenticationRepositoryImplProvider,
  );

  return CheckValidityUseCase(repository: repository).execute(params);
}
