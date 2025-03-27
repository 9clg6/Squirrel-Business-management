// ignore_for_file: one_member_abstracts tg

/// Security local data source
abstract class SecurityLocalDataSource {
  /// Set the app lock state
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  ///
  Future<void> setAppLockState({required bool isLocked});

  /// Get the app lock state
  /// @return [Future<bool>] if the app is locked
  ///
  Future<bool> getAppLockState();

  /// Get the fail count
  /// @return [Future<int>] the fail count
  ///
  Future<int> getFailCount();

  /// Set the fail count
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  Future<void> setFailCount(int count);

  /// Set the last check success
  /// @param [date] the date
  /// @return [Future<void>]
  ///
  Future<void> setLastCheckSuccess(String date);

  /// Get the last check success
  /// @return [Future<DateTime>] the last check success
  ///
  Future<DateTime> getLastCheckSuccess();

  /// Set the last known time
  /// @param [date] the date
  /// @return [Future<void>]
  ///
  Future<void> setLastKnownTime(String date);

  /// Get the last known time
  /// @return [Future<String?>] the last known time
  ///
  Future<String?> getLastKnownTime();
}
