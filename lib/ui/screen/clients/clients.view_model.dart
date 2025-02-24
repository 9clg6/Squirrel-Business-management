import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/ui/screen/clients/clients.view_state.dart';

part 'clients.view_model.g.dart';

///
/// [Clients]
///
@riverpod
class Clients extends _$Clients {
  ///
  /// Client service
  ///
  final OrderService _orderService;

  ///
  /// Private constructor
  ///
  Clients() : _orderService = injector<OrderService>();

  ///
  /// Build
  ///
  @override
  ClientsScreenState build() => ClientsScreenState.initial().copyWith(
        loading: false,
        clients: _orderService.orderState.allOrder
            .fold<Map<String, Map<String, dynamic>>>(
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
      ),
    );

  ///
  /// Init
  ///
  Future<void> init() async {}

  ///
  /// Select client
  ///
  void selectClient(String key) {
    state = state.copyWith(selectedClient: key);
  }
}
