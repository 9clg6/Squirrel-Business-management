import 'package:flutter/material.dart';
import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/ui/screen/order_details/order_details.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_details.view_model.g.dart';

///
/// [OrderDetailsViewModel]
///
@riverpod
class OrderDetailsViewModel extends _$OrderDetailsViewModel {
  late final OrderService _orderService;

  ///
  /// Constructor
  ///
  factory OrderDetailsViewModel() {
    return OrderDetailsViewModel._();
  }

  ///
  /// Private constructor
  ///
  OrderDetailsViewModel._() {
    _orderService = injector<OrderService>();
  }

  ///
  /// Build
  ///
  @override
  OrderDetailsScreenState build() => OrderDetailsScreenState.initial();

  ///
  /// Init
  ///
  Future<void> init({required Order order}) async {
    _orderService.orderState.addListener(
      () {
        state = state.copyWith(
          order: _orderService.orderState.value.allOrder.firstWhere(
            (e) => e.id == order.id,
          ),
        );
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        order: order,
        loading: false,
      );
    });
  }

  /// Update order status
  ///
  void updateOrderStatus(Order order, OrderStatus currentStatus) {
    _orderService.updateOrderStatus(order, currentStatus);
  }
}
