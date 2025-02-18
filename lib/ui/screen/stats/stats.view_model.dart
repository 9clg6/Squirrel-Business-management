import 'package:flutter/material.dart';
import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/service/dialog.service.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/foundation/enums/chart_type.enum.dart';
import 'package:init/ui/screen/stats/stats.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stats.view_model.g.dart';

///
/// [StatsViewModel]
///
@riverpod
class StatsViewModel extends _$StatsViewModel {
  /// Order service
  late final OrderService _orderService;

  /// Dialog service
  late final DialogService _dialogService;

  /// Build
  ///
  @override
  StatsScreenState build() {
    _orderService = injector<OrderService>();
    _dialogService = injector<DialogService>();

    state = StatsScreenState.initial().copyWith(
      loading: false,
      orders: _orderService.orderState.allOrder,
    );

    _orderService.addListener((s) {
      state = state.copyWith(orders: s.allOrder);
    });

    return state;
  }

  /// Change hovered shop
  ///
  void changeHoveredShop([String? key]) {
    state = state.copyWith(hoveredShop: key);
  }

  /// Change date range
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

  ///
  /// Set revenue type
  ///
  void setRevenueType(ChartType revenueType) {
    if (revenueType == state.chartType) {
      state = state.copyWith(chartType: ChartType.orderAmount);
    } else {
      state = state.copyWith(chartType: revenueType);
    }
  }
}
