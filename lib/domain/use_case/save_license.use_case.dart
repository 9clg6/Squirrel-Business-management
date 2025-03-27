import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/user.repository.impl.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';

part 'save_license.use_case.g.dart';

/// [SaveLicenseUseCase]
@Riverpod(
  dependencies: <Object>[
    UserRepositoryImpl,
  ],
)
class SaveLicenseUseCase extends _$SaveLicenseUseCase {
  /// Build
  /// @param [license] license
  /// @return [Future<void>] void
  ///
  @override
  Future<void> build(LoginResultEntity license) async {
    return _call(license);
  }

  /// Call
  /// @param [license] license
  /// @return [Future<void>] void
  ///
  Future<void> _call(LoginResultEntity license) async {
    return ref.watch(userRepositoryImplProvider.notifier).saveLicense(license);
  }
}
