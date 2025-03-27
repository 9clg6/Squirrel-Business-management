import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';

part 'set_last_check_success.use_case.g.dart';

/// Use case to set the last check success
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
class SetLastCheckSuccessUseCase extends _$SetLastCheckSuccessUseCase {
  /// Constructor
  /// @param [date] the date
  /// @return [FutureOr<void>]
  ///
  @override
  FutureOr<void> build(String date) async {
    return _call(date);
  }

  /// Call
  /// @param [date] the date
  /// @return [Future<void>]
  ///
  Future<void> _call(String date) async {
    return ref
        .watch(securityRepositoryImplProvider.notifier)
        .setLastCheckSuccess(date);
  }
}
