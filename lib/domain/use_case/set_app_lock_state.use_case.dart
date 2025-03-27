import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';

part 'set_app_lock_state.use_case.g.dart';

/// Use case to set the app lock state
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
class SetAppLockStateUseCase extends _$SetAppLockStateUseCase {
  /// Constructor
  /// @param [isLocked] if the app is locked
  /// @return [FutureOr<void>]
  ///
  @override
  FutureOr<void> build(bool isLocked) async {
    return _call(isLocked);
  }

  /// Call
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  ///
  Future<void> _call(bool isLocked) async {
    return ref
        .watch(securityRepositoryImplProvider.notifier)
        .setAppLockState(isLocked: isLocked);
  }
}
