import 'package:squirrel/foundation/enums/theme_appareance.enum.dart';

/// [PreferencesRepository]
abstract class PreferencesRepository {
  /// Set new app theme
  /// @param [newThemeAppearance] new theme appearance
  /// @return [Future<void>] void
  ///
  Future<void> changeTheme(ThemeAppearance newThemeAppearance);

  /// Get current theme of the app
  /// @return [Future<ThemeAppearance>] current theme
  ///
  Future<ThemeAppearance> getCurrentTheme();

  /// Clear preferences
  /// @return [Future<void>] void
  ///
  Future<void> clearPreferences();
}
