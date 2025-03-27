import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/security/security.local.data_source.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';

part 'security.local.data_source.impl.g.dart';

/// [SecurityLocalDataSourceImpl]
@Riverpod(
  dependencies: <Object>[
    HiveSecureStorageService,
  ],
)
class SecurityLocalDataSourceImpl extends _$SecurityLocalDataSourceImpl
    implements SecurityLocalDataSource {
  static const String _appLockStateKey = 'appLockKey';
  static const String _failCountKey = 'failCountKey';
  static const String _lastCheckSuccessKey = 'lastCheckSuccessKey';
  static const String _lastKnownTimeKey = 'lastKnownTimeKey';

  /// Build
  /// @return [Future<SecurityLocalDataSourceImpl>] security local data source
  /// impl
  ///
  @override
  SecurityLocalDataSourceImpl build() {
    return SecurityLocalDataSourceImpl();
  }

  /// Set the app lock state
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  ///
  @override
  Future<void> setAppLockState({required bool isLocked}) async {
    await ref.watch(hiveSecureStorageServiceProvider.notifier).set(
          _appLockStateKey,
          isLocked ? 'true' : 'false',
        );
  }

  /// Get the app lock state
  /// @return [Future<bool>] if the app is locked
  ///
  @override
  Future<bool> getAppLockState() async {
    final String? isLocked = await ref
        .watch(hiveSecureStorageServiceProvider.notifier)
        .get(_appLockStateKey);
    if (isLocked == null) return false;

    return isLocked == 'true';
  }

  /// Get the fail count
  /// @return [Future<int>] the fail count
  ///
  @override
  Future<int> getFailCount() async {
    final String? failCount = await ref
        .watch(hiveSecureStorageServiceProvider.notifier)
        .get(_failCountKey);
    if (failCount == null) return 0;

    return int.tryParse(failCount) ?? 0;
  }

  @override
  Future<void> setFailCount(int count) async {
    await ref.watch(hiveSecureStorageServiceProvider.notifier).set(
          _failCountKey,
          count.toString(),
        );
  }

  @override
  Future<void> setLastCheckSuccess(String date) async {
    await ref.watch(hiveSecureStorageServiceProvider.notifier).set(
          _lastCheckSuccessKey,
          date,
        );
  }

  @override
  Future<DateTime> getLastCheckSuccess() async {
    final String? lastCheckSuccess = await ref
        .watch(hiveSecureStorageServiceProvider.notifier)
        .get(_lastCheckSuccessKey);
    if (lastCheckSuccess == null) return DateTime.now();

    return DateTime.parse(lastCheckSuccess);
  }

  @override
  Future<void> setLastKnownTime(String date) async {
    await ref.watch(hiveSecureStorageServiceProvider.notifier).set(
          _lastKnownTimeKey,
          date,
        );
  }

  @override
  Future<String?> getLastKnownTime() async {
    return ref
        .watch(hiveSecureStorageServiceProvider.notifier)
        .get(_lastKnownTimeKey);
  }
}
