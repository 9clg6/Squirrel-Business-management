import 'package:flutter/material.dart';
import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/service/dialog.service.dart';
import 'package:init/domain/service/order.service.dart';
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

  /// Constructor
  ///
  factory StatsViewModel() {
    return StatsViewModel._();
  }

  /// Private constructor
  ///
  StatsViewModel._() {
    _orderService = injector<OrderService>();
    _dialogService = injector<DialogService>();
    init();
  }

  /// Build
  ///
  @override
  StatsScreenState build() => StatsScreenState.initial();

  /// Init
  ///
  Future<void> init() async {
    _orderService.orderState.addListener(
      () {
        state = state.copyWith(orders: _orderService.orderState.value.allOrder);
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        loading: false,
        orders: _orderService.orderState.value.allOrder,
      );
    });
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
    final DateTimeRange? result = await _dialogService.selectRangeDate();

    if (result != null) {
      state = state.copyWith(dateRange: result);
    }
  }
}
