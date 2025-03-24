import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';

part 'order.state.g.dart';

/// [OrderState]
@CopyWith()
class OrderState with EquatableMixin {
  /// Orders
  final List<Order> orders;

  /// Is loading
  final bool isLoading;

  OrderState({
    required this.orders,
    required this.isLoading,
  });

  /// Initial state
  OrderState.initial({
    required this.orders,
    required this.isLoading,
  });

  /// Get props
  /// @return [List<Object?>] props
  ///
  @override
  List<Object?> get props => [
        orders,
        isLoading,
      ];
}

extension OrderStateX on OrderState {
  /// Ended orders
  /// @return [List<Order>] ended orders
  ///
  List<Order> get endedOrders => orders
      .where((order) => [
            OrderStatus.finished,
            OrderStatus.canceled,
            OrderStatus.failed,
          ].contains(order.status))
      .toList();

  /// Running orders
  /// @return [List<Order>] running orders
  ///
  List<Order> get runningOrder => orders
      .where((order) => ![
            OrderStatus.canceled,
            OrderStatus.failed,
            OrderStatus.finished,
          ].contains(order.status))
      .toList();

  /// Get next action date
  ///
  Map<Order, OrderAction?>? get nextAction {
    if (orders.isEmpty) return null;

    final now = DateTime.now();

    // Créer une liste de paires ordre/action où l'action est future
    final futureActions = orders
        .where((o) => ![
              OrderStatus.failed,
              OrderStatus.finished,
              OrderStatus.canceled,
            ].contains(o.status))
        .map((order) {
      final nextAction = order.actions
          .where((action) => action.date.isAfter(now))
          .toList()
        ..sort((a, b) => a.date.compareTo(b.date));

      return MapEntry(order, nextAction.firstOrNull);
    }).where((entry) => entry.value != null);

    // Si aucune action future n'est trouvée
    if (futureActions.isEmpty) return null;

    // Retourner l'ordre avec l'action la plus proche
    return Map.fromEntries([
      futureActions
          .reduce((a, b) => a.value!.date.compareTo(b.value!.date) <= 0 ? a : b)
    ]);
  }
}
