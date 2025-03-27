import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/security/impl/security.local.data_source.impl.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';

part 'security.repository.impl.g.dart';

/// [SecurityRepositoryImpl]
@Riverpod(
  dependencies: <Object>[
    SecurityLocalDataSourceImpl,
  ],
)
class SecurityRepositoryImpl extends _$SecurityRepositoryImpl
    implements SecurityRepository {
  /// Build
  /// @return [Future<SecurityRepositoryImpl>] security repository impl
  ///
  @override
  SecurityRepositoryImpl build() {
    return SecurityRepositoryImpl();
  }

  /// Set the app lock state
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  ///
  @override
  Future<void> setAppLockState({required bool isLocked}) async {
    await ref
        .watch(securityLocalDataSourceImplProvider.notifier)
        .setAppLockState(isLocked: isLocked);
  }

  /// Is the app locked
  /// @return [Future<bool>] if the app is locked
  ///
  @override
  Future<bool> isAppLocked() async {
    return ref
        .watch(securityLocalDataSourceImplProvider.notifier)
        .getAppLockState();
  }

  /// Set the fail count
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  @override
  Future<void> setFailCount(int count) async {
    await ref
        .watch(securityLocalDataSourceImplProvider.notifier)
        .setFailCount(count);
  }

  /// Get the fail count
  /// @return [Future<int>] the fail count
  ///
  @override
  Future<int> getFailCount() async {
    return ref
        .watch(securityLocalDataSourceImplProvider.notifier)
        .getFailCount();
  }

  /// Set the last check success
  /// @param [date] the date
  /// @return [Future<void>]
  ///
  @override
  Future<void> setLastCheckSuccess(String date) async {
    await ref
        .watch(securityLocalDataSourceImplProvider.notifier)
        .setLastCheckSuccess(date);
  }

  @override
  Future<DateTime> getLastCheckSuccess() async {
    return ref
        .watch(securityLocalDataSourceImplProvider.notifier)
        .getLastCheckSuccess();
  }

  @override
  Future<void> setLastKnownTime(DateTime date) async {
    await ref
        .watch(securityLocalDataSourceImplProvider.notifier)
        .setLastKnownTime(date.toIso8601String());
  }

  @override
  Future<DateTime> getLastKnownTime() async {
    final String? lastKnownTime = await ref
        .watch(securityLocalDataSourceImplProvider.notifier)
        .getLastKnownTime();

    if (lastKnownTime == null) return DateTime.now();

    return DateTime.parse(lastKnownTime);
  }
}
