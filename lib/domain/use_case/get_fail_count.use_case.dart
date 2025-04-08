import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security/security.repository.provider.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

part 'get_fail_count.use_case.g.dart';

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

/// Provider for GetFailCountUseCase
/// @param [ref] ref
/// @return [Future<int>] the fail count
///
@riverpod
Future<int> getFailCountUseCase(Ref ref) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );
  
  return GetFailCountUseCase(repository: repository).execute();
}
