import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/customer.service.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/service/logger.service.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/foundation/enums/priority.enum.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

part 'order.service.g.dart';

/// [OrderService]
@Riverpod(
  keepAlive: true,
  dependencies: <Object>[
    HiveSecureStorageService,
    CustomerService,
  ],
)
class OrderService extends _$OrderService {
  /// Hive service
  late final StorageInterface<dynamic> _hiveService;

  /// customer service
  late final CustomerService _customerService;

  /// Orders key
  static const String ordersKey = 'orders';

  /// Is initialized
  bool _isInitialized = false;

  /// Build
  /// @return [Future<OrderState>] order state
  ///
  @override
  Future<OrderState> build() async {
    if (!_isInitialized) {
      LoggerService.instance.i('🔌 Initializing OrderService');
      _hiveService = ref.watch(hiveSecureStorageServiceProvider.notifier);
      _customerService = ref.watch(customerServiceProvider.notifier);
      _isInitialized = true;
    }
    return _loadOrdersFromLocal();
  }

  /// Load orders
  /// @return [Future<OrderState>] order state
  ///
  Future<OrderState> _loadOrdersFromLocal() async {
    LoggerService.instance.i('📚 Loading orders');

    try {
      final String? o = await _hiveService.get(ordersKey) as String?;
      if (o != null) {
        final List<dynamic> orders = jsonDecode(o) as List<dynamic>;

        final List<Order> ordersList = orders
            .map((dynamic e) => Order.fromJson(e as Map<String, dynamic>))
            .toList();

        return OrderState.initial(
          orders: ordersList,
          isLoading: false,
        );
      } else {
        // Mettre à jour l'état même si aucune donnée n'est chargée
        return OrderState.initial(
          orders: <Order>[],
          isLoading: false,
        );
      }
    } on Exception catch (e) {
      // En cas d'erreur, marquer comme non chargement et journaliser l'erreur
      LoggerService.instance.e('📚❌ Error loading orders: $e');
      return OrderState.initial(
        orders: <Order>[],
        isLoading: false,
      );
    }
  }

  /// Load orders
  /// @param [orders] orders
  /// @return [void] void
  ///
  void loadOrders(List<Order> orders) {
    state = AsyncData<OrderState>(
      state.value!.copyWith(
        orders: orders,
      ),
    );
    _save(state.requireValue);
  }

  /// Save orders
  /// @param [os] order state
  /// @return [void] void
  ///
  void _save(OrderState os) {
    LoggerService.instance.i('📚💾 Saving orders');
    if (os.orders.isEmpty) return;
    _hiveService.set(
      ordersKey,
      jsonEncode(os.orders.map((Order e) => e.toJson()).toList()),
    );
  }

  /// Method to find an order and determine if it is pinned
  /// @param [order] order
  /// @return [int] index of the order
  ///
  int _findOrder(Order order) {
    return state.value!.orders.indexWhere((Order o) => o.id == order.id);
  }

  /// Method to update an order
  /// @param [updatedOrder] updated order
  /// @param [indexOrder] index of the order
  ///
  void _updateOrder(
    Order updatedOrder,
    int indexOrder,
  ) {
    if (indexOrder == -1) return;

    final List<Order> updatedOrders = List<Order>.from(state.value!.orders)
      ..replaceRange(
        indexOrder,
        indexOrder + 1,
        <Order>[updatedOrder],
      );

    LoggerService.instance.i('📚✅ Updated orders');

    state = AsyncData<OrderState>(
      state.value!.copyWith(
        orders: updatedOrders,
      ),
    );

    _save(state.value!);
  }

  /// Update order status
  /// @order order
  /// @status status
  ///
  void updateOrderStatus(Order order, OrderStatus status) {
    final int indexOrder = _findOrder(order);
    if (indexOrder == -1) {
      LoggerService.instance.e('📚❌ Order not found');
      return;
    }

    if (order.status == status) {
      LoggerService.instance.i(
        '📚 Same status, no update needed',
      );
      return;
    }

    LoggerService.instance.i('📚 Updating status');
    final Order updatedOrder = order.copyWith(status: status);

    _updateOrder(updatedOrder, indexOrder);
  }

  /// Update order priority
  /// Cycles through priority values: normal -> high -> urgent -> normal
  /// @param [order] order
  ///
  void updateOrderPriority(Order order) {
    final Priority nextPriority =
        Priority.values[(order.priority.index + 1) % Priority.values.length];

    final Order updatedOrder = order.copyWith(
      priority: nextPriority,
    );
    LoggerService.instance.i('📚✅ Updated priority');

    _updateOrder(
      updatedOrder,
      _findOrder(order),
    );
  }

