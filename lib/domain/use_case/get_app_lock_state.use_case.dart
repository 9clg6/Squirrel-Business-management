import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

/// Use case to get the app lock state
class GetAppLockStateUseCase implements BaseUseCase<Future<bool>> {
  /// Constructor
  /// @param [repository] Security Repository
  ///
  GetAppLockStateUseCase({
    required SecurityRepository repository,
  }) : _repository = repository;

  final SecurityRepository _repository;

  /// Execute the use case
  /// @return [Future<bool>] if the app is locked
  ///
  @override
  Future<bool> execute() async {
    return _repository.isAppLocked();
  }
}
