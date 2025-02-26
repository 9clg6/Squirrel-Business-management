import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'order_details.view_state.g.dart';

/// [OrderDetailsScreenState]
@CopyWith()
class OrderDetailsScreenState extends ViewStateAbs {
  /// Loading state
  final bool loading;

  /// Order
  final Order? order;

  /// Client
  final Client? client;

  /// Constructor
  /// @param [loading] loading state
  /// @param [order] order
  /// @param [client] client
  ///
  OrderDetailsScreenState({
    required this.loading,
    required this.order,
    required this.client,
  });

  /// Initial state
  ///
  OrderDetailsScreenState.initial()
      : loading = true,
        order = null,
        client = null;

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        order,
        client,
      ];
}
