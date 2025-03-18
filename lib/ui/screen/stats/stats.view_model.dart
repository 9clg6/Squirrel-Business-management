import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/enums/chart_type.enum.dart';
import 'package:squirrel/ui/screen/stats/stats.view_state.dart';

part 'stats.view_model.g.dart';

/// [StatsViewModel]
@riverpod
class StatsViewModel extends _$StatsViewModel {
  /// Order service
  late final OrderService _orderService;

  /// Dialog service
  late final DialogService _dialogService;

  /// Constructor
  /// @param [_orderService] order service
  /// @param [_dialogService] dialog service
  ///
  StatsViewModel._(
    this._orderService,
    this._dialogService,
  ) {
    _init();
    _orderService.addListener(updateOrdersListener);
  }

  /// Update orders
  ///
  void updateOrdersListener(OrderState state) {
    state = state.copyWith(orders: state.allOrder);
  }

  /// Factory
  ///
  factory StatsViewModel() => StatsViewModel._(
        injector<OrderService>(),
        injector<DialogService>(),
      );

  /// Build
  /// @return [StatsScreenState] state of the stats screen
  ///
  @override
  StatsScreenState build() {
    return StatsScreenState.initial();
  }

  /// Initialize
  ///
  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        orders: _orderService.orderState.allOrder,
        loading: false,
      );
    });
  }

  /// Change hovered shop
  /// @param [key] key
  ///
  void changeHoveredShop([String? key]) {
    state = state.copyWith(hoveredShop: key);
  }

  /// Change date range
  /// @return [Future<void>] future void
  ///
  Future<void> changeDateRange() async {
    // Afficher le sélecteur de dates
    final List<DateTime?>? result = await _dialogService.selectRangeDate();

    if (result == null || result.length < 2) return;

    state = state.copyWith(
      dateRange: DateTimeRange(
        start: result[0]!,
        end: result[1]!,
      ),
    );
  }

  /// Set revenue type
  /// @param [revenueType] revenue type
  ///
  void setRevenueType(ChartType revenueType) {
    if (revenueType == state.chartType) {
      state = state.copyWith(chartType: ChartType.orderAmount);
    } else {
      state = state.copyWith(chartType: revenueType);
    }
  }
}
