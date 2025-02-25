import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/client.state.dart';
import 'package:squirrel/domain/state/order.state.dart';

/// [ClientService]
class ClientService extends StateNotifier<ClientState> {
  /// Order service
  late final OrderService _orderService;

  /// Client state
  ClientState get clientState => state;

  /// Constructor
  ///
  ClientService(this._orderService) : super(ClientState.initial()) {
    _init();
  }

  /// Init
  ///
  void _init() {
    _mapClientsFromOrders(_orderService.state.allOrder);

    _orderService.addListener((OrderState s) {
      _mapClientsFromOrders(s.allOrder);
    });
  }

  /// Map clients from orders
  /// @param orders: List<Order>
  ///
  void _mapClientsFromOrders(List<Order> orders) {
    final clientsMap =
        _orderService.state.allOrder.fold<Map<String, Map<String, dynamic>>>(
      {},
      (map, order) {
        final clientName = order.clientContact;
        if (!map.containsKey(clientName)) {
          map[clientName] = {
            'totalOrders': 0,
            'totalAmount': 0.0,
            'totalCommissions': 0.0,
          };
        }
        map[clientName]!['totalOrders'] =
            (map[clientName]!['totalOrders'] as int) + 1;
        map[clientName]!['totalAmount'] =
            (map[clientName]!['totalAmount'] as double) + order.price;
        map[clientName]!['totalCommissions'] =
            (map[clientName]!['totalCommissions'] as double) + order.commission;
        return map;
      },
    );

    // Convertir la map en liste de clients
    final clients = clientsMap.entries.map((entry) {
      return Client(
        name: entry.key,
        orderQuantity: entry.value['totalOrders'] as int,
        orderTotalAmount: entry.value['totalAmount'] as double,
        commissionTotalAmount: entry.value['totalCommissions'] as double,
      );
    }).toList();

    state = state.copyWith(clients: clients);
  }
}
