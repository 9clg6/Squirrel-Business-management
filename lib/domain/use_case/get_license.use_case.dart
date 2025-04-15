import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

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
