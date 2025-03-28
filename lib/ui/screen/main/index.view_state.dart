import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'index.view_state.g.dart';

/// [IndexScreenState]
@CopyWith()
class IndexScreenState extends ViewStateAbs {
  /// Constructor
  /// @param [orders] orders
  /// @param [pinnedOrders] pinned orders
  /// @param [showComboBox] show combo box
  /// @param [selectedOrders] selected orders
  ///
  IndexScreenState(
    this.orders,
    this.pinnedOrders,
    this.selectedOrders,
    this.sortColumnIndex, {
    this.showComboBox = false,
    this.sortAscending = true,
  }) : scrollController = ScrollController();

  /// Initial state
  ///
  IndexScreenState.initial(
    this.orders, {
    this.pinnedOrders = const <Order>[],
    this.showComboBox = false,
    this.sortColumnIndex = 0,
    this.sortAscending = true,
    this.selectedOrders = const <Order>[],
  }) : scrollController = ScrollController();

  /// Orders
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
        scrollController,
      ];
}
