import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/user.repository.impl.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

part 'save_license.use_case.g.dart';

/// Use case to save the license information
class SaveLicenseUseCase
    implements BaseUseCaseWithParams<Future<void>, LoginResult> {
  /// Constructor
  /// @param [repository] User Repository
  ///
  SaveLicenseUseCase({
    required UserRepository repository,
  }) : _repository = repository;

  final UserRepository _repository;

  /// Execute the use case
  /// @param [license] license
  /// @return [Future<void>] void
  ///
  @override
  Future<void> execute(LoginResult license) async {
    return _repository.saveLicense(license);
  }
}

/// Provider for SaveLicenseUseCase
/// @param [ref] ref
/// @param [license] license
/// @return [Future<void>] void
///
@Riverpod(
  dependencies: <Object>[
    UserRepositoryImpl,
  ],
)
Future<void> saveLicenseUseCase(
  Ref ref, {
  required LoginResult license,
}) async {
  final UserRepository repository = await ref.watch(
    userRepositoryImplProvider.future,
  );
  return SaveLicenseUseCase(repository: repository).execute(license);
}
