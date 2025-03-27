
/// Security repository
abstract class SecurityRepository {
  /// Set the app lock state
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  ///
  Future<void> setAppLockState({required bool isLocked});

  /// Is the app locked
  /// @return [Future<bool>] if the app is locked
  ///
  Future<bool> isAppLocked();

  /// Set the fail count
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  Future<void> setFailCount(int count);

  /// Get the fail count
  /// @return [Future<int>] the fail count
  ///
  Future<int> getFailCount();

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
  Future<void> setLastKnownTime(DateTime date);

  /// Get the last known time
  /// @return [Future<DateTime>] the last known time
  ///
  Future<DateTime> getLastKnownTime();
}
