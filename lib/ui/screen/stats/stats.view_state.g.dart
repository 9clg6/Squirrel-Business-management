// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StatsScreenStateCWProxy {
  StatsScreenState loading(bool loading);

  StatsScreenState orders(List<Order> orders);

  StatsScreenState hoveredShop(String? hoveredShop);

  StatsScreenState dateRange(DateTimeRange dateRange);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StatsScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StatsScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  StatsScreenState call({
    bool? loading,
    List<Order>? orders,
    String? hoveredShop,
    DateTimeRange? dateRange,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStatsScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStatsScreenState.copyWith.fieldName(...)`
class _$StatsScreenStateCWProxyImpl implements _$StatsScreenStateCWProxy {
  const _$StatsScreenStateCWProxyImpl(this._value);

  final StatsScreenState _value;

  @override
  StatsScreenState loading(bool loading) => this(loading: loading);

  @override
  StatsScreenState orders(List<Order> orders) => this(orders: orders);

  @override
  StatsScreenState hoveredShop(String? hoveredShop) =>
      this(hoveredShop: hoveredShop);

  @override
  StatsScreenState dateRange(DateTimeRange dateRange) =>
      this(dateRange: dateRange);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StatsScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StatsScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  StatsScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
    Object? hoveredShop = const $CopyWithPlaceholder(),
    Object? dateRange = const $CopyWithPlaceholder(),
  }) {
    return StatsScreenState(
      loading == const $CopyWithPlaceholder() || loading == null
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool,
      orders == const $CopyWithPlaceholder() || orders == null
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as List<Order>,
      hoveredShop == const $CopyWithPlaceholder()
          ? _value.hoveredShop
          // ignore: cast_nullable_to_non_nullable
          : hoveredShop as String?,
      dateRange == const $CopyWithPlaceholder() || dateRange == null
          ? _value.dateRange
          // ignore: cast_nullable_to_non_nullable
          : dateRange as DateTimeRange,
    );
  }
}

extension $StatsScreenStateCopyWith on StatsScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfStatsScreenState.copyWith(...)` or like so:`instanceOfStatsScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StatsScreenStateCWProxy get copyWith => _$StatsScreenStateCWProxyImpl(this);
}
