import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

/// Use case to set the last known time
class SetLastKnownTimeUseCase
    implements BaseUseCaseWithParams<Future<void>, DateTime> {
  /// Constructor
  /// @param [repository] Security Repository
  ///
  SetLastKnownTimeUseCase({
    required SecurityRepository repository,
  }) : _repository = repository;

  final SecurityRepository _repository;

  /// Execute the use case
  /// @param date [DateTime] the date to set
  /// @return [Future<void>] the last known time
  ///
  @override
  Future<void> execute(DateTime date) async {
    return _repository.setLastKnownTime(date);
  }
}
