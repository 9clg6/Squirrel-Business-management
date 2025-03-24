/// [PreferencesLocalDataSource]
abstract class PreferencesLocalDataSource {
  /// save theme in local storage
  /// @param [value] value
  /// @return [Future<void>] void
  ///
  Future<void> saveTheme(String value);

  /// get saved theme from local storage
  /// @return [Future<String?>] saved theme
  ///
  Future<String?> getCurrentTheme();

  /// clear preferences
  /// @return [Future<void>] void
  ///
  Future<void> clearPreferences();
}
