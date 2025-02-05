import 'package:flutter/foundation.dart';
import 'package:init/domain/entities/action.entity.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/domain/state/order.state.dart';
import 'package:init/foundation/enums/headers.enum.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/foundation/enums/priority.enum.dart';

/// [OrderService]
class OrderService {
  /// Order state
  final ValueNotifier<OrderState> orderState;

  /// Public constructor
  ///
  OrderService()
      : orderState = ValueNotifier(
          OrderState.initial().copyWith(
            orders: [
              Order(
                clientContact: 'Jean',
                intermediaryContact: 'Intermediaire 2',
                internalProcessingFee: 35,
                trackId: '1234567890',
                priority: Priority.normal,
                startDate: DateTime(2025, 1, 30),
                estimatedDuration: const Duration(days: 30),
                shopName: 'Amazon',
                price: 1500,
                commissionRatio: .30,
                status: OrderStatus.running,
                technique: 'La Poste',
                actions: [
                  OrderAction(
                    date: DateTime(2025, 2, 5),
                    description: "Envoi du produit",
                  ),
                  OrderAction(
                    date: DateTime(2025, 2, 20),
                    description: "Prise d'information auprès de la boutique",
                  ),
                ],
              ),
              Order(
                clientContact: 'Louis',
                intermediaryContact: 'Intermediaire 1',
                internalProcessingFee: 35,
                trackId: '1234567890',
                priority: Priority.high,
                startDate: DateTime(2025, 1, 31),
                estimatedDuration: const Duration(days: 30),
                shopName: 'Zalando',
                price: 800,
                commissionRatio: .30,
                status: OrderStatus.pending,
                technique: 'La Poste',
                actions: [
                  OrderAction(
                    date: DateTime(2025, 2, 5),
                    description: "Envoi du produit",
                  ),
                  OrderAction(
                    date: DateTime(2025, 2, 10),
                    description: "Prise d'information auprès de la boutique",
                  ),
                  OrderAction(
                    date: DateTime(2025, 2, 20),
                    description: "Prise d'information auprès de la boutique",
                  ),
                ],
              ),
            ],
          ),
        );

  /// Méthode utilitaire pour trouver un ordre et déterminer s'il est épinglé
  (int, bool) _findOrder(Order order) {
    var indexOrder =
        orderState.value.orders.indexWhere((o) => o.id == order.id);
    var isPinned = false;

    if (indexOrder == -1) {
      indexOrder =
          orderState.value.pinnedOrders.indexWhere((o) => o.id == order.id);
      isPinned = true;
    }

    return (indexOrder, isPinned);
  }

  /// Méthode utilitaire pour mettre à jour un ordre
  void _updateOrder(Order updatedOrder, int indexOrder, bool isPinned) {
    if (indexOrder == -1) return;

    if (isPinned) {
      final updatedPinnedOrders =
          List<Order>.from(orderState.value.pinnedOrders)
            ..replaceRange(
              indexOrder,
              indexOrder + 1,
              [updatedOrder],
            );
      orderState.value = orderState.value.copyWith(
        pinnedOrders: updatedPinnedOrders,
      );
    } else {
      final updatedOrders = List<Order>.from(orderState.value.orders)
        ..replaceRange(
          indexOrder,
          indexOrder + 1,
          [updatedOrder],
        );
      orderState.value = orderState.value.copyWith(
        orders: updatedOrders,
      );
    }
  }

  /// Update order status
  void updateOrderStatus(Order order, OrderStatus status) {
    final (indexOrder, isPinned) = _findOrder(order);
    if (indexOrder == -1) return;

    final updatedOrder = order.copyWith(status: status);
    _updateOrder(updatedOrder, indexOrder, isPinned);
  }

  /// Pin order
  void pinOrder(Order order) {
    if (orderState.value.pinnedOrders.contains(order)) {
      unpinOrder(order);
    } else {
      orderState.value = orderState.value.copyWith(
        pinnedOrders: [
          ...orderState.value.pinnedOrders,
          order,
        ],
        orders: [
          ...orderState.value.orders.where((e) => e != order),
        ],
      );
    }
  }

  /// Unpin order
  ///
  void unpinOrder(Order order) {
    orderState.value = orderState.value.copyWith(
      pinnedOrders:
          orderState.value.pinnedOrders.where((e) => e != order).toList(),
      orders: [
        ...orderState.value.orders,
        order,
      ],
    );
  }

