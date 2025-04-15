import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

/// Use case to get the fail count
class GetFailCountUseCase implements BaseUseCase<Future<int>> {
  /// Constructor
  /// @param [repository] Security Repository
  ///
  GetFailCountUseCase({
    required SecurityRepository repository,
  }) : _repository = repository;

  final SecurityRepository _repository;

  /// Execute the use case
  /// @return [Future<int>] the fail count
  ///
  @override
  Future<int> execute() async {
    return _repository.getFailCount();
  }
}
