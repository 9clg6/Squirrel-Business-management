import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/repositories/authentication.repository.dart';
import 'package:squirrel/domain/use_case/check_validity.use_case.dart';
import 'package:squirrel/domain/use_case/params/check_validity.use_case.params.dart';
import 'package:squirrel/domain/use_case/results.usecases.dart';
import 'package:squirrel/foundation/providers/repositories/authentication.repository.provider.dart';

part 'check_validity.use_case.provider.g.dart';

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
