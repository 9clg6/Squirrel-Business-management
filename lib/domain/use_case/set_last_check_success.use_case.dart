import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

/// Use case to set the last check success
class SetLastCheckSuccessUseCase
    implements BaseUseCaseWithParams<Future<void>, String> {
  /// Constructor
  /// @param [repository] Security Repository
  ///
  SetLastCheckSuccessUseCase({
    required SecurityRepository repository,
  }) : _repository = repository;

  final SecurityRepository _repository;

  /// Execute the use case
  /// @param [date] the date (as String)
  /// @return [Future<void>]
  ///
  @override
  Future<void> execute(String date) async {
    return _repository.setLastCheckSuccess(date);
  }
}
