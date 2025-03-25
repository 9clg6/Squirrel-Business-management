import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';

part 'order.state.g.dart';

/// [OrderState]
@CopyWith()
class OrderState with EquatableMixin {
  /// Constructor
  /// @param [orders] orders
  /// @param [isLoading] is loading
  ///
  OrderState({
    required this.orders,
    required this.isLoading,
  });

  /// Initial state
  /// @param [orders] orders
  /// @param [isLoading] is loading
  ///
  OrderState.initial({
    required this.orders,
    required this.isLoading,
  });

  /// Orders
  final List<Order> orders;

  /// Is loading
  final bool isLoading;

  /// Get props
  /// @return [List<Object?>] props
  ///
  @override
  List<Object?> get props => <Object?>[
        orders,
        isLoading,
      ];
}

/// [OrderStateX]
extension OrderStateX on OrderState {
  /// Ended orders
  /// @return [List<Order>] ended orders
  ///
  List<Order> get endedOrders => orders
      .where(
        (Order order) => <OrderStatus>[
          OrderStatus.finished,
          OrderStatus.canceled,
          OrderStatus.failed,
        ].contains(order.status),
      )
      .toList();

  /// Running orders
  /// @return [List<Order>] running orders
  ///
  List<Order> get runningOrder => orders
      .where(
        (Order order) => !<OrderStatus>[
          OrderStatus.canceled,
          OrderStatus.failed,
          OrderStatus.finished,
        ].contains(order.status),
      )
      .toList();

  /// Get next action date
  ///
  Map<Order, OrderAction?>? get nextAction {
    if (orders.isEmpty) return null;

    final DateTime now = DateTime.now();

    // Créer une liste de paires ordre/action où l'action est future
    final Iterable<MapEntry<Order, OrderAction?>> futureActions = orders
        .where(
      (Order o) => !<OrderStatus>[
        OrderStatus.failed,
        OrderStatus.finished,
        OrderStatus.canceled,
      ].contains(o.status),
    )
        .map((Order order) {
      final List<OrderAction> nextAction = order.actions
          .where((OrderAction action) => action.date.isAfter(now))
          .toList()
        ..sort((OrderAction a, OrderAction b) => a.date.compareTo(b.date));

      return MapEntry<Order, OrderAction?>(
        order,
        nextAction.firstOrNull,
      );
    }).where((MapEntry<Order, OrderAction?> entry) => entry.value != null);

    // Si aucune action future n'est trouvée
    if (futureActions.isEmpty) return null;

    // Retourner l'ordre avec l'action la plus proche
    return Map<Order, OrderAction?>.fromEntries(<MapEntry<Order, OrderAction?>>[
      futureActions.reduce(
        (MapEntry<Order, OrderAction?> a, MapEntry<Order, OrderAction?> b) =>
            a.value!.date.compareTo(b.value!.date) <= 0 ? a : b,
      ),
    ]);
  }
}
