import 'package:squirrel/data/model/remote/check_validity.remote_model.dart';
import 'package:squirrel/data/model/remote/login_result.remote_model.dart';
import 'package:squirrel/data/remote_data_source/authentication.data_source.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/authentication.repository.dart';

/// [AuthenticationRepositoryImpl]
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  /// Constructor
  /// @param [_authenticationDataSource] authentication data source
  ///
  AuthenticationRepositoryImpl(
    this._authenticationDataSource,
  );

  /// Authentication data source
  late final AuthenticationDataSource _authenticationDataSource;

  /// Login
  /// @param [licenseKey] license key
  /// @return [LoginResult] login result entity
  ///
  @override
  Future<LoginResult> login(String licenseKey) async {
    final LoginResultRemoteModel remoteModel =
        await _authenticationDataSource.login(licenseKey);

    return LoginResult.fromRemoteModel(remoteModel);
  }

  /// Check validity of license
  /// @param [licenseKey] license key
  /// @return [CheckValidityEntity] check validity entity
  ///
  @override
  Future<CheckValidityEntity> checkValidity(String licenseKey) async {
    final CheckValidityRemoteModel remoteModel =
        await _authenticationDataSource.checkValidity(licenseKey);

    return CheckValidityEntity.fromRemoteModel(remoteModel);
  }
}
