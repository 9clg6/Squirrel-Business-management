import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'stats.view_state.g.dart';

///
/// [StatsScreenState]
///
@CopyWith()
class StatsScreenState extends ViewStateAbs {
  /// Loading state
  final bool loading;

  /// Orders
  final List<Order> orders;

  /// Hovered shop
  final String? hoveredShop;

  /// Date range
  final DateTimeRange dateRange;

  /// Total
  double get total => orders.fold(0, (sum, order) => sum + order.price.toInt());

  /// Total by shop
  Map<String, double> get totalByShop => orders.fold<Map<String, double>>(
        {},
        (map, order) => map
          ..update(
            order.shopName,
            (value) => value + order.price,
            ifAbsent: () => order.price,
          ),
      );

  ///
  /// Constructor
  ///
  StatsScreenState(
    this.loading,
    this.orders,
    this.hoveredShop,
    this.dateRange,
  );

  ///
  /// Initial state
  ///
  StatsScreenState.initial()
      : loading = true,
        orders = [],
        hoveredShop = null,
        dateRange = DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 15)),
          end: DateTime.now(),
        );

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        orders,
        hoveredShop,
        dateRange,
      ];
}
