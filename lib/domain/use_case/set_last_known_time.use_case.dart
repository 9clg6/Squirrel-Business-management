import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security/security.repository.provider.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

part 'set_last_known_time.use_case.g.dart';

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

/// Provider for SetLastKnownTimeUseCase
/// @param [ref] ref
/// @param date [DateTime] the date to set
/// @return [Future<void>] the last known time
///
@riverpod
Future<void> setLastKnownTimeUseCase(
  Ref ref, {
  required DateTime date,
}) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );

  return SetLastKnownTimeUseCase(repository: repository).execute(date);
}
