import 'package:squirrel/data/repository/preferences/preferences.repository.dart';
import 'package:squirrel/domain/use_case/abstraction/use_case_abs.dart';
import 'package:squirrel/foundation/enums/theme_appareance.enum.dart';

/// [GetThemeUseCase]
class GetThemeUseCase implements UseCase<Future<ThemeAppearance>> {
  /// Preferences repository
  final PreferencesRepository _preferencesRepository;

  /// Constructor
  /// @param [_preferencesRepository] preferences repository
  ///
  GetThemeUseCase(this._preferencesRepository);

  /// Get current theme
  /// @return [ThemeAppearance] current theme
  ///
  @override
  Future<ThemeAppearance> execute() {
    return _preferencesRepository.getCurrentTheme();
  }
}
