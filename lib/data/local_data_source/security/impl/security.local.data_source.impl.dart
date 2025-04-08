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
  /// Default constructor
  SecurityLocalDataSourceImpl();

  /// Constructor
  /// @param [_secureStorageService] secure storage service
  ///
  SecurityLocalDataSourceImpl._(this._secureStorageService);

  static const String _appLockStateKey = 'appLockKey';
  static const String _failCountKey = 'failCountKey';
  static const String _lastCheckSuccessKey = 'lastCheckSuccessKey';
  static const String _lastKnownTimeKey = 'lastKnownTimeKey';

  late final HiveSecureStorageService? _secureStorageService;

  /// Build
  /// @return [Future<SecurityLocalDataSourceImpl>] security local data source
  /// impl
  ///
  @override
  Future<SecurityLocalDataSourceImpl> build() async {
    final HiveSecureStorageService? secureStorageService =
        await ref.watch(hiveSecureStorageServiceProvider.future);

    return SecurityLocalDataSourceImpl._(secureStorageService);
  }

  /// Set the app lock state
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  ///
  @override
  Future<void> setAppLockState({required bool isLocked}) async {
    return _secureStorageService!.set(
      _appLockStateKey,
      isLocked ? 'true' : 'false',
    );
  }

  /// Get the app lock state
  /// @return [Future<bool>] if the app is locked
  ///
  @override
  Future<bool> getAppLockState() async {
    final String? isLocked = await _secureStorageService!.get(_appLockStateKey);
    if (isLocked == null) return false;

    return isLocked == 'true';
  }

  /// Get the fail count
  /// @return [Future<int>] the fail count
  ///
  @override
  Future<int> getFailCount() async {
    final String? failCount = await _secureStorageService?.get(_failCountKey);
    if (failCount == null) return 0;

    return int.tryParse(failCount) ?? 0;
  }

  @override
  Future<void> setFailCount(int count) async {
    return _secureStorageService!.set(
      _failCountKey,
      count.toString(),
    );
  }

  @override
  Future<void> setLastCheckSuccess(String date) async {
    return _secureStorageService!.set(
      _lastCheckSuccessKey,
      date,
    );
  }

  @override
  Future<DateTime> getLastCheckSuccess() async {
    final String? lastCheckSuccess = await _secureStorageService!.get(
      _lastCheckSuccessKey,
    );
    if (lastCheckSuccess == null) return DateTime.now();

    return DateTime.tryParse(lastCheckSuccess) ?? DateTime.now();
  }

  @override
  Future<void> setLastKnownTime(String date) async {
    return _secureStorageService!.set(
      _lastKnownTimeKey,
      date,
    );
  }

  @override
  Future<String?> getLastKnownTime() async {
    return _secureStorageService!.get(_lastKnownTimeKey);
  }
}
