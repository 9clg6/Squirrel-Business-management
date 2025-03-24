import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/enums/headers.enum.dart';
import 'package:squirrel/ui/screen/main/index.view_state.dart';

part 'index.view_model.g.dart';

///
/// [Index]
///
@Riverpod(
  keepAlive: true,
)
class Index extends _$Index {
  bool _isInitialized = false;
  late final OrderService _orderService;
  late final NavigatorService _navigatorService;
  late final DialogService _dialogService;

  /// Build
  ///
  @override
  IndexScreenState build() {
    /// QUEL ORDRE
    /// EVITER INJECTOR ET GARDER REF
    if (!_isInitialized) {
      _navigatorService = injector<NavigatorService>();
      _dialogService = injector<DialogService>();

      _orderService = ref.watch(orderServiceProvider.notifier);

      _isInitialized = true;
    }
    final state = ref.watch(orderServiceProvider);

    /// OU METTRE CA
    ref.listen(orderServiceProvider, (_, next) {
      log('Index listen');
      _updateState(next.value!);
    });

    log('Index build state: $state');
    return IndexScreenState.initial(
      state.value!.orders,
      state.value!.nextAction,
      loading: false,
    );
  }

  /// Pin order
  /// @param [order] order
  ///
  void pinOrder(Order order) {
    if (state.pinnedOrders.contains(order)) {
      unpinOrder(order);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        state = state.copyWith(
          pinnedOrders: [
            ...state.pinnedOrders,
            order,
          ],
          orders: [
            ...state.orders.where((e) => e != order),
          ],
        );
      });
    }
  }

  /// Unpin order
  /// @param [order] order
  ///
  void unpinOrder(Order order) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        pinnedOrders: state.pinnedOrders.where((e) => e != order).toList(),
        orders: [
          ...state.orders,
          order,
        ],
      );
    });
  }

  /// Select order
  /// @param [order] order
  ///
  void selectOrder(Order? order) {
    if (order == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    });
  }

  /// Select all orders
  ///
  void selectAll() {
    if (state.selectedOrders.length == state.orders.length) {
      unselectOrder();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        state = state.copyWith(
          selectedOrders: state.orders,
        );
      });
    }
  }

  /// Unselect order
  ///
  void unselectOrder() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        selectedOrders: [],
      );
    });
  }

  /// Delete selected orders
  ///
  void deleteSelectedOrders() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        orders: [
          ...state.orders.where(
            (e) => !state.selectedOrders.contains(e),
          ),
        ],
        selectedOrders: [],
      );
    });
  }

  /// Show combo box
  ///
  void showComboBox() {
    final bool newComboBoxState = !state.showComboBox;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        showComboBox: newComboBoxState,
        selectedOrders: newComboBoxState == false ? [] : state.selectedOrders,
      );
    });
  }

  /// Sort orders
  /// @param [columnIndex] column index
  /// @param [ascending] ascending
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        orders: orders,
        sortColumnIndex: columnIndex,
        sortAscending: ascending,
      );
    });
  }

  /// Navigate to details
  /// @param [order] order
  ///
  void navigateToDetails(Order order) {
    _navigatorService.navigateToDetails(order);
  }

  /// Create order
  ///
  Future<void> createOrder() async {
    final Order? order = await _dialogService.showEditOrderDialog(
      order: Order.empty(),
      isCreation: true,
    );

    if (order != null) {
      _orderService.addOrder(order);
    }
  }

  /// Update state
  /// @param [state] state
  ///
  void _updateState(OrderState s) {
    log('[Index] Updating state');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = state.copyWith(
        orders: s.orders,
        nextAction: s.nextAction,
        loading: s.isLoading,
      );
    });
  }
}
