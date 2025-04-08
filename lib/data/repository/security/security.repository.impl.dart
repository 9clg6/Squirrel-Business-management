import 'package:squirrel/data/local_data_source/security/security.local.data_source.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';

/// [SecurityRepositoryImpl]
class SecurityRepositoryImpl implements SecurityRepository {
  /// Constructor
  /// @param [_localDataSource] local data source
  ///
  SecurityRepositoryImpl(this._localDataSource);

  final SecurityLocalDataSource _localDataSource;

  /// Set the app lock state
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  ///
  @override
  Future<void> setAppLockState({required bool isLocked}) async {
    await _localDataSource.setAppLockState(isLocked: isLocked);
  }

  /// Is the app locked
  /// @return [Future<bool>] if the app is locked
  ///
  @override
  Future<bool> isAppLocked() async {
    return _localDataSource.getAppLockState();
  }

  /// Set the fail count
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  @override
  Future<void> setFailCount(int count) async {
    await _localDataSource.setFailCount(count);
  }

  /// Get the fail count
  /// @return [Future<int>] the fail count
  ///
  @override
  Future<int> getFailCount() async {
    return _localDataSource.getFailCount();
  }

  /// Set the last check success
  /// @param [date] the date
  /// @return [Future<void>]
  ///
  @override
  Future<void> setLastCheckSuccess(String date) async {
    await _localDataSource.setLastCheckSuccess(date);
  }

  @override
  Future<DateTime> getLastCheckSuccess() async {
    return _localDataSource.getLastCheckSuccess();
  }

  @override
  Future<void> setLastKnownTime(DateTime date) async {
    await _localDataSource.setLastKnownTime(date.toIso8601String());
  }

  @override
  Future<DateTime> getLastKnownTime() async {
    final String? lastKnownTime = await _localDataSource.getLastKnownTime();

    if (lastKnownTime == null) return DateTime.now();

    return DateTime.tryParse(lastKnownTime) ?? DateTime.now();
  }
}
