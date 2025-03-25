import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'history.view_state.g.dart';

/// [HistoryState]
@CopyWith()
class HistoryState extends ViewStateAbs {
  /// Constructor
  /// @param [orders] orders
  ///
  HistoryState({
    required this.orders,
  });

  /// Initial state
  /// @param [orders] orders
  ///
  HistoryState.initial(this.orders);

  /// Orders
  final List<Order> orders;

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        orders,
      ];
}
