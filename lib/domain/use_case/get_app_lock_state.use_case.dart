import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';

part 'get_app_lock_state.use_case.g.dart';

/// Use case to get the app lock state
class GetAppLockStateUseCase implements BaseUseCase<Future<bool>> {
  /// Constructor
  /// @param [repository] Security Repository
  ///
  GetAppLockStateUseCase({
    required SecurityRepository repository,
  }) : _repository = repository;

  final SecurityRepository _repository;

  /// Execute the use case
  /// @return [Future<bool>] if the app is locked
  ///
  @override
  Future<bool> execute() async {
    return _repository.isAppLocked();
  }
}

/// Provider for GetAppLockStateUseCase
/// @param [ref] ref
/// @return [Future<bool>] if the app is locked
///
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
Future<bool> getAppLockStateUseCase(Ref ref) async {
  final SecurityRepository repository = await ref.watch(
    securityRepositoryImplProvider.future,
  );
  return GetAppLockStateUseCase(repository: repository).execute();
}
