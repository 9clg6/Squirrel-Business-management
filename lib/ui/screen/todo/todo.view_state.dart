import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'todo.view_state.g.dart';

/// [TodoScreenState]
@CopyWith()
class TodoScreenState extends ViewStateAbs {
  /// Constructor
  /// @param [loading] loading
  /// @param [orders] orders
  ///
  TodoScreenState(
    this.orders, {
    this.loading = true,
  });

  /// Initial state
  /// @param [orders] orders
  ///
  TodoScreenState.initial(
    this.orders, {
    this.loading = true,
  });

  /// Loading
  final bool? loading;

  /// Orders
  final List<Order> orders;

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        orders,
      ];
}
