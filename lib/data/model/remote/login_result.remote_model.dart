import 'package:json_annotation/json_annotation.dart';
import 'package:squirrel/domain/mixin/serializable.mixin.dart';

part 'login_result.remote_model.g.dart';

/// [LoginResultRemoteModel]
@JsonSerializable()
class LoginResultRemoteModel with SerializableMixin {
  /// Is valid
  final bool valid;

  /// License key
  final String licenseKey;

  /// License id
  final DateTime? expirationDate;

  /// Constructor
  /// @param [valid] is valid
  /// @param [licenseKey] license key
  /// @param [expirationDate] expiration date
  ///
  LoginResultRemoteModel({
    required this.valid,
    required this.licenseKey,
    required this.expirationDate,
  });

  /// To json
  /// @return [Map<String, dynamic>] json
  ///
  @override
  Map<String, dynamic> toJson() {
    return _$LoginResultRemoteModelToJson(this);
  }

  /// From json
  /// @param [json] json
  /// @return [LoginResultRemoteModel] login result remote model
  ///
  factory LoginResultRemoteModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResultRemoteModelFromJson(json);
}
