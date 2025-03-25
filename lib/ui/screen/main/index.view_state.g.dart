// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IndexScreenStateCWProxy {
  IndexScreenState orders(List<Order> orders);

  IndexScreenState pinnedOrders(List<Order> pinnedOrders);

  IndexScreenState selectedOrders(List<Order> selectedOrders);

  IndexScreenState sortColumnIndex(int sortColumnIndex);

  IndexScreenState nextAction(Map<Order, OrderAction?>? nextAction);

  IndexScreenState showComboBox(bool showComboBox);

  IndexScreenState sortAscending(bool sortAscending);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IndexScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IndexScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  IndexScreenState call({
    List<Order>? orders,
    List<Order>? pinnedOrders,
    List<Order>? selectedOrders,
    int? sortColumnIndex,
    Map<Order, OrderAction?>? nextAction,
    bool? showComboBox,
    bool? sortAscending,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfIndexScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfIndexScreenState.copyWith.fieldName(...)`
class _$IndexScreenStateCWProxyImpl implements _$IndexScreenStateCWProxy {
  const _$IndexScreenStateCWProxyImpl(this._value);

  final IndexScreenState _value;

  @override
  IndexScreenState orders(List<Order> orders) => this(orders: orders);

  @override
  IndexScreenState pinnedOrders(List<Order> pinnedOrders) =>
      this(pinnedOrders: pinnedOrders);

  @override
  IndexScreenState selectedOrders(List<Order> selectedOrders) =>
      this(selectedOrders: selectedOrders);

  @override
  IndexScreenState sortColumnIndex(int sortColumnIndex) =>
      this(sortColumnIndex: sortColumnIndex);

  @override
  IndexScreenState nextAction(Map<Order, OrderAction?>? nextAction) =>
      this(nextAction: nextAction);

  @override
  IndexScreenState showComboBox(bool showComboBox) =>
      this(showComboBox: showComboBox);

  @override
  IndexScreenState sortAscending(bool sortAscending) =>
      this(sortAscending: sortAscending);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IndexScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IndexScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  IndexScreenState call({
    Object? orders = const $CopyWithPlaceholder(),
    Object? pinnedOrders = const $CopyWithPlaceholder(),
    Object? selectedOrders = const $CopyWithPlaceholder(),
    Object? sortColumnIndex = const $CopyWithPlaceholder(),
    Object? nextAction = const $CopyWithPlaceholder(),
    Object? showComboBox = const $CopyWithPlaceholder(),
    Object? sortAscending = const $CopyWithPlaceholder(),
  }) {
    return IndexScreenState(
      orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as List<Order>,
      pinnedOrders == const $CopyWithPlaceholder() || pinnedOrders == null
          ? _value.pinnedOrders
          // ignore: cast_nullable_to_non_nullable
          : pinnedOrders as List<Order>,
      selectedOrders == const $CopyWithPlaceholder() || selectedOrders == null
          ? _value.selectedOrders
          // ignore: cast_nullable_to_non_nullable
          : selectedOrders as List<Order>,
      sortColumnIndex == const $CopyWithPlaceholder() || sortColumnIndex == null
          ? _value.sortColumnIndex
          // ignore: cast_nullable_to_non_nullable
          : sortColumnIndex as int,
      nextAction == const $CopyWithPlaceholder()
          ? _value.nextAction
          // ignore: cast_nullable_to_non_nullable
          : nextAction as Map<Order, OrderAction?>?,
      showComboBox:
          showComboBox == const $CopyWithPlaceholder() || showComboBox == null
              ? _value.showComboBox
              // ignore: cast_nullable_to_non_nullable
              : showComboBox as bool,
      sortAscending:
          sortAscending == const $CopyWithPlaceholder() || sortAscending == null
              ? _value.sortAscending
              // ignore: cast_nullable_to_non_nullable
              : sortAscending as bool,
    );
  }
}

extension $IndexScreenStateCopyWith on IndexScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfIndexScreenState.copyWith(...)` or like so:`instanceOfIndexScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IndexScreenStateCWProxy get copyWith => _$IndexScreenStateCWProxyImpl(this);
}
