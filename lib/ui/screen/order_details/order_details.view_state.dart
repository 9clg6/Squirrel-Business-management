import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'order_details.view_state.g.dart';

///
/// [OrderDetailsScreenState]
///
@CopyWith()
class OrderDetailsScreenState extends ViewStateAbs {
  /// Loading state
  final bool loading;

  /// Order
  final Order? order;

  ///
  /// Constructor
  ///
  OrderDetailsScreenState({
    required this.loading,
    required this.order,
  });

  ///
  /// Initial state
  ///
  OrderDetailsScreenState.initial()
      : loading = true,
        order = null;

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        order,
      ];
}
