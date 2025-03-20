import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/foundation/enums/chart_type.enum.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

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

  /// Chart type
  final ChartType chartType;

  /// Y interval
  double get yInterval => switch (chartType) {
        ChartType.dailyRevenue => 500,
        ChartType.orderAmount => 1,
      };

  /// Max Y
  double get maxY => dataToShow.values.isNotEmpty
      ? dataToShow.values
              .reduce((max, value) => max > value ? max : value)
              .toDouble() +
          yInterval
      : 5;

  /// Total
  double get total => orders.fold(0, (sum, order) => sum + order.price.toInt());

  /// Data to show
  Map<DateTime, int> get dataToShow => switch (chartType) {
        ChartType.dailyRevenue => dailyRevenue,
        ChartType.orderAmount => ordersQuantityByDate,
      };

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

  /// Orders amount by date
  Map<DateTime, int> get dailyRevenue {
    // Initialiser une map pour stocker les montants par date
    final Map<DateTime, int> amountsMap = {};

    // Ajouter les montants pour les dates dans la plage
    for (final order in orders) {
      final orderDate = order.startDate.getDateWithoutTime();

      if (orderDate.isBefore(dateRange.start) ||
          orderDate.isAfter(dateRange.end)) {
        continue;
      }

      amountsMap.update(
        orderDate,
        (value) => (value + order.price).toInt(),
        ifAbsent: () => order.price.toInt(),
      );
    }

    return amountsMap;
  }

  /// Orders quantity by date
  Map<DateTime, int> get ordersQuantityByDate {
    // Initialiser une map pour stocker les commandes par date
    final Map<DateTime, int> ordersMap = {};

    // Fonction pour ajouter une commande à la map
    void addOrderToMap(DateTime date) {
      ordersMap.update(
        date,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    // Ajouter les commandes pour les dates dans la plage
    for (final order in orders) {
      final orderDate = order.startDate.getDateWithoutTime();
      if (orderDate.isBefore(dateRange.start) ||
          orderDate.isAfter(dateRange.end)) {
        continue;
      }
      addOrderToMap(orderDate);
    }

    return ordersMap;
  }

  /// Constructor
  /// @param [loading] loading
  /// @param [orders] orders
  /// @param [hoveredShop] hovered shop
  /// @param [dateRange] date range
  /// @param [chartType] chart type
  ///
  StatsScreenState({
    required this.loading,
    required this.orders,
    required this.hoveredShop,
    required this.dateRange,
    required this.chartType,
  });

  /// Initial state
  ///
  StatsScreenState.initial(
    this.orders, {
    this.loading = true,
  })  : hoveredShop = null,
        dateRange = DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 5)),
          end: DateTime.now(),
        ),
        chartType = ChartType.orderAmount;

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        orders,
        hoveredShop,
        dateRange,
        chartType,
        yInterval,
        maxY,
        total,
        dataToShow,
        totalByShop,
        dailyRevenue,
        ordersQuantityByDate,
      ];
}
