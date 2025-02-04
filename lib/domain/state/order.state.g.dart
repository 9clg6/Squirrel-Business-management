// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderStateCWProxy {
  OrderState orders(List<Order> orders);

  OrderState selectedOrders(List<Order> selectedOrders);

  OrderState showComboBox(bool showComboBox);

  OrderState pinnedOrders(List<Order> pinnedOrders);

  OrderState sortColumnIndex(int sortColumnIndex);

  OrderState sortAscending(bool sortAscending);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderState(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderState call({
    List<Order>? orders,
    List<Order>? selectedOrders,
    bool? showComboBox,
    List<Order>? pinnedOrders,
    int? sortColumnIndex,
    bool? sortAscending,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderState.copyWith.fieldName(...)`
class _$OrderStateCWProxyImpl implements _$OrderStateCWProxy {
  const _$OrderStateCWProxyImpl(this._value);

  final OrderState _value;

  @override
  OrderState orders(List<Order> orders) => this(orders: orders);

  @override
  OrderState selectedOrders(List<Order> selectedOrders) =>
      this(selectedOrders: selectedOrders);

  @override
  OrderState showComboBox(bool showComboBox) =>
      this(showComboBox: showComboBox);

  @override
  OrderState pinnedOrders(List<Order> pinnedOrders) =>
      this(pinnedOrders: pinnedOrders);

  @override
  OrderState sortColumnIndex(int sortColumnIndex) =>
      this(sortColumnIndex: sortColumnIndex);

  @override
  OrderState sortAscending(bool sortAscending) =>
      this(sortAscending: sortAscending);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderState(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderState call({
    Object? orders = const $CopyWithPlaceholder(),
    Object? selectedOrders = const $CopyWithPlaceholder(),
    Object? showComboBox = const $CopyWithPlaceholder(),
    Object? pinnedOrders = const $CopyWithPlaceholder(),
    Object? sortColumnIndex = const $CopyWithPlaceholder(),
    Object? sortAscending = const $CopyWithPlaceholder(),
  }) {
    return OrderState(
      orders: orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as List<Order>,
      selectedOrders: selectedOrders == const $CopyWithPlaceholder() ||
              selectedOrders == null
          ? _value.selectedOrders
          // ignore: cast_nullable_to_non_nullable
          : selectedOrders as List<Order>,
      showComboBox:
          showComboBox == const $CopyWithPlaceholder() || showComboBox == null
              ? _value.showComboBox
              // ignore: cast_nullable_to_non_nullable
              : showComboBox as bool,
      pinnedOrders:
          pinnedOrders == const $CopyWithPlaceholder() || pinnedOrders == null
              ? _value.pinnedOrders
              // ignore: cast_nullable_to_non_nullable
              : pinnedOrders as List<Order>,
      sortColumnIndex: sortColumnIndex == const $CopyWithPlaceholder() ||
              sortColumnIndex == null
          ? _value.sortColumnIndex
          // ignore: cast_nullable_to_non_nullable
          : sortColumnIndex as int,
      sortAscending:
          sortAscending == const $CopyWithPlaceholder() || sortAscending == null
              ? _value.sortAscending
              // ignore: cast_nullable_to_non_nullable
              : sortAscending as bool,
    );
  }
}

extension $OrderStateCopyWith on OrderState {
  /// Returns a callable class that can be used as follows: `instanceOfOrderState.copyWith(...)` or like so:`instanceOfOrderState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderStateCWProxy get copyWith => _$OrderStateCWProxyImpl(this);
}
