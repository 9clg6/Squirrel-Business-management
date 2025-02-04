import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/domain/state/order.state.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'index.view_state.g.dart';

///
/// [IndexScreenState]
///
@CopyWith()
class IndexScreenState extends ViewStateAbs {
  /// Loading state
  final bool loading;

  /// Order state
  final OrderState orderState;

  ///
  /// Constructor
  ///
  IndexScreenState(
    this.loading,
    this.orderState,
  );

  ///
  /// Initial state
  ///
  IndexScreenState.initial()
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
