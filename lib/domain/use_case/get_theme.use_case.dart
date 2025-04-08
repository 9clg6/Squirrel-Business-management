import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/preferences.repository_impl.dart';
import 'package:squirrel/domain/repositories/preferences.repository.dart';
import 'package:squirrel/domain/use_case/usecase.interfaces.dart';
import 'package:squirrel/foundation/enums/theme_appareance.enum.dart';

part 'get_theme.use_case.g.dart';

/// Get Theme Use Case Implementation
class GetThemeUseCase implements BaseUseCase<Future<ThemeAppearance>> {
  /// Constructor
  /// @param [repository] repository
  ///
  GetThemeUseCase({required PreferencesRepository repository})
      : _repository = repository;

  /// Repository
  final PreferencesRepository _repository;

  /// Execute Get Theme Use Case
  /// @return [Future<ThemeAppearance>] result
  ///
  @override
  Future<ThemeAppearance> execute() {
    return _repository.getCurrentTheme();
  }
}

/// Get Theme Use Case Provider
/// @param [ref] ref
/// @return [Future<ThemeAppearance>] result
///
@riverpod
Future<ThemeAppearance> getThemeUseCase(Ref ref) {
  final PreferencesRepository repository = ref.watch(
    preferencesRepositoryImplProvider,
  );
  return GetThemeUseCase(repository: repository).execute();
}
