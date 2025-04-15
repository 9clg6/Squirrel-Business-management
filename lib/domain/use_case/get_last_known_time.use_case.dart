import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

/// Use case to get the last known time
class GetLastKnownTimeUseCase implements BaseUseCase<Future<DateTime>> {
  /// Constructor
  /// @param [repository] Security Repository
  ///
  GetLastKnownTimeUseCase({
    required SecurityRepository repository,
  }) : _repository = repository;

  final SecurityRepository _repository;

  /// Execute the use case
  /// @return [Future<DateTime>] the last known time
  ///
  @override
  Future<DateTime> execute() async {
    return _repository.getLastKnownTime();
  }
}
