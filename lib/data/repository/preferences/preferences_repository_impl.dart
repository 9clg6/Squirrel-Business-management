import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/preferences/impl/preferences_local.data_source.impl.dart';
import 'package:squirrel/data/local_data_source/preferences/preferences_local.data_source.dart';
import 'package:squirrel/domain/repositories/preferences.repository.dart';
import 'package:squirrel/foundation/enums/theme_appareance.enum.dart';

part 'preferences_repository_impl.g.dart';

/// [PreferencesRepositoryImpl]
@Riverpod(
  dependencies: <Object>[
    PreferencesLocalDataSourcesImpl,
  ],
)
class PreferencesRepositoryImpl extends _$PreferencesRepositoryImpl
    implements PreferencesRepository {
  /// Constructor
  ///
  PreferencesRepositoryImpl();

  /// Constructor
  /// @param [_localDataSource] preferences local data source
  ///
  PreferencesRepositoryImpl._(this._localDataSource);

  /// Preferences local data source
  late final PreferencesLocalDataSource _localDataSource;

  /// Build
  /// @return [PreferencesRepositoryImpl] preferences repository impl
  ///
  @override
  PreferencesRepositoryImpl build() {
    return PreferencesRepositoryImpl._(
      ref.read(preferencesLocalDataSourcesImplProvider),
    );
  }

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
