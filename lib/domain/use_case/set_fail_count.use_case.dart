import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';

part 'set_fail_count.use_case.g.dart';

/// Use case to set the fail count
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
class SetFailCountUseCase extends _$SetFailCountUseCase {
  /// Constructor
  /// @param [count] the count
  /// @return [FutureOr<void>]
  ///
  @override
  FutureOr<void> build(int count) async {
    return _call(count);
  }

  /// Call
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  Future<void> _call(int count) async {
    return ref
        .watch(securityRepositoryImplProvider.notifier)
        .setFailCount(count);
  }
}