  /// Select order
  ///
  void selectOrder(Order? order) {
    if (order == null) return;
    if (orderState.value.showComboBox == false) {
      orderState.value = orderState.value.copyWith(
        showComboBox: true,
      );
    }
    if (orderState.value.selectedOrders.contains(order)) {
      orderState.value = orderState.value.copyWith(
        selectedOrders: [
          ...orderState.value.selectedOrders.where(
            (element) => element != order,
          )
        ],
      );
    } else {
      orderState.value = orderState.value.copyWith(
        selectedOrders: [...orderState.value.selectedOrders, order],
      );
    }
  }

  void selectAll() {
    if (orderState.value.selectedOrders.length ==
        orderState.value.orders.length) {
      unselectOrder();
    } else {
      orderState.value = orderState.value.copyWith(
        selectedOrders: orderState.value.orders,
      );
    }
  }

  ///
  /// Unselect order
  ///
  void unselectOrder() {
    orderState.value = orderState.value.copyWith(
      selectedOrders: [],
    );
  }

  void deleteSelectedOrders() {
    orderState.value = orderState.value.copyWith(
      orders: [
        ...orderState.value.orders.where(
          (e) => !orderState.value.selectedOrders.contains(e),
        ),
      ],
      selectedOrders: [],
    );
  }

  void showComboBox() {
    final newComboBoxState = !orderState.value.showComboBox;
    orderState.value = orderState.value.copyWith(
      showComboBox: newComboBoxState,
    );
    if (!newComboBoxState) {
      orderState.value = orderState.value.copyWith(
        selectedOrders: [],
      );
    }
  }

  /// Sort orders
  ///
  void sortOrders(int columnIndex, bool ascending) {
    final Headers selectedHeader = Headers.values[columnIndex];
    final orders = orderState.value.orders;
    orders.sort((a, b) {
      switch (selectedHeader) {
        case Headers.client:
          return ascending
              ? a.clientContact.compareTo(b.clientContact)
              : b.clientContact.compareTo(a.clientContact);
        case Headers.status:
          return ascending
              ? a.status.index.compareTo(b.status.index)
              : b.status.index.compareTo(a.status.index);
        case Headers.store:
          return ascending
              ? a.shopName.compareTo(b.shopName)
              : b.shopName.compareTo(a.shopName);
        case Headers.startDate:
          return ascending
              ? a.startDate.compareTo(b.startDate)
              : b.startDate.compareTo(a.startDate);
        case Headers.endDate:
          return ascending
              ? a.endDate!.compareTo(b.endDate!)
              : b.endDate!.compareTo(a.endDate!);
        case Headers.price:
          return ascending
              ? a.price.compareTo(b.price)
              : b.price.compareTo(a.price);
        case Headers.commission:
          return ascending
              ? a.commission.compareTo(b.commission)
              : b.commission.compareTo(a.commission);
        default:
          return 0;
      }
    });
    orderState.value = orderState.value.copyWith(
      orders: orders,
      sortColumnIndex: columnIndex,
      sortAscending: ascending,
    );
  }

  /// Update order priority
  /// Cycles through priority values: normal -> high -> urgent -> normal
  void updateOrderPriority(Order order) {
    final nextPriority =
        Priority.values[(order.priority.index + 1) % Priority.values.length];
    final updatedOrder = order.copyWith(
      priority: nextPriority,
    );

    final (indexOrder, isPinned) = _findOrder(order);
    _updateOrder(updatedOrder, indexOrder, isPinned);
  }

  /// Add order action
  ///
  void addOrderAction(Order order, OrderAction orderAction) {
    final (indexOrder, isPinned) = _findOrder(order);
    if (indexOrder == -1) return;

    final updatedOrder = order.copyWith(
      actions: [...order.actions, orderAction],
    );

    _updateOrder(updatedOrder, indexOrder, isPinned);
  }

  /// Delete order action
  ///
  void deleteOrderAction(OrderAction action, Order order) {
    final (indexOrder, isPinned) = _findOrder(order);
    if (indexOrder == -1) return;

    final updatedOrder = order.copyWith(
      actions: order.actions.where((e) => e != action).toList(),
    );

    _updateOrder(updatedOrder, indexOrder, isPinned);
  }

  /// Delete order
  ///
  void deleteOrder(Order order) {
    final (indexOrder, isPinned) = _findOrder(order);
    if (indexOrder == -1) return;

    orderState.value = orderState.value.copyWith(
      orders: [
        ...orderState.value.orders.where((e) => e != order),
      ],
    );
  }
}
