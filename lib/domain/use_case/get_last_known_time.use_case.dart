import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

part 'get_last_known_time.use_case.g.dart';

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

/// Provider for GetLastKnownTimeUseCase
/// @param [ref] ref
/// @return [Future<DateTime>] the last known time
///
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
Future<DateTime> getLastKnownTimeUseCase(Ref ref) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );
  return GetLastKnownTimeUseCase(
    repository: repository,
  ).execute();
}
