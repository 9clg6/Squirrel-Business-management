import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

part 'set_last_check_success.use_case.g.dart';

/// Use case to set the last check success
class SetLastCheckSuccessUseCase
    implements BaseUseCaseWithParams<Future<void>, String>   {
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

/// Provider for SetLastCheckSuccessUseCase
/// @param [ref] ref
/// @param [date] the date (as String)
/// @return [Future<void>]
///
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
Future<void> setLastCheckSuccessUseCase(
  Ref ref, {
  required String date,
}) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );
  return SetLastCheckSuccessUseCase(repository: repository).execute(date);
}
