import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

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
