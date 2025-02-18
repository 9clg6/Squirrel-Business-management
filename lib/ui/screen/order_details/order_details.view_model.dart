import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/entities/action.entity.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/domain/service/dialog.service.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/ui/screen/order_details/order_details.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_details.view_model.g.dart';

/// [OrderDetailsViewModel]
@riverpod
class OrderDetailsViewModel extends _$OrderDetailsViewModel {
  /// Order service
  late final OrderService _orderService;

  /// Dialog service
  late final DialogService _dialogService;

  /// Constructor
  ///
  factory OrderDetailsViewModel() {
    return OrderDetailsViewModel._();
  }

  /// Private constructor
  ///
  OrderDetailsViewModel._() {
    _orderService = injector<OrderService>();
    _dialogService = injector<DialogService>();
  }

  /// Build
  ///
  @override
  OrderDetailsScreenState build() => OrderDetailsScreenState.initial();

  ///
  /// Init
  ///
  Future<void> init({required Order o}) async {
    _orderService.addListener((s) {
      final order = s.allOrder.firstWhereOrNull(
        (e) => e.id == o.id,
      );
      if (order == null) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        state = state.copyWith(order: order);
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        loading: false,
        order: o,
      );
    });
  }

  /// Update order status
  ///
  void updateOrderStatus(Order order, OrderStatus currentStatus) {
    _orderService.updateOrderStatus(order, currentStatus);
  }

  /// Update order priority
  ///
  void updateOrderPriority(Order order) {
    _orderService.updateOrderPriority(order);
  }

  /// Add order action
  ///
  Future<void> addOrderAction() async {
    final OrderAction? orderAction =
        await _dialogService.showAddOrderActionDialog();
    if (orderAction != null) {
      _orderService.addOrderAction(
        state.order!,
        orderAction,
      );
    }
  }

  /// Delete order action
  ///
  void deleteOrderAction(OrderAction action) {
    _orderService.deleteOrderAction(
      action,
      state.order!,
    );
  }

  /// Delete order
  ///
  void deleteOrder() {
    _dialogService.showConfirmationDialog(
      "Supprimer la commande",
      "Voulez-vous vraiment supprimer la commande ?\nCette action est irréversible.",
      () {
        _orderService.deleteOrder(state.order!);
      },
    );
  }

  /// Edit order
  ///
  Future<void> editOrder() async {
    final Order? order =
        await _dialogService.showEditOrderDialog(order: state.order!);
    if (order != null) {
      _orderService.updateOrder(order);
    }
  }
}
