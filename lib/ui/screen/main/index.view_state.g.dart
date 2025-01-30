// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IndexScreenStateCWProxy {
  IndexScreenState loading(bool loading);

  IndexScreenState orders(List<Order> orders);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IndexScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IndexScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  IndexScreenState call({
    bool? loading,
    List<Order>? orders,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfIndexScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfIndexScreenState.copyWith.fieldName(...)`
class _$IndexScreenStateCWProxyImpl implements _$IndexScreenStateCWProxy {
  const _$IndexScreenStateCWProxyImpl(this._value);

  final IndexScreenState _value;

  @override
  IndexScreenState loading(bool loading) => this(loading: loading);

  @override
  IndexScreenState orders(List<Order> orders) => this(orders: orders);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IndexScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IndexScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  IndexScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
  }) {
    return IndexScreenState(
      loading == const $CopyWithPlaceholder() || loading == null
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool,
      orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as List<Order>,
    );
  }
}

extension $IndexScreenStateCopyWith on IndexScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfIndexScreenState.copyWith(...)` or like so:`instanceOfIndexScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IndexScreenStateCWProxy get copyWith => _$IndexScreenStateCWProxyImpl(this);
}
