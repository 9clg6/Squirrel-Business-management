import 'dart:convert';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
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
    ClientService,
  ],
)
class OrderService extends _$OrderService {
  /// Hive service
  late final StorageInterface<dynamic> _hiveService;

  /// Client service
  late final ClientService _clientService;

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
      log('🔌 Initializing OrderService');
      _hiveService = ref.watch(hiveSecureStorageServiceProvider.notifier);
      _clientService = ref.watch(clientServiceProvider.notifier);
      _isInitialized = true;
    }
    return _loadOrders();
  }

  /// Load orders
  /// @return [Future<OrderState>] order state
  ///
  Future<OrderState> _loadOrders() async {
    log('[OrderService] Loading orders');

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
      log('[OrderService] Error loading orders: $e');
      return OrderState.initial(
        orders: <Order>[],
        isLoading: false,
      );
    }
  }

  /// Save orders
  /// @param [os] order state
  /// @return [void] void
  ///
  void _save(OrderState os) {
    log('[OrderService] Saving orders');
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
    log('findOrder');
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

    log('[OrderService] Updated orders');

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
      log('[OrderService] Order not found: ${order.id}');
      return;
    }

    if (order.status == status) {
      log('[OrderService] Same status, no update needed');
      return; // Éviter les mises à jour inutiles
    }

    log('[OrderService] Updating status: ${order.status.name}'
        ' -> ${status.name} for order ${order.shopName}');
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
    log('[OrderService] Updated priority: ${nextPriority.name}');

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

    log('[OrderService] Added action: ${orderAction.date}');

    _updateOrder(updatedOrder, indexOrder);
  }

  /// Delete order action
  /// @param [action] action
  /// @param [order] order
  ///
  void deleteOrderAction(OrderAction action, Order order) {
    final int indexOrder = _findOrder(order);
    if (indexOrder == -1) {
      log('[OrderService] Order not found: ${order.id}');
      return;
    }

    final Order updatedOrder = order.copyWith(
      actions: order.actions.where((OrderAction e) => e != action).toList(),
    );

    log('[OrderService] Deleted action: ${action.date}');

    _updateOrder(updatedOrder, indexOrder);
  }

  /// Delete order
  /// @param [order] order
  ///
  void deleteOrder(Order order) {
    final int indexOrder = _findOrder(order);
    if (indexOrder == -1) {
      log('[OrderService] Order not found: ${order.id}');
      return;
    }

    log('[OrderService] Deleted order: ${order.shopName}');

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
      log('[OrderService] Order not found: ${order.id}');
      return;
    }

    // Récupérer le client correspondant au clientName, ou utiliser
    // celui déjà présent
    Client? clientToUse;

    // Si le nom du client a changé, chercher le nouveau client par son nom
    if (order.client == null || order.client!.name != order.clientName) {
      clientToUse = _clientService.getClientByName(order.clientName);

      // Si aucun client avec ce nom n'existe, en créer un nouveau
      if (clientToUse == null) {
        clientToUse = _clientService.createClientWithOrder(
          order.clientName,
          order,
        );
        log('[OrderService] Created new client: ${clientToUse.name}');
      } else {
        log('[OrderService] Found existing client: ${clientToUse.name}');
      }
    } else {
      // Utiliser le client actuel, mais s'assurer d'avoir sa
      // version la plus récente
      clientToUse = _clientService.getClientById(order.client!.id);
    }

    // Mettre à jour la commande avec le client associé
    final Order orderWithUpdatedClient = order.copyWith(
      client: clientToUse,
    );

    _updateOrder(
      orderWithUpdatedClient,
      indexOrder,
    );

    log('[OrderService] Updated order for'
        ' client: ${orderWithUpdatedClient.clientName}');

    // Mettre à jour les statistiques du client
    _clientService.updateClientWithOrder(
      clientToUse,
      order: orderWithUpdatedClient,
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
      log('[OrderService] Order not found: $id');
    }
    return index;
  }

  /// Add order
  /// @param [order] order
  ///
  void addOrder(Order order) {
    Client? client = _clientService.getClientByName(order.clientName);

    if (client == null) {
      client = _clientService.createClientWithOrder(
        order.clientName,
        order,
      );
      log('[OrderService] Created client: ${client.name}');
    } else {
      log('[OrderService] Using existing client: ${client.name}');
    }

    _clientService.updateClientWithOrder(
      client,
      order: order,
      isNewOrder: true,
    );
    log('[OrderService] Updated client: ${client.name}');
    log('[OrderService] Added order: ${order.shopName}');

    state = AsyncData<OrderState>(
      state.value!.copyWith(
        orders: <Order>[
          ...state.value!.orders,
          order.copyWith(client: client),
        ],
      ),
    );

    // Assurez-vous de sauvegarder les ordres après l'ajout
    _save(state.value!);
  }
}
