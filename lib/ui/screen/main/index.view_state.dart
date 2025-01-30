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

  ///
  /// Constructor
  ///
  IndexScreenState(
    this.loading,
    this.orders,
  );

  ///
  /// Initial state
  ///
  IndexScreenState.initial()
      : loading = true,
        orders = [];

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        orders,
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
