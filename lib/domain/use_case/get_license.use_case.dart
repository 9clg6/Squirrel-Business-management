import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/user/user.repository.provider.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

part 'get_license.use_case.g.dart';

/// Use case to get the license information
class GetLicenseUseCase implements BaseUseCase<Future<LoginResult?>> {
  /// Constructor
  /// @param [repository] User Repository
  ///
  GetLicenseUseCase({
    required UserRepository repository,
  }) : _repository = repository;

  final UserRepository _repository;

  /// Execute the use case
  /// @return [Future<LoginResult?>] login result entity
  ///
  @override
  Future<LoginResult?> execute() async {
    return _repository.getLicence();
  }
}

/// Provider for GetLicenseUseCase
/// @param [ref] ref
/// @return [Future<LoginResult?>] login result entity
///
@riverpod
Future<LoginResult?> getLicenseUseCase(Ref ref) async {
  final UserRepository repository = await ref.watch(
    userRepositoryProvider.future,
  );
  
  return GetLicenseUseCase(repository: repository).execute();
}
