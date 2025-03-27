import 'package:squirrel/data/model/local/login_result.local_model.dart';

/// [UserLocalDataSource]
abstract class UserLocalDataSource {
  /// Get licence
  /// @return [Future<LoginResultLocalModel>] login result local model
  ///
  Future<LoginResultLocalModel?> getLicence();

  /// Save licence
  /// @param [loginResultLocalModel] login result local model
  /// @return [Future<void>] void
  ///
  Future<void> saveLicense(LoginResultLocalModel loginResultLocalModel);
}
