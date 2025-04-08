import 'package:squirrel/data/local_data_source/preferences/preferences_local.data_source.dart';
import 'package:squirrel/domain/repositories/preferences.repository.dart';
import 'package:squirrel/foundation/enums/theme_appareance.enum.dart';

/// [PreferencesRepositoryImpl]
class PreferencesRepositoryImpl implements PreferencesRepository {
  /// Constructor
  /// @param [_localDataSource] preferences local data source
  ///
  PreferencesRepositoryImpl(this._localDataSource);

  /// Preferences local data source
  late final PreferencesLocalDataSource _localDataSource;

  /// Change theme
  /// @param [newThemeAppearance] new theme appearance
  /// @return [Future<void>] void
  ///
  @override
  Future<void> changeTheme(ThemeAppearance newThemeAppearance) async {
    await _localDataSource.saveTheme(newThemeAppearance.name);
  }

  /// Get current theme
  /// @return [Future<ThemeAppearance>] current theme
  ///
  @override
  Future<ThemeAppearance> getCurrentTheme() async {
    final String? result = await _localDataSource.getCurrentTheme();
    switch (result) {
      case 'light':
        return ThemeAppearance.light;
      case 'dark':
        return ThemeAppearance.dark;
      case 'system':
        return ThemeAppearance.system;
      default:
        return ThemeAppearance.system;
    }
  }

  /// Clear preferences
  /// @return [Future<void>] void
  ///
  @override
  Future<void> clearPreferences() {
    return _localDataSource.clearPreferences();
  }
}
