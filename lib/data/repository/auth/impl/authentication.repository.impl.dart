import 'package:init/data/remote_data_source/authentication.data_source.dart';
import 'package:init/data/repository/auth/authentication.repository.dart';


class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDataSource _authenticationDataSource;

  AuthenticationRepositoryImpl(this._authenticationDataSource);

  @override
  Future<bool> login(String licenseKey) async {
    return await _authenticationDataSource.login(licenseKey);
  }
}
