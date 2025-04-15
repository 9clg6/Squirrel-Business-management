import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

/// Use case to set the app lock state
class SetAppLockStateUseCase
    implements BaseUseCaseWithParams<Future<void>, bool> {
  /// Constructor
  /// @param [repository] Security Repository
  SetAppLockStateUseCase({
    required SecurityRepository repository,
  }) : _repository = repository;

  final SecurityRepository _repository;

  /// Execute the use case
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  @override
  Future<void> execute(bool isLocked) async {
    return _repository.setAppLockState(isLocked: isLocked);
  }
}
