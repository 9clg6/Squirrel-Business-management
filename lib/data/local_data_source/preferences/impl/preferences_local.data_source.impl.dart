import 'package:squirrel/data/local_data_source/preferences/preferences_local.data_source.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';

/// [PreferencesLocalDataSourcesImpl]
class PreferencesLocalDataSourcesImpl implements PreferencesLocalDataSource {
  /// Constructor
  /// @param [_storage] hive secure storage
  ///
  PreferencesLocalDataSourcesImpl(this._storage);

  /// Hive secure storage
  final HiveSecureStorageService _storage;

  /// Theme key
  static const String _themeKey = 'theme_appearance_key';

  /// Get current theme
  /// @return [Future<String?>] current theme
  ///
  @override
  Future<String?> getCurrentTheme() => _storage.get(_themeKey);

  /// Save theme
  /// @param [value] value
  /// @return [Future<void>] void
  ///
  @override
  Future<void> saveTheme(String value) => _storage.set(_themeKey, value);

  /// Clear preferences
  /// @return [Future<void>] void
  ///
  @override
  Future<void> clearPreferences() {
    return _storage.remove(_themeKey);
  }
}
