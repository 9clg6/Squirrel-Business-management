import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security/security.repository.provider.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

part 'set_fail_count.use_case.g.dart';

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

/// Provider for SetFailCountUseCase
/// @param [ref] ref
/// @param [count] the count
/// @return [Future<void>]
///
@riverpod
Future<void> setFailCountUseCase(Ref ref, {required int count}) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );

  return SetFailCountUseCase(repository: repository).execute(count);
}
