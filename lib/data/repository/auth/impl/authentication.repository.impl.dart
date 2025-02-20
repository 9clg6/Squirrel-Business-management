import 'package:init/data/model/remote/login_result.remote_model.dart';
import 'package:init/data/remote_data_source/authentication.data_source.dart';
import 'package:init/data/repository/auth/authentication.repository.dart';
import 'package:init/domain/entities/login_result.entity.dart';

/// [AuthenticationRepositoryImpl]
class AuthenticationRepositoryImpl extends AuthenticationRepository {
  /// Authentication data source
  final AuthenticationDataSource _authenticationDataSource;

  /// Constructor
  /// @param [_authenticationDataSource] authentication data source
  /// 
  AuthenticationRepositoryImpl(this._authenticationDataSource);

  /// Login
  /// @param [licenseKey] license key
  /// @return [LoginResultEntity] login result entity
  ///
  @override
  Future<LoginResultEntity> login(String licenseKey) async {
    final LoginResultRemoteModel remoteModel =
        await _authenticationDataSource.login(licenseKey);

    return LoginResultEntity.fromRemoteModel(remoteModel);
  }

  /// Check validity of license
  /// @param [licenseKey] license key
  /// @return [bool] validity
  ///
  @override
  Future<bool> checkValidity(String licenseKey) async {
    return await _authenticationDataSource.checkValidity(licenseKey);
  }
}
