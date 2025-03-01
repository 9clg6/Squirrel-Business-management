
import 'package:json_annotation/json_annotation.dart';
import 'package:squirrel/domain/mixin/serializable.mixin.dart';

part 'check_validity.remote_model.g.dart';

/// [CheckValidityRemoteModel]
@JsonSerializable()
class CheckValidityRemoteModel with SerializableMixin {
  /// Valid
  final bool valid;

  /// Expiration date
  final DateTime expirationDate;

  /// Constructor
  /// @param [valid] valid
  /// @param [expirationDate] expiration date
  ///
  CheckValidityRemoteModel({
    required this.valid,
    required this.expirationDate,
  });

  /// To json
  /// @return [Map<String, dynamic>] json
  ///
  @override
  Map<String, dynamic> toJson() {
    return _$CheckValidityRemoteModelToJson(this);
  }

  /// From json
  /// @param [json] json
  /// @return [CheckValidityRemoteModel] check validity remote model
  ///
  factory CheckValidityRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$CheckValidityRemoteModelFromJson(json);
}
