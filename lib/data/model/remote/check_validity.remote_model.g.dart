// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_validity.remote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckValidityRemoteModel _$CheckValidityRemoteModelFromJson(
        Map<String, dynamic> json) =>
    CheckValidityRemoteModel(
      valid: json['valid'] as bool,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$CheckValidityRemoteModelToJson(
        CheckValidityRemoteModel instance) =>
    <String, dynamic>{
      'valid': instance.valid,
      'expirationDate': instance.expirationDate.toIso8601String(),
    };
