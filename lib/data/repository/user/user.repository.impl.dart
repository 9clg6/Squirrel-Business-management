import 'package:squirrel/data/local_data_source/user/user.local.data_source.dart';
import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/user.repository.dart';

/// [UserRepositoryImpl]
class UserRepositoryImpl implements UserRepository {
  /// Constructor
  /// @param [_localDataSource] local data source
  ///
  UserRepositoryImpl(this._localDataSource);

  final UserLocalDataSource _localDataSource;

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
