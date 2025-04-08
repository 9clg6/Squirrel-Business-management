import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/user/impl/user.local.data_source.impl.dart';
import 'package:squirrel/data/local_data_source/user/user.local.data_source.dart';
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
  /// Default constructor
  UserRepositoryImpl();

  /// Constructor
  /// @param [_localDataSource] local data source
  ///
  UserRepositoryImpl._(this._localDataSource);

  late final UserLocalDataSource _localDataSource;

  /// Build
  /// @return [Future<UserRepositoryImpl>] user repository impl
  ///
  @override
  Future<UserRepositoryImpl> build() async {
    return UserRepositoryImpl._(
      await ref.watch(userLocalDataSourceImplProvider.future),
    );
  }

  @override
  Future<LoginResult?> getLicence() async {
    final LoginResultLocalModel? localLicense =
        await _localDataSource.getLicence();

    if (localLicense == null) return null;

    return LoginResult.fromLocalModel(localLicense);
  }

  @override
  Future<void> saveLicense(LoginResult loginResultEntity) async {
    await _localDataSource.saveLicense(loginResultEntity.toLocalModel());
  }
}
