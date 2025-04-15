import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/repositories/authentication.repository.dart';
import 'package:squirrel/domain/use_case/future.usecases.dart';
import 'package:squirrel/domain/use_case/params/check_validity.use_case.params.dart';


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
