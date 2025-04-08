import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/authentication.repository.impl.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/repositories/authentication.repository.dart';
import 'package:squirrel/domain/use_case/future.usecases.dart';
import 'package:squirrel/domain/use_case/results.usecases.dart';

part 'check_validity.use_case.g.dart';

/// Check Validity Params
class CheckValidityUseCaseParams {
  /// Constructor
  /// @param [licenseKey] license key
  ///
  CheckValidityUseCaseParams({required this.licenseKey});

  /// License Key
  final String licenseKey;
}

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
@Riverpod(
  dependencies: <Object>[
    AuthenticationRepositoryImpl,
  ],
)
Future<ResultState<Future<CheckValidityEntity>>> checkValidityUseCase(
  Ref ref,
  CheckValidityUseCaseParams params,
) {
  final AuthenticationRepository repository = ref.watch(
    authenticationRepositoryImplProvider.notifier,
  );
  return CheckValidityUseCase(repository: repository).execute(params);
}
