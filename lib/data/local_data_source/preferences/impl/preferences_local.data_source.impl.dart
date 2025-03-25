import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/preferences/preferences_local.data_source.dart';
import 'package:squirrel/data/storage/hive_secure_storage.dart';

part 'preferences_local.data_source.impl.g.dart';

/// [PreferencesLocalDataSourcesImpl]
@Riverpod(
  dependencies: <Object>[
    HiveSecureStorage,
  ],
)
class PreferencesLocalDataSourcesImpl extends _$PreferencesLocalDataSourcesImpl
    implements PreferencesLocalDataSource {
  /// Constructor
  ///
  PreferencesLocalDataSourcesImpl();

  /// Constructor
  /// @param [_storage] hive secure storage
  ///
  PreferencesLocalDataSourcesImpl._(this._storage);

  /// Hive secure storage
  late final HiveSecureStorage _storage;

  /// Theme key
  static const String _themeKey = 'theme_appearance_key';

  /// Build
  /// @return [PreferencesLocalDataSourcesImpl] preferences
  /// local data source impl
  ///
  @override
  PreferencesLocalDataSourcesImpl build() {
    return PreferencesLocalDataSourcesImpl._(
      ref.watch(hiveSecureStorageProvider.notifier),
    );
  }

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
