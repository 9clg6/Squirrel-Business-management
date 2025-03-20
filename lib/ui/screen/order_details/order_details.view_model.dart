import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/screen/order_details/order_details.view_state.dart';

part 'order_details.view_model.g.dart';

/// [OrderDetailsViewModel]
@riverpod
class OrderDetailsViewModel extends _$OrderDetailsViewModel {
  /// Order service
  late final OrderService _orderService;

  /// Client service
  late final ClientService _clientService;

  /// Dialog service
  late final DialogService _dialogService;

  /// Build
  ///
  @override
  OrderDetailsScreenState build() {
    _orderService = ref.read(orderServiceProvider.notifier);
    _clientService = ref.read(clientServiceProvider.notifier);
    _dialogService = injector<DialogService>();

    return OrderDetailsScreenState.initial();
  }

  /// Init
  /// @param [o] order
  ///
  Future<void> init({required Order o}) async {
    ref.listen(orderServiceProvider, (_, next) {
      final order = next.value!.orders.firstWhereOrNull(
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
        client: _clientService.getClientById(o.client!.id),
      );
    });
  }

  /// Get client by id
  /// @param [id] id
  /// @return [Client] client
  ///
  Client getClientById(String id) {
    try {
      return _clientService.getClientById(id);
    } catch (e) {
      // Si aucun client n'est trouvé, retourner un client par défaut
      return Client(
        name: "Client inconnu",
        orderQuantity: 0,
        orderTotalAmount: 0,
        commissionTotalAmount: 0,
      );
    }
  }

  /// Update order status
  /// @param [order] order
  /// @param [currentStatus] current status
  ///
  void updateOrderStatus(Order order, OrderStatus currentStatus) {
    _orderService.updateOrderStatus(order, currentStatus);
  }

  /// Update order priority
  /// @param [order] order
  ///
  void updateOrderPriority(Order order) {
    _orderService.updateOrderPriority(order);
  }

  /// Add order action
  /// @param [order] order
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
  /// @param [action] action
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
      LocaleKeys.deleteOrder.tr(),
      LocaleKeys.deleteOrderConfirmation.tr(),
      () {
        _orderService.deleteOrder(state.order!);
      },
    );
  }

  /// Edit order
  ///
  Future<void> editOrder() async {
    final Order? order = await _dialogService.showEditOrderDialog(
      order: state.order!,
    );

    if (order != null) {
      _orderService.updateOrder(order);
    }
  }

  /// Mark as failed
  ///
  void markAsFailed() {
    _orderService.updateOrderStatus(
      state.order!,
      OrderStatus.failed,
    );
  }
}
