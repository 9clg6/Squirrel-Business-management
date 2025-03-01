import 'package:squirrel/data/model/remote/check_validity.remote_model.dart';

/// [CheckValidityEntity]
class CheckValidityEntity {
  /// Valid
  final bool valid;

  /// Expiration date
  final DateTime expirationDate;

  /// Constructor
  /// @param [valid] valid
  /// @param [expirationDate] expiration date
  ///
  CheckValidityEntity({
    required this.valid,
    required this.expirationDate,
  });

  /// From remote model
  /// @param [remoteModel] remote model
  /// @return [CheckValidityEntity] check validity entity
  ///
  factory CheckValidityEntity.fromRemoteModel(
    CheckValidityRemoteModel remoteModel,
  ) {
    return CheckValidityEntity(
      valid: remoteModel.valid,
      expirationDate: remoteModel.expirationDate,
    );
  }
}
