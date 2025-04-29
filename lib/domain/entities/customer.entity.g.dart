// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomerCWProxy {
  Customer name(String name);

  Customer id(String? id);

  Customer socialsName(String? socialsName);

  Customer orderTotalAmount(double orderTotalAmount);

  Customer commissionTotalAmount(double commissionTotalAmount);

  Customer orderQuantity(int orderQuantity);

  Customer sponsorshipQuantity(int sponsorshipQuantity);

  Customer lastOrderDate(DateTime? lastOrderDate);

  Customer firstOrderDate(DateTime? firstOrderDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Customer(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Customer(...).copyWith(id: 12, name: "My name")
  /// ````
  Customer call({
    String? name,
    String? id,
    String? socialsName,
    double? orderTotalAmount,
    double? commissionTotalAmount,
    int? orderQuantity,
    int? sponsorshipQuantity,
    DateTime? lastOrderDate,
    DateTime? firstOrderDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCustomer.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCustomer.copyWith.fieldName(...)`
class _$CustomerCWProxyImpl implements _$CustomerCWProxy {
  const _$CustomerCWProxyImpl(this._value);

  final Customer _value;

  @override
  Customer name(String name) => this(name: name);

  @override
  Customer id(String? id) => this(id: id);

  @override
  Customer socialsName(String? socialsName) => this(socialsName: socialsName);

  @override
  Customer orderTotalAmount(double orderTotalAmount) =>
      this(orderTotalAmount: orderTotalAmount);

  @override
  Customer commissionTotalAmount(double commissionTotalAmount) =>
      this(commissionTotalAmount: commissionTotalAmount);

  @override
  Customer orderQuantity(int orderQuantity) =>
      this(orderQuantity: orderQuantity);

  @override
  Customer sponsorshipQuantity(int sponsorshipQuantity) =>
      this(sponsorshipQuantity: sponsorshipQuantity);

  @override
  Customer lastOrderDate(DateTime? lastOrderDate) =>
      this(lastOrderDate: lastOrderDate);

  @override
  Customer firstOrderDate(DateTime? firstOrderDate) =>
      this(firstOrderDate: firstOrderDate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Customer(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Customer(...).copyWith(id: 12, name: "My name")
  /// ````
  Customer call({
    Object? name = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? socialsName = const $CopyWithPlaceholder(),
    Object? orderTotalAmount = const $CopyWithPlaceholder(),
    Object? commissionTotalAmount = const $CopyWithPlaceholder(),
    Object? orderQuantity = const $CopyWithPlaceholder(),
    Object? sponsorshipQuantity = const $CopyWithPlaceholder(),
    Object? lastOrderDate = const $CopyWithPlaceholder(),
    Object? firstOrderDate = const $CopyWithPlaceholder(),
  }) {
    return Customer(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
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

extension $CustomerCopyWith on Customer {
  /// Returns a callable class that can be used as follows: `instanceOfCustomer.copyWith(...)` or like so:`instanceOfCustomer.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomerCWProxy get copyWith => _$CustomerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      name: json['name'] as String,
      id: json['id'] as String?,
      socialsName: json['socialsName'] as String?,
      orderTotalAmount: (json['orderTotalAmount'] as num?)?.toDouble() ?? 0,
      commissionTotalAmount:
          (json['commissionTotalAmount'] as num?)?.toDouble() ?? 0,
      orderQuantity: (json['orderQuantity'] as num?)?.toInt() ?? 0,
      sponsorshipQuantity: (json['sponsorshipQuantity'] as num?)?.toInt() ?? 0,
      lastOrderDate: json['lastOrderDate'] == null
          ? null
          : DateTime.parse(json['lastOrderDate'] as String),
      firstOrderDate: json['firstOrderDate'] == null
          ? null
          : DateTime.parse(json['firstOrderDate'] as String),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'socialsName': instance.socialsName,
      'orderTotalAmount': instance.orderTotalAmount,
      'commissionTotalAmount': instance.commissionTotalAmount,
      'orderQuantity': instance.orderQuantity,
      'sponsorshipQuantity': instance.sponsorshipQuantity,
      'lastOrderDate': instance.lastOrderDate?.toIso8601String(),
      'firstOrderDate': instance.firstOrderDate?.toIso8601String(),
    };
