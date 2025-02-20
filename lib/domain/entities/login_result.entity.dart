import 'package:init/data/model/local/login_result.local_model.dart';
import 'package:init/data/model/remote/login_result.remote_model.dart';

/// [LoginResultEntity]
class LoginResultEntity {
  /// Is valid
  final bool valid;

  /// Expiration date
  final DateTime? expirationDate;

  /// License key
  final String licenseKey;

  /// Constructor
  /// @param [valid] is valid
  /// @param [expirationDate] expiration date
  /// @param [licenseKey] license key
  ///
  LoginResultEntity({
    required this.valid,
    required this.expirationDate,
    required this.licenseKey,
  });

  /// From remote model
  /// @param [remoteModel] remote model
  /// @return [LoginResultEntity] login result entity
  ///
  factory LoginResultEntity.fromRemoteModel(
      LoginResultRemoteModel remoteModel) {
    return LoginResultEntity(
      valid: remoteModel.valid,
      expirationDate: remoteModel.expirationDate,
      licenseKey: remoteModel.licenseKey,
    );
  }

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
