import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

part 'set_app_lock_state.use_case.g.dart';

/// Use case to set the app lock state
class SetAppLockStateUseCase
    implements BaseUseCaseWithParams<Future<void>, bool> {
  /// Constructor
  /// @param [repository] Security Repository
  SetAppLockStateUseCase({
    required SecurityRepository repository,
  }) : _repository = repository;

  final SecurityRepository _repository;

  /// Execute the use case
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  @override
  Future<void> execute(bool isLocked) async {
    return _repository.setAppLockState(isLocked: isLocked);
  }
}

/// Provider for SetAppLockStateUseCase
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
Future<void> setAppLockStateUseCase(
  Ref ref, {
  required bool isLocked,
}) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );

  return SetAppLockStateUseCase(
    repository: repository,
  ).execute(isLocked);
}