  /// Add order action
  /// @param [order] order
  /// @param [orderAction] order action
  ///
  void addOrderAction(Order order, OrderAction orderAction) {
    final int indexOrder = _findOrder(order);
    if (indexOrder == -1) return;

    final Order updatedOrder = order.copyWith(
      actions: <OrderAction>[...order.actions, orderAction],
    );

    LoggerService.instance.i('📚✅ Added action');

    _updateOrder(updatedOrder, indexOrder);
  }

  /// Delete order action
  /// @param [action] action
  /// @param [order] order
  ///
  void deleteOrderAction(OrderAction action, Order order) {
    final int indexOrder = _findOrder(order);
    if (indexOrder == -1) {
      LoggerService.instance.e('📚❌ Order not found');
      return;
    }

    final Order updatedOrder = order.copyWith(
      actions: order.actions.where((OrderAction e) => e != action).toList(),
    );

    LoggerService.instance.i('📚✅ Deleted action');

    _updateOrder(updatedOrder, indexOrder);
  }

  /// Delete order
  /// @param [order] order
  ///
  void deleteOrder(Order order) {
    final int indexOrder = _findOrder(order);
    if (indexOrder == -1) {
      LoggerService.instance.e('📚❌ Order not found');
      return;
    }

    LoggerService.instance.i('📚✅ Deleted order');

    state = AsyncData<OrderState>(
      state.value!.copyWith(
        orders: <Order>[
          ...state.value!.orders.where((Order e) => e != order),
        ],
      ),
    );
  }

  /// Update order
  /// @param [order] order
  ///
  void updateOrder(Order order) {
    final int indexOrder = _findOrderById(order.id);
    if (indexOrder == -1) {
      LoggerService.instance.e('📚❌ Order not found');
      return;
    }

    // Récupérer le customer correspondant au customerName, ou utiliser
    // celui déjà présent
    Customer? customerToUse;

    // Si le nom du customer a changé, chercher le nouveau customer par son nom
    if (order.customer == null || order.customer!.name != order.customerName) {
      customerToUse = _customerService.getCustomerByName(order.customerName);

      // Si aucun customer avec ce nom n'existe, en créer un nouveau
      if (customerToUse == null) {
        customerToUse = _customerService.createCustomerWithOrder(
          order.customerName,
          order,
        );
        LoggerService.instance.i('📚✅ Created new customer');
      } else {
        LoggerService.instance.i('📚 Found existing customer');
      }
    } else {
      // Utiliser le customer actuel, mais s'assurer d'avoir sa
      // version la plus récente
      customerToUse = _customerService.getcustomerById(order.customer!.id);
    }

    // Mettre à jour la commande avec le customer associé
    final Order orderWithUpdatedcustomer = order.copyWith(
      customer: customerToUse,
    );

    _updateOrder(
      orderWithUpdatedcustomer,
      indexOrder,
    );

    LoggerService.instance.i('📚✅ Updated order');

    // Mettre à jour les statistiques du customer
    _customerService.updateCustomerWithOrder(
      customerToUse,
      order: orderWithUpdatedcustomer,
      isNewOrder: false,
    );
  }

  /// Method to find an order by its id
  /// @param [id] id
  /// @return [int] index of the order
  /// @return [bool] if the order is pinned
  ///
  int _findOrderById(String id) {
    final int index = state.value!.orders.indexWhere((Order o) => o.id == id);
    if (index == -1) {
      LoggerService.instance.e('📚❌ Order not found');
    }
    return index;
  }

  /// Add order
  /// @param [order] order
  ///
  void addOrder(Order order) {
    Customer? customer = _customerService.getCustomerByName(order.customerName);

    if (customer == null) {
      customer = _customerService.createCustomerWithOrder(
        order.customerName,
        order,
      );
      LoggerService.instance.i('📚✅ Created customer');
    } else {
      LoggerService.instance.i('📚 Found existing customer');
    }

    _customerService.updateCustomerWithOrder(
      customer,
      order: order,
      isNewOrder: true,
    );
    LoggerService.instance.i('📚✅ Updated customer');
    LoggerService.instance.i('📚✅ Added order');

    state = AsyncData<OrderState>(
      state.value!.copyWith(
        orders: <Order>[
          ...state.value!.orders,
          order.copyWith(customer: customer),
        ],
      ),
    );

    // Assurez-vous de sauvegarder les ordres après l'ajout
    _save(state.value!);
  }
}
