import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'index.view_state.g.dart';

/// [IndexScreenState]
@CopyWith()
class IndexScreenState extends ViewStateAbs {
  /// Loading state
  final bool loading;

  /// Order state
  final List<Order> orders;

  /// Pinned orders
  final List<Order> pinnedOrders;

  /// Show combo box
  final bool showComboBox;

  /// Scroll controller
  final ScrollController scrollController;

  /// Selected orders
  final List<Order> selectedOrders;

  /// Sort column index
  final int sortColumnIndex;

  /// Sort ascending
  final bool sortAscending;

  /// Next action
  final Map<Order, OrderAction?>? nextAction;

  /// Constructor
  /// @param [loading] loading state
  /// @param [orders] orders
  /// @param [pinnedOrders] pinned orders
  /// @param [showComboBox] show combo box
  /// @param [selectedOrders] selected orders
  ///
  IndexScreenState(
    this.loading,
    this.orders,
    this.pinnedOrders,
    this.showComboBox,
    this.selectedOrders,
    this.sortColumnIndex,
    this.sortAscending,
    this.nextAction,
  ) : scrollController = ScrollController();

  /// Initial state
  ///
  IndexScreenState.initial(
    this.orders,
    this.nextAction, {
    this.loading = true,
  })  : pinnedOrders = <Order>[],
        showComboBox = false,
        sortColumnIndex = 0,
        sortAscending = true,
        selectedOrders = <Order>[],
        scrollController = ScrollController();

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        orders,
        pinnedOrders,
        showComboBox,
        selectedOrders,
        sortColumnIndex,
        sortAscending,
        nextAction,
        scrollController,
      ];
}
