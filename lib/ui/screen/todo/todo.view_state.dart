import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/domain/state/order.state.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'todo.view_state.g.dart';

///
/// [TodoScreenState]
///
@CopyWith()
class TodoScreenState extends ViewStateAbs {
  /// Loading state
  final bool? loading;

  /// Order state
  final OrderState orderState;

  ///
  /// Constructor
  ///
  TodoScreenState(
    this.loading,
    this.orderState,
  );

  ///
  /// Initial state
  ///
  TodoScreenState.initial()
      : loading = true,
        orderState = OrderState.initial();

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        orderState,
      ];
}
