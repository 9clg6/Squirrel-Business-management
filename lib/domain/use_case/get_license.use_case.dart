import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/repository/user.repository.impl.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';

part 'get_license.use_case.g.dart';

/// [GetLicenseUseCase]
@Riverpod(
  dependencies: <Object>[
    UserRepositoryImpl,
  ],
)
class GetLicenseUseCase extends _$GetLicenseUseCase {
  /// Build
  ///
  @override
  Future<LoginResultEntity?> build() async {
    return _call();
  }

  /// Call
  /// @return [Future<LoginResultEntity?>] login result entity
  ///
  Future<LoginResultEntity?> _call() async {
    return ref.watch(userRepositoryImplProvider.notifier).getLicence();
  }
}
