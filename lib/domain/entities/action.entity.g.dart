// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderActionCWProxy {
  OrderAction date(DateTime date);

  OrderAction description(String description);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderAction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderAction(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderAction call({
    DateTime? date,
    String? description,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderAction.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderAction.copyWith.fieldName(...)`
class _$OrderActionCWProxyImpl implements _$OrderActionCWProxy {
  const _$OrderActionCWProxyImpl(this._value);

  final OrderAction _value;

  @override
  OrderAction date(DateTime date) => this(date: date);

  @override
  OrderAction description(String description) => this(description: description);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderAction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderAction(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderAction call({
    Object? date = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return OrderAction(
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
      description:
          description == const $CopyWithPlaceholder() || description == null
              ? _value.description
              // ignore: cast_nullable_to_non_nullable
              : description as String,
    );
  }
}

extension $OrderActionCopyWith on OrderAction {
  /// Returns a callable class that can be used as follows: `instanceOfOrderAction.copyWith(...)` or like so:`instanceOfOrderAction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderActionCWProxy get copyWith => _$OrderActionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAction _$OrderActionFromJson(Map<String, dynamic> json) => OrderAction(
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$OrderActionToJson(OrderAction instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'description': instance.description,
    };
