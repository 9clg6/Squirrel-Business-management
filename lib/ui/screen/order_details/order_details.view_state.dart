import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'order_details.view_state.g.dart';

/// [OrderDetailsScreenState]
@CopyWith()
class OrderDetailsScreenState extends ViewStateAbs {
  /// Order
  final Order? order;

  /// Constructor
  /// @param [order] order
  ///
  OrderDetailsScreenState({
    required this.order,
  });

  /// Initial state
  /// @param [order] order
  ///
  OrderDetailsScreenState.initial({
    required this.order,
  });

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        order,
      ];
}
