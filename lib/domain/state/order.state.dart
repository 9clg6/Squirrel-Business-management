import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:init/domain/entities/action.entity.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';

part 'order.state.g.dart';

@CopyWith()
class OrderState with EquatableMixin {
  /// Orders
  final List<Order> orders;

  /// Selected orders
  final List<Order> selectedOrders;

  /// Show combo box
  final bool showComboBox;

  /// Pinned orders
  final List<Order> pinnedOrders;

  /// Sort column index
  final int sortColumnIndex;

  /// Sort ascending
  final bool sortAscending;

  OrderState({
    required this.orders,
    required this.selectedOrders,
    required this.showComboBox,
    required this.pinnedOrders,
    required this.sortColumnIndex,
    required this.sortAscending,
  });

  /// Initial state
  OrderState.initial()
      : orders = [],
        selectedOrders = [],
        showComboBox = false,
        pinnedOrders = [],
        sortColumnIndex = 0,
        sortAscending = true;

  /// All orders
  ///
  List<Order> get allOrder => [
        ...orders,
        ...pinnedOrders,
      ];

  /// Get next action date
  ///
  Map<Order, OrderAction?>? get nextAction {
    if (allOrder.isEmpty) return null;

    final now = DateTime.now();

    // Créer une liste de paires ordre/action où l'action est future
    final futureActions = allOrder
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

  @override
  List<Object?> get props => [
        orders,
        selectedOrders,
        showComboBox,
        pinnedOrders,
        sortColumnIndex,
        sortAscending,
        allOrder,
        pinnedOrders,
        selectedOrders,
        showComboBox,
      ];
}
