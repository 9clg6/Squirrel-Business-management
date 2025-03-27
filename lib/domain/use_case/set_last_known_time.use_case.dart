import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';

part 'set_last_known_time.use_case.g.dart';

/// Use case to set the last known time
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
class SetLastKnownTimeUseCase extends _$SetLastKnownTimeUseCase {
  /// Build
  /// @param date [DateTime] the date to set
  /// @return [Future<void>] the last known time
  ///
  @override
  Future<void> build(DateTime date) async {
    return _call(date);
  }

  /// Set the last known time
  /// @param date [String] the date to set
  /// @return [Future<void>] the last known time
  ///
  Future<void> _call(DateTime date) async {
    return ref
        .watch(securityRepositoryImplProvider.notifier)
        .setLastKnownTime(date);
  }
}
