// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result.local_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResultLocalModel _$LoginResultLocalModelFromJson(
        Map<String, dynamic> json) =>
    LoginResultLocalModel(
      valid: json['valid'] as bool,
      licenseKey: json['licenseKey'] as String,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$LoginResultLocalModelToJson(
        LoginResultLocalModel instance) =>
    <String, dynamic>{
      'valid': instance.valid,
      'licenseKey': instance.licenseKey,
      'expirationDate': instance.expirationDate?.toIso8601String(),
    };
