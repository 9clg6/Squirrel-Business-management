// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClientCWProxy {
  Client id(String? id);

  Client name(String name);

  Client socialsName(String? socialsName);

  Client orderTotalAmount(double orderTotalAmount);

  Client commissionTotalAmount(double commissionTotalAmount);

  Client orderQuantity(int orderQuantity);

  Client sponsorshipQuantity(int sponsorshipQuantity);

  Client sponsorName(String? sponsorName);

  Client lastOrderDate(DateTime? lastOrderDate);

  Client firstOrderDate(DateTime? firstOrderDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Client(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Client(...).copyWith(id: 12, name: "My name")
  /// ````
  Client call({
    String? id,
    String? name,
    String? socialsName,
    double? orderTotalAmount,
    double? commissionTotalAmount,
    int? orderQuantity,
    int? sponsorshipQuantity,
    String? sponsorName,
    DateTime? lastOrderDate,
    DateTime? firstOrderDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClient.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClient.copyWith.fieldName(...)`
class _$ClientCWProxyImpl implements _$ClientCWProxy {
  const _$ClientCWProxyImpl(this._value);

  final Client _value;

  @override
  Client id(String? id) => this(id: id);

  @override
  Client name(String name) => this(name: name);

  @override
  Client socialsName(String? socialsName) => this(socialsName: socialsName);

  @override
  Client orderTotalAmount(double orderTotalAmount) =>
      this(orderTotalAmount: orderTotalAmount);

  @override
  Client commissionTotalAmount(double commissionTotalAmount) =>
      this(commissionTotalAmount: commissionTotalAmount);

  @override
  Client orderQuantity(int orderQuantity) => this(orderQuantity: orderQuantity);

  @override
  Client sponsorshipQuantity(int sponsorshipQuantity) =>
      this(sponsorshipQuantity: sponsorshipQuantity);

  @override
  Client sponsorName(String? sponsorName) => this(sponsorName: sponsorName);

  @override
  Client lastOrderDate(DateTime? lastOrderDate) =>
      this(lastOrderDate: lastOrderDate);

  @override
  Client firstOrderDate(DateTime? firstOrderDate) =>
      this(firstOrderDate: firstOrderDate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Client(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Client(...).copyWith(id: 12, name: "My name")
  /// ````
  Client call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? socialsName = const $CopyWithPlaceholder(),
    Object? orderTotalAmount = const $CopyWithPlaceholder(),
    Object? commissionTotalAmount = const $CopyWithPlaceholder(),
    Object? orderQuantity = const $CopyWithPlaceholder(),
    Object? sponsorshipQuantity = const $CopyWithPlaceholder(),
    Object? sponsorName = const $CopyWithPlaceholder(),
    Object? lastOrderDate = const $CopyWithPlaceholder(),
    Object? firstOrderDate = const $CopyWithPlaceholder(),
  }) {
    return Client(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      socialsName: socialsName == const $CopyWithPlaceholder()
          ? _value.socialsName
          // ignore: cast_nullable_to_non_nullable
          : socialsName as String?,
      orderTotalAmount: orderTotalAmount == const $CopyWithPlaceholder() ||
              orderTotalAmount == null
          ? _value.orderTotalAmount
          // ignore: cast_nullable_to_non_nullable
          : orderTotalAmount as double,
      commissionTotalAmount:
          commissionTotalAmount == const $CopyWithPlaceholder() ||
                  commissionTotalAmount == null
              ? _value.commissionTotalAmount
              // ignore: cast_nullable_to_non_nullable
              : commissionTotalAmount as double,
      orderQuantity:
          orderQuantity == const $CopyWithPlaceholder() || orderQuantity == null
              ? _value.orderQuantity
              // ignore: cast_nullable_to_non_nullable
              : orderQuantity as int,
      sponsorshipQuantity:
          sponsorshipQuantity == const $CopyWithPlaceholder() ||
                  sponsorshipQuantity == null
              ? _value.sponsorshipQuantity
              // ignore: cast_nullable_to_non_nullable
              : sponsorshipQuantity as int,
      sponsorName: sponsorName == const $CopyWithPlaceholder()
          ? _value.sponsorName
          // ignore: cast_nullable_to_non_nullable
          : sponsorName as String?,
      lastOrderDate: lastOrderDate == const $CopyWithPlaceholder()
          ? _value.lastOrderDate
          // ignore: cast_nullable_to_non_nullable
          : lastOrderDate as DateTime?,
      firstOrderDate: firstOrderDate == const $CopyWithPlaceholder()
          ? _value.firstOrderDate
          // ignore: cast_nullable_to_non_nullable
          : firstOrderDate as DateTime?,
    );
  }
}

extension $ClientCopyWith on Client {
  /// Returns a callable class that can be used as follows: `instanceOfClient.copyWith(...)` or like so:`instanceOfClient.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClientCWProxy get copyWith => _$ClientCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as String?,
      name: json['name'] as String,
      socialsName: json['socialsName'] as String?,
      orderTotalAmount: (json['orderTotalAmount'] as num?)?.toDouble() ?? 0,
      commissionTotalAmount:
          (json['commissionTotalAmount'] as num?)?.toDouble() ?? 0,
      orderQuantity: (json['orderQuantity'] as num?)?.toInt() ?? 0,
      sponsorshipQuantity: (json['sponsorshipQuantity'] as num?)?.toInt() ?? 0,
      sponsorName: json['sponsorName'] as String?,
      lastOrderDate: json['lastOrderDate'] == null
          ? null
          : DateTime.parse(json['lastOrderDate'] as String),
      firstOrderDate: json['firstOrderDate'] == null
          ? null
          : DateTime.parse(json['firstOrderDate'] as String),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'socialsName': instance.socialsName,
      'orderTotalAmount': instance.orderTotalAmount,
      'commissionTotalAmount': instance.commissionTotalAmount,
      'orderQuantity': instance.orderQuantity,
      'sponsorshipQuantity': instance.sponsorshipQuantity,
      'sponsorName': instance.sponsorName,
      'lastOrderDate': instance.lastOrderDate?.toIso8601String(),
      'firstOrderDate': instance.firstOrderDate?.toIso8601String(),
    };
