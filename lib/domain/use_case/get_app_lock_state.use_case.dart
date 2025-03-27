import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';

part 'get_app_lock_state.use_case.g.dart';

/// Use case to get the app lock state
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
class GetAppLockStateUseCase extends _$GetAppLockStateUseCase {
  @override
  FutureOr<bool> build() async {
    return _call();
  }

  /// Call
  /// @return [Future<bool>] if the app is locked
  ///
  Future<bool> _call() async {
    return ref.watch(securityRepositoryImplProvider.notifier).isAppLocked();
  }
}
