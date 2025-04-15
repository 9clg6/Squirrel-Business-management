import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

/// Use case to set the fail count
class SetFailCountUseCase implements BaseUseCaseWithParams<Future<void>, int> {
  /// Constructor
  /// @param [repository] Security Repository
  ///
  SetFailCountUseCase({
    required SecurityRepository repository,
  }) : _repository = repository;

  final SecurityRepository _repository;

  /// Execute the use case
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  @override
  Future<void> execute(int count) async {
    return _repository.setFailCount(count);
  }
}
