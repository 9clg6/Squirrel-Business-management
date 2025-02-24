import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

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

  final ScrollController scrollController;

  ///
  /// Constructor
  ///
  IndexScreenState(
    this.loading,
    this.orderState,
  ) : scrollController = ScrollController();

  ///
  /// Initial state
  ///
  IndexScreenState.initial()
      : loading = true,
        orderState = OrderState.initial(),
        scrollController = ScrollController();

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        orderState,
        scrollController,
      ];
}
