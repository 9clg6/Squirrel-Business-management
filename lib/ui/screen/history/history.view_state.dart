import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'history.view_state.g.dart';

///
/// [HistoryState]
///
@CopyWith()
class HistoryState extends ViewStateAbs {
  /// Loading state
  final bool? loading;

  /// Orders
  final List<Order> orders;

  ///
  /// Constructor
  ///
  HistoryState({
    required this.loading,
    required this.orders,
  });

  ///
  /// Initial state
  ///
  HistoryState.initial()
      : loading = true,
        orders = <Order>[];

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        orders,
      ];
}
