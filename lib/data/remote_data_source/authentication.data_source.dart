import 'package:init/data/model/login_result.remote_model.dart';

/// [AuthenticationDataSource]
abstract class AuthenticationDataSource {
  /// Login
  /// @param [licenseKey] license key
  /// @return [LoginResultRemoteModel] login result remote model
  ///
  Future<LoginResultRemoteModel> login(String licenseKey);

  /// Check validity of license
  /// @param [licenseKey] license key
  /// @return [LoginResultRemoteModel] login result remote model
  ///
  Future<bool> checkValidity(String licenseKey);
}
