// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result.remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResultRemoteModel _$LoginResultRemoteModelFromJson(
        Map<String, dynamic> json) =>
    LoginResultRemoteModel(
      valid: json['valid'] as bool,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$LoginResultRemoteModelToJson(
        LoginResultRemoteModel instance) =>
    <String, dynamic>{
      'valid': instance.valid,
      'expirationDate': instance.expirationDate?.toIso8601String(),
    };
