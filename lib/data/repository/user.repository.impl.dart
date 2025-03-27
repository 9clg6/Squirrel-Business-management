import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/user/impl/user.local.data_source.impl.dart';
import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';

part 'user.repository.impl.g.dart';

/// [UserRepositoryImpl]
@Riverpod(
  dependencies: <Object>[
    UserLocalDataSourceImpl,
  ],
)
class UserRepositoryImpl extends _$UserRepositoryImpl
    implements UserRepository {
  @override
  UserRepositoryImpl build() {
    return UserRepositoryImpl();
  }

  @override
  Future<LoginResultEntity?> getLicence() async {
    final LoginResultLocalModel? localLicense =
        await ref.watch(userLocalDataSourceImplProvider.notifier).getLicence();

    if (localLicense == null) return null;

    return LoginResultEntity.fromLocalModel(localLicense);
  }

  @override
  Future<void> saveLicense(LoginResultEntity loginResultEntity) async {
    await ref
        .watch(userLocalDataSourceImplProvider.notifier)
        .saveLicense(loginResultEntity.toLocalModel());
  }
}
