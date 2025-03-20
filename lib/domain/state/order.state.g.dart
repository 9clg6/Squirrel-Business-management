// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderStateCWProxy {
  OrderState orders(List<Order> orders);

  OrderState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderState(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderState call({
    List<Order>? orders,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderState.copyWith.fieldName(...)`
class _$OrderStateCWProxyImpl implements _$OrderStateCWProxy {
  const _$OrderStateCWProxyImpl(this._value);

  final OrderState _value;

  @override
  OrderState orders(List<Order> orders) => this(orders: orders);

  @override
  OrderState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderState(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderState call({
    Object? orders = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return OrderState(
      orders: orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as List<Order>,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $OrderStateCopyWith on OrderState {
  /// Returns a callable class that can be used as follows: `instanceOfOrderState.copyWith(...)` or like so:`instanceOfOrderState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderStateCWProxy get copyWith => _$OrderStateCWProxyImpl(this);
}
