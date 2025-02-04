import 'package:flutter/foundation.dart';
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
                intermediaryContact: 'Boxer 1',
                internalProcessingFee: 35,
                trackId: '1234567890',
                priority: Priority.normal,
                startDate: DateTime(2025, 1, 30),
                estimatedDuration: const Duration(days: 30),
                shopName: 'Amazon',
                price: 1500,
                commissionRatio: .30,
                status: OrderStatus.pending,
                technique: 'FTID MR QR',
              ),
              Order(
                clientContact: 'Louis',
                intermediaryContact: 'Boxer 2',
                internalProcessingFee: 35,
                trackId: '1234567890',
                priority: Priority.high,
                startDate: DateTime(2025, 1, 31),
                estimatedDuration: const Duration(days: 30),
                shopName: 'Zalando',
                price: 800,
                commissionRatio: .30,
                status: OrderStatus.running,
                technique: 'FTID MR QR',
              ),
            ],
          ),
        );

  /// Update order status
  ///
  void updateOrderStatus(Order order, OrderStatus status) {
    // Recherche par id qui est l'identifiant unique
    var indexOrder = orderState.value.orders.indexWhere((o) => o.id == order.id);
    var isPinned = false;
    
    if (indexOrder == -1) {
      indexOrder = orderState.value.pinnedOrders.indexWhere((o) => o.id == order.id);
      isPinned = true;
    }
    
    if (indexOrder == -1) return;
    
    final Order updatedOrder = order.copyWith(status: status);
    
    if (isPinned) {
      final updatedPinnedOrders = List<Order>.from(orderState.value.pinnedOrders)
        ..replaceRange(indexOrder, indexOrder + 1, [updatedOrder]);
      orderState.value = orderState.value.copyWith(pinnedOrders: updatedPinnedOrders);
    } else {
      final updatedOrders = List<Order>.from(orderState.value.orders)
        ..replaceRange(indexOrder, indexOrder + 1, [updatedOrder]);
      orderState.value = orderState.value.copyWith(orders: updatedOrders);
    }
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
    if (orderState.value.selectedOrders.contains(order)) {
      orderState.value = orderState.value.copyWith(
        selectedOrders: orderState.value.selectedOrders..remove(order),
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
}
