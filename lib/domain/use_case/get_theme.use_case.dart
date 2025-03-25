import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/preferences/preferences_repository_impl.dart';
import 'package:squirrel/domain/use_case/abstraction/use_case_abs.dart';
import 'package:squirrel/foundation/enums/theme_appareance.enum.dart';

part 'get_theme.use_case.g.dart';

/// [GetThemeUseCase]
@Riverpod(
  dependencies: <Object>[
    PreferencesRepositoryImpl,
  ],
)
class GetThemeUseCase extends _$GetThemeUseCase
    implements UseCase<Future<ThemeAppearance>> {
  /// Constructor
  ///
  GetThemeUseCase();

  /// Build
  /// @return [GetThemeUseCase]
  ///
  @override
  GetThemeUseCase build() {
    return GetThemeUseCase();
  }

  /// Get current theme
  /// @return [ThemeAppearance] current theme
  ///
  @override
  Future<ThemeAppearance> execute() {
    return ref.watch(preferencesRepositoryImplProvider).getCurrentTheme();
  }
}
