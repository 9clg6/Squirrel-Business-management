import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/enums/headers.enum.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/foundation/enums/priority.enum.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

/// [OrderService]
class OrderService extends StateNotifier<OrderState> {
  /// Hive service
  final StorageInterface hiveService;

  /// Client service
  late final ClientService clientService;

  /// Order state
  OrderState get orderState => state;

  /// Orders key
  static const ordersKey = 'orders';

  /// Public constructor
  /// @param [hiveService] hive service
  ///
  OrderService(
    this.hiveService,
    this.clientService,
  ) : super(OrderState.initial()) {
    _loadOrders();
    _isInitialLoad = true;
    addListener(_save);
  }

  /// Variable to track initial load
  bool _isInitialLoad = false;

  /// Load orders
  ///
  Future<void> _loadOrders() async {
    log('Loading orders');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final String? o = await hiveService.get(ordersKey);
      if (o != null) {
        final orders = jsonDecode(o) as List;
        final ordersList = orders.map((e) => Order.fromJson(e)).toList();
        state = state.copyWith(orders: ordersList);
      }
      _isInitialLoad = false;
    });
  }

  /// Save orders
  /// @param [os] order state
  ///
  void _save(OrderState os) {
    if (_isInitialLoad) return;

    log('Saving orders');
    if (os.orders.isEmpty) return;
    hiveService.set(
      ordersKey,
      jsonEncode(os.orders.map((e) => e.toJson()).toList()),
    );
  }

  /// Method to find an order and determine if it is pinned
  /// @param [order] order
  /// @return [int] index of the order
  /// @return [bool] if the order is pinned
  ///
  (int, bool) _findOrder(Order order) {
    var indexOrder = state.orders.indexWhere((o) => o.id == order.id);
    var isPinned = false;

    if (indexOrder == -1) {
      indexOrder = state.pinnedOrders.indexWhere((o) => o.id == order.id);
      isPinned = true;
    }

    return (indexOrder, isPinned);
  }

  /// Method to update an order
  /// @param [updatedOrder] updated order
  /// @param [indexOrder] index of the order
  /// @param [isPinned] if the order is pinned
  ///
  void _updateOrder(
    Order updatedOrder,
    int indexOrder,
    bool isPinned,
  ) {
    if (indexOrder == -1) return;

    if (isPinned) {
      final updatedPinnedOrders = List<Order>.from(state.pinnedOrders)
        ..replaceRange(
          indexOrder,
          indexOrder + 1,
          [updatedOrder],
        );
      state = state.copyWith(
        pinnedOrders: updatedPinnedOrders,
      );
    } else {
      final updatedOrders = List<Order>.from(state.orders)
        ..replaceRange(
          indexOrder,
          indexOrder + 1,
          [updatedOrder],
        );
      state = state.copyWith(
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
    if (state.pinnedOrders.contains(order)) {
      unpinOrder(order);
    } else {
      state = state.copyWith(
        pinnedOrders: [
          ...state.pinnedOrders,
          order,
        ],
        orders: [
          ...state.orders.where((e) => e != order),
        ],
      );
    }
  }

  /// Unpin order
  ///
  void unpinOrder(Order order) {
    state = state.copyWith(
      pinnedOrders: state.pinnedOrders.where((e) => e != order).toList(),
      orders: [
        ...state.orders,
        order,
      ],
    );
  }

  /// Select order
  ///
  void selectOrder(Order? order) {
    if (order == null) return;
    if (state.showComboBox == false) {
      state = state.copyWith(
        showComboBox: true,
      );
    }
    if (state.selectedOrders.contains(order)) {
      state = state.copyWith(
        selectedOrders: [
          ...state.selectedOrders.where(
            (element) => element != order,
          )
        ],
      );
    } else {
      state = state.copyWith(
        selectedOrders: [...state.selectedOrders, order],
      );
    }
  }

  void selectAll() {
    if (state.selectedOrders.length == state.orders.length) {
      unselectOrder();
    } else {
      state = state.copyWith(
        selectedOrders: state.orders,
      );
    }
  }

  ///
  /// Unselect order
  ///
  void unselectOrder() {
    state = state.copyWith(
      selectedOrders: [],
    );
  }

  void deleteSelectedOrders() {
    state = state.copyWith(
      orders: [
        ...state.orders.where(
          (e) => !state.selectedOrders.contains(e),
        ),
      ],
      selectedOrders: [],
    );
  }

  void showComboBox() {
    final newComboBoxState = !state.showComboBox;
    state = state.copyWith(
      showComboBox: newComboBoxState,
    );
    if (!newComboBoxState) {
      state = state.copyWith(
        selectedOrders: [],
      );
    }
  }

  /// Sort orders
  ///
  void sortOrders(int columnIndex, bool ascending) {
    final Headers selectedHeader = Headers.values[columnIndex];
    final orders = state.orders;
    orders.sort((a, b) {
      switch (selectedHeader) {
        case Headers.client:
          return ascending
              ? a.client!.id.compareTo(b.client!.id)
              : b.client!.id.compareTo(a.client!.id);
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
    state = state.copyWith(
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

    state = state.copyWith(
      orders: [
        ...state.orders.where((e) => e != order),
      ],
    );
  }

  /// Update order
  ///
  void updateOrder(Order order) {
    final (indexOrder, isPinned) = _findOrderById(order.id);
    if (indexOrder == -1) return;

    _updateOrder(
      order,
      indexOrder,
      isPinned,
    );

    clientService.updateClientWithOrder(
      order.client!,
      order: order,
      isNewOrder: false,
    );
  }

  /// Method to find an order by its id
  /// @param [id] id
  /// @return [int] index of the order
  /// @return [bool] if the order is pinned
  ///
  (int, bool) _findOrderById(String id) {
    var indexOrder = state.orders.indexWhere((o) => o.id == id);
    var isPinned = false;

    if (indexOrder == -1) {
      indexOrder = state.pinnedOrders.indexWhere((o) => o.id == id);
      isPinned = true;
    }

    return (indexOrder, isPinned);
  }

  /// Add order
  /// @param [order] order
  ///
  void addOrder(Order order) {
    Client? client;

    final tempClient =
        clientService.getClientByName(order.clientName);

    if (tempClient == null) {
      client = clientService.createClientWithOrder(
        order.clientName,
        order,
      );
    } else {
      client = tempClient;
      clientService.updateClientWithOrder(
        client,
        order: order,
        isNewOrder: true,
      );
    }

    state = state.copyWith(
      orders: [
        ...state.orders,
        order.copyWith(client: client),
      ],
    );
  }
}
