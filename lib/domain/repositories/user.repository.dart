import 'package:squirrel/domain/entities/login_result.entity.dart';

/// [UserRepository]
abstract class UserRepository {
  /// Get licence
  /// @return [Future<LoginResultEntity?>] login result entity
  ///
  Future<LoginResult?> getLicence();

  /// Save licence
  /// @param [loginResultEntity] login result entity
  /// @return [Future<void>] void
  ///
  Future<void> saveLicense(LoginResult loginResultEntity);
}
