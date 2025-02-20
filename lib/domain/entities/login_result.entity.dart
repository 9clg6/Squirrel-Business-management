import 'package:init/data/model/login_result.remote_model.dart';

/// [LoginResultEntity]
class LoginResultEntity {
  /// Is valid
  final bool valid;

  /// Expiration date
  final DateTime? expirationDate;

  /// Constructor
  /// @param [valid] is valid
  /// @param [expirationDate] expiration date
  ///
  LoginResultEntity({
    required this.valid,
    required this.expirationDate,
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
    );
  }
}
