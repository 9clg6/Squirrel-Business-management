import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:init/domain/entities/order.entity.dart';

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
  DateTime? get nextActionDate {
    if (allOrder.isEmpty) return null;

    final sortedOrders = List<Order>.from(allOrder)
      ..sort((a, b) => a.startDate.compareTo(b.startDate));

    return sortedOrders.first.startDate;
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
