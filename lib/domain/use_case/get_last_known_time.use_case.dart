import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';

part 'get_last_known_time.use_case.g.dart';

/// Use case to get the last known time
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
class GetLastKnownTimeUseCase extends _$GetLastKnownTimeUseCase {
  @override
  Future<DateTime> build() {
    return _call();
  }

  /// Get the last known time
  /// @return [Future<DateTime>] the last known time
  ///
  Future<DateTime> _call() async {
    return ref
        .watch(securityRepositoryImplProvider.notifier)
        .getLastKnownTime();
  }
}
