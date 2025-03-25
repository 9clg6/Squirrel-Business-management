import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/model/remote/check_validity.remote_model.dart';
import 'package:squirrel/data/model/remote/login_result.remote_model.dart';
import 'package:squirrel/data/remote_data_source/authentication.data_source.dart';
import 'package:squirrel/data/remote_data_source/impl/authentication.data_source.impl.dart';
import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';
import 'package:squirrel/domain/repositories/authentication.repository.dart';

part 'authentication.repository.impl.g.dart';

/// [AuthenticationRepositoryImpl]
@Riverpod(
  dependencies: <Object>[
    AuthenticationDataSourceImpl,
  ],
)
class AuthenticationRepositoryImpl extends _$AuthenticationRepositoryImpl
    implements AuthenticationRepository {
  /// Authentication data source
  late final AuthenticationDataSource _authenticationDataSource;

  @override
  AuthenticationRepositoryImpl build() {
    _authenticationDataSource = ref.read(authenticationDataSourceImplProvider);
    return AuthenticationRepositoryImpl();
  }

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
  /// @return [CheckValidityEntity] check validity entity
  ///
  @override
  Future<CheckValidityEntity> checkValidity(String licenseKey) async {
    final CheckValidityRemoteModel remoteModel =
        await _authenticationDataSource.checkValidity(licenseKey);

    return CheckValidityEntity.fromRemoteModel(remoteModel);
  }
}
