import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'index.view_state.g.dart';

/// [IndexScreenState]
@CopyWith()
class IndexScreenState extends ViewStateAbs {
  final List<Order> orders;
  final List<Order> pinnedOrders;
  final bool showComboBox;
  final ScrollController scrollController;
  final List<Order> selectedOrders;
  final int sortColumnIndex;
  final bool sortAscending;
  final Map<Order, OrderAction?>? nextAction;

  /// Constructor
  /// @param [orders] orders
  /// @param [pinnedOrders] pinned orders
  /// @param [showComboBox] show combo box
  /// @param [selectedOrders] selected orders
  ///
  IndexScreenState(
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
    this.pinnedOrders = const <Order>[],
    this.showComboBox = false,
    this.sortColumnIndex = 0,
    this.sortAscending = true,
    this.selectedOrders = const <Order>[],
  }) : scrollController = ScrollController();

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
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
