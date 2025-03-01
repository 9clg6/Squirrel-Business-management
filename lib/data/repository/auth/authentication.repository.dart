import 'package:squirrel/domain/entities/check_validity.entity.dart';
import 'package:squirrel/domain/entities/login_result.entity.dart';

/// Authentication repository
abstract class AuthenticationRepository {
  /// Login
  /// @param [licenseKey] license key
  /// @return [LoginResultEntity] login result entity
  ///
  Future<LoginResultEntity> login(String licenseKey);

  /// Check validity of license
  /// @param [licenseKey] license key
  /// @return [CheckValidityEntity] check validity entity
  ///
  Future<CheckValidityEntity> checkValidity(String licenseKey);
}
