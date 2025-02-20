

import 'package:init/domain/entities/login_result.entity.dart';

/// Authentication repository
abstract class AuthenticationRepository {
  /// Login
  /// @param [licenseKey] license key
  /// @return [LoginResultEntity] login result entity
  ///
  Future<LoginResultEntity> login(String licenseKey);

  /// Check validity of license
  /// @param [licenseKey] license key
  /// @return [bool] validity
  ///
  Future<bool> checkValidity(String licenseKey);
}
