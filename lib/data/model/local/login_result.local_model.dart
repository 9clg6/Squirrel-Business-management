import 'package:json_annotation/json_annotation.dart';
import 'package:squirrel/domain/mixin/serializable.mixin.dart';

part 'login_result.local_model.g.dart';

/// [LoginResultLocalModel]
@JsonSerializable()
class LoginResultLocalModel with SerializableMixin {
  /// Constructor
  /// @param [valid] is valid
  /// @param [expirationDate] expiration date
  /// 
  LoginResultLocalModel({
    required this.valid,
    required this.licenseKey,
    required this.expirationDate,
  });

  /// From json
  /// @param [json] json
  /// @return [LoginResultLocalModel] login result local model
  ///
  factory LoginResultLocalModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResultLocalModelFromJson(json);

  /// Is valid
  final bool valid;

  /// License key
  final String licenseKey;

  /// License id
  final DateTime? expirationDate;

  /// To json
  /// @return [Map<String, dynamic>] json
  ///
  @override
  Map<String, dynamic> toJson() {
    return _$LoginResultLocalModelToJson(this);
  }
}
