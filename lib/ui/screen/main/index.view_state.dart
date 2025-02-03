import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'index.view_state.g.dart';

///
/// [IndexScreenState]
///
@CopyWith()
class IndexScreenState extends ViewStateAbs {
  /// Loading state
  final bool loading;

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

  ///
  /// Constructor
  ///
  IndexScreenState(
    this.loading,
    this.orders,
    this.selectedOrders,
    this.showComboBox,
    this.pinnedOrders,
    this.sortColumnIndex,
    this.sortAscending,
  );

  ///
  /// Initial state
  ///
  IndexScreenState.initial()
      : loading = true,
        orders = [],
        selectedOrders = [],
        showComboBox = false,
        pinnedOrders = [],
        sortColumnIndex = 0,
        sortAscending = true;

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        orders,
        selectedOrders,
        showComboBox,
        pinnedOrders,
        sortColumnIndex,
        sortAscending,
      ];

  ///
  /// Get next action date
  ///
  DateTime? get nextActionDate {
    if (orders.isEmpty) return null;

    final sortedOrders = List<Order>.from(orders)
      ..sort((a, b) => a.startDate.compareTo(b.startDate));
      
    return sortedOrders.first.startDate;
  }
}
