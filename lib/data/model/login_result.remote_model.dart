import 'package:init/domain/mixin/serializable.mixin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_result.remote_model.g.dart';

/// [LoginResultRemoteModel]
@JsonSerializable()
class LoginResultRemoteModel with SerializableMixin {
  /// Is valid
  final bool valid;

  /// License id
  final DateTime? expirationDate;

  /// Constructor
  /// @param [valid] is valid
  /// @param [expirationDate] expiration date
  ///
  LoginResultRemoteModel({
    required this.valid,
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
