import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/screen/order_details/order_details.view_state.dart';

part 'order_details.view_model.g.dart';

/// [OrderDetailsViewModel]
@Riverpod(
  keepAlive: true,
  dependencies: <Object>[
    OrderService,
    ClientService,
  ],
)
class OrderDetailsViewModel extends _$OrderDetailsViewModel {
  late final OrderService _orderService;
  late final ClientService _clientService;
  late final DialogService _dialogService;
  bool _isInitialized = false;

  /// Build
  /// @param [o] order
  /// @return [OrderDetailsScreenState] order details screen state
  ///
  @override
  OrderDetailsScreenState build(Order o) {
    if (!_isInitialized) {
      _orderService = ref.watch(orderServiceProvider.notifier);
      _clientService = ref.watch(clientServiceProvider.notifier);
      _dialogService = ref.watch(dialogServiceProvider.notifier);
      _isInitialized = true;
    }

    ref.listen(orderServiceProvider, (_, AsyncValue<OrderState> next) {
      if (!_isInitialized) return;
      final Order? order = next.value!.orders.firstWhereOrNull(
        (Order e) => e.id == o.id,
      );
      if (order == null) return;

      state = state.copyWith(order: order);
    });

    return OrderDetailsScreenState.initial(order: o);
  }

  /// Get client by id
  /// @param [id] id
  /// @return [Client] client
  ///
  Client getClientById(String id) {
    try {
      return _clientService.getClientById(id);
    } on Exception catch (_) {
      // Si aucun client n'est trouvé, retourner un client par défaut
      return Client(
        name: 'Client inconnu',
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
  /// @return [Future<void>] future void
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
      order: state.order,
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
