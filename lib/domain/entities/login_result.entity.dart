import 'package:squirrel/data/model/local/login_result.local_model.dart';
import 'package:squirrel/data/model/remote/login_result.remote_model.dart';

/// [LoginResult]
class LoginResult {
  /// Constructor
  /// @param [valid] is valid
  /// @param [expirationDate] expiration date
  /// @param [licenseKey] license key
  ///
  LoginResult({
    required this.valid,
    required this.expirationDate,
    required this.licenseKey,
  });

  /// From local model
  /// @param [localLicense] local license
  /// @return [LoginResult] login result entity
  ///
  factory LoginResult.fromLocalModel(
    LoginResultLocalModel localLicense,
  ) {
    return LoginResult(
      valid: localLicense.valid,
      licenseKey: localLicense.licenseKey,
      expirationDate: localLicense.expirationDate,
    );
  }

  /// From remote model
  /// @param [remoteModel] remote model
  /// @return [LoginResult] login result entity
  ///
  factory LoginResult.fromRemoteModel(
    LoginResultRemoteModel remoteModel,
  ) {
    return LoginResult(
      valid: remoteModel.valid,
      expirationDate: remoteModel.expirationDate,
      licenseKey: remoteModel.licenseKey,
    );
  }

  /// Is valid
  final bool valid;

  /// Expiration date
  final DateTime? expirationDate;

  /// License key
  final String licenseKey;

  /// To local model
  /// @return [LoginResultLocalModel] login result local model
  ///
  LoginResultLocalModel toLocalModel() {
    return LoginResultLocalModel(
      valid: valid,
      licenseKey: licenseKey,
      expirationDate: expirationDate,
    );
  }
}
