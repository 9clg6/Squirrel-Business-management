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
@Riverpod(
  keepAlive: true,
  dependencies: [
    OrderService,
  ],
)
class StatsViewModel extends _$StatsViewModel {
  bool _isInitialized = false;

  /// Dialog service
  late final DialogService _dialogService;

  /// Build
  /// @return [StatsScreenState] state of the stats screen
  ///
  @override
  StatsScreenState build() {
    if (!_isInitialized) {
      _dialogService = injector<DialogService>();
      _isInitialized = true;
    }

    ref.listen(orderServiceProvider, (_, next) {
      updateOrdersListener(next.value!);
    });

    return StatsScreenState.initial(
      ref.watch(orderServiceProvider).value!.orders,
      loading: ref.watch(orderServiceProvider).value!.isLoading,
    );
  }

  /// Update orders
  /// @param [orderState] order state
  ///
  void updateOrdersListener(OrderState orderState) {
    state = state.copyWith(
      orders: orderState.orders,
    );
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
