import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/security.repository.impl.dart';

part 'get_fail_count.use_case.g.dart';

/// Use case to get the fail count
@Riverpod(
  dependencies: <Object>[
    SecurityRepositoryImpl,
  ],
)
class GetFailCountUseCase extends _$GetFailCountUseCase {
  /// Build
  /// @return [Future<int>] the fail count
  ///
  @override
  Future<int> build() {
    return _call();
  }

  /// Get the fail count
  /// @return [Future<int>] the fail count
  ///
  Future<int> _call() async {
    return ref.watch(securityRepositoryImplProvider.notifier).getFailCount();
  }
}
