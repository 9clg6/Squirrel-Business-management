// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCWProxy {
  Order id(String? id);

  Order clientContact(String clientContact);

  Order intermediaryContact(String intermediaryContact);

  Order internalProcessingFee(double internalProcessingFee);

  Order trackId(String trackId);

  Order startDate(DateTime startDate);

  Order estimatedDuration(Duration estimatedDuration);

  Order shopName(String shopName);

  Order price(double price);

  Order commissionRatio(double? commissionRatio);

  Order commission(double commission);

  Order status(OrderStatus status);

  Order method(String method);

  Order note(String? note);

  Order actions(List<OrderAction>? actions);

  Order priority(Priority priority);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Order(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ````
  Order call({
    String? id,
    String? clientContact,
    String? intermediaryContact,
    double? internalProcessingFee,
    String? trackId,
    DateTime? startDate,
    Duration? estimatedDuration,
    String? shopName,
    double? price,
    double? commissionRatio,
    double? commission,
    OrderStatus? status,
    String? method,
    String? note,
    List<OrderAction>? actions,
    Priority? priority,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrder.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrder.copyWith.fieldName(...)`
class _$OrderCWProxyImpl implements _$OrderCWProxy {
  const _$OrderCWProxyImpl(this._value);

  final Order _value;

  @override
  Order id(String? id) => this(id: id);

  @override
  Order clientContact(String clientContact) =>
      this(clientContact: clientContact);

  @override
  Order intermediaryContact(String intermediaryContact) =>
      this(intermediaryContact: intermediaryContact);

  @override
  Order internalProcessingFee(double internalProcessingFee) =>
      this(internalProcessingFee: internalProcessingFee);

  @override
  Order trackId(String trackId) => this(trackId: trackId);

  @override
  Order startDate(DateTime startDate) => this(startDate: startDate);

  @override
  Order estimatedDuration(Duration estimatedDuration) =>
      this(estimatedDuration: estimatedDuration);

  @override
  Order shopName(String shopName) => this(shopName: shopName);

  @override
  Order price(double price) => this(price: price);

  @override
  Order commissionRatio(double? commissionRatio) =>
      this(commissionRatio: commissionRatio);

  @override
  Order commission(double commission) => this(commission: commission);

  @override
  Order status(OrderStatus status) => this(status: status);

  @override
  Order method(String method) => this(method: method);

  @override
  Order note(String? note) => this(note: note);

  @override
  Order actions(List<OrderAction>? actions) => this(actions: actions);

  @override
  Order priority(Priority priority) => this(priority: priority);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Order(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Order(...).copyWith(id: 12, name: "My name")
  /// ````
  Order call({
    Object? id = const $CopyWithPlaceholder(),
    Object? clientContact = const $CopyWithPlaceholder(),
    Object? intermediaryContact = const $CopyWithPlaceholder(),
    Object? internalProcessingFee = const $CopyWithPlaceholder(),
    Object? trackId = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? estimatedDuration = const $CopyWithPlaceholder(),
    Object? shopName = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? commissionRatio = const $CopyWithPlaceholder(),
    Object? commission = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? actions = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
  }) {
    return Order(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      clientContact:
          clientContact == const $CopyWithPlaceholder() || clientContact == null
              ? _value.clientContact
              // ignore: cast_nullable_to_non_nullable
              : clientContact as String,
      intermediaryContact:
          intermediaryContact == const $CopyWithPlaceholder() ||
                  intermediaryContact == null
              ? _value.intermediaryContact
              // ignore: cast_nullable_to_non_nullable
              : intermediaryContact as String,
      internalProcessingFee:
          internalProcessingFee == const $CopyWithPlaceholder() ||
                  internalProcessingFee == null
              ? _value.internalProcessingFee
              // ignore: cast_nullable_to_non_nullable
              : internalProcessingFee as double,
      trackId: trackId == const $CopyWithPlaceholder() || trackId == null
          ? _value.trackId
          // ignore: cast_nullable_to_non_nullable
          : trackId as String,
      startDate: startDate == const $CopyWithPlaceholder() || startDate == null
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as DateTime,
      estimatedDuration: estimatedDuration == const $CopyWithPlaceholder() ||
              estimatedDuration == null
          ? _value.estimatedDuration
          // ignore: cast_nullable_to_non_nullable
          : estimatedDuration as Duration,
      shopName: shopName == const $CopyWithPlaceholder() || shopName == null
          ? _value.shopName
          // ignore: cast_nullable_to_non_nullable
          : shopName as String,
      price: price == const $CopyWithPlaceholder() || price == null
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as double,
      commissionRatio: commissionRatio == const $CopyWithPlaceholder()
          ? _value.commissionRatio
          // ignore: cast_nullable_to_non_nullable
          : commissionRatio as double?,
      commission:
          commission == const $CopyWithPlaceholder() || commission == null
              ? _value.commission
              // ignore: cast_nullable_to_non_nullable
              : commission as double,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as OrderStatus,
      method: method == const $CopyWithPlaceholder() || method == null
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as String,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      actions: actions == const $CopyWithPlaceholder()
          ? _value.actions
          // ignore: cast_nullable_to_non_nullable
          : actions as List<OrderAction>?,
      priority: priority == const $CopyWithPlaceholder() || priority == null
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as Priority,
    );
  }
}

extension $OrderCopyWith on Order {
  /// Returns a callable class that can be used as follows: `instanceOfOrder.copyWith(...)` or like so:`instanceOfOrder.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCWProxy get copyWith => _$OrderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String?,
      clientContact: json['clientContact'] as String,
      intermediaryContact: json['intermediaryContact'] as String,
      internalProcessingFee: (json['internalProcessingFee'] as num).toDouble(),
      trackId: json['trackId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      estimatedDuration:
          Duration(microseconds: (json['estimatedDuration'] as num).toInt()),
      shopName: json['shopName'] as String,
      price: (json['price'] as num).toDouble(),
      commissionRatio: (json['commissionRatio'] as num?)?.toDouble(),
      commission: (json['commission'] as num).toDouble(),
      status: OrderStatus.fromJson(json['status'] as String),
      method: json['method'] as String,
      note: json['note'] as String?,
      actions: (json['actions'] as List<dynamic>?)
          ?.map((e) => OrderAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      priority: $enumDecodeNullable(_$PriorityEnumMap, json['priority']) ??
          Priority.normal,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'clientContact': instance.clientContact,
      'intermediaryContact': instance.intermediaryContact,
      'internalProcessingFee': instance.internalProcessingFee,
      'trackId': instance.trackId,
      'startDate': instance.startDate.toIso8601String(),
      'estimatedDuration': instance.estimatedDuration.inMicroseconds,
      'shopName': instance.shopName,
      'price': instance.price,
      'commissionRatio': instance.commissionRatio,
      'commission': instance.commission,
      'status': instance.status,
      'method': instance.method,
      'note': instance.note,
      'priority': _$PriorityEnumMap[instance.priority]!,
      'actions': instance.actions,
    };

const _$PriorityEnumMap = {
  Priority.low: 'low',
  Priority.normal: 'normal',
  Priority.high: 'high',
};
