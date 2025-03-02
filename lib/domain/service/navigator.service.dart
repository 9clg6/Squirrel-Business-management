import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';

/// Navigator service
class NavigatorService {
  /// Navigator key
  final GlobalKey<NavigatorState> navigatorKey;

  /// Constructor
  /// @param [navigatorKey] navigator key
  ///
  NavigatorService(this.navigatorKey);

  /// Navigate to details
  /// @param [Order] order
  ///
  void navigateToDetails(Order order) {
    navigatorKey.currentContext?.goNamed(
      'order-details',
      pathParameters: {'orderId': order.id},
      extra: order,
    );
  }

  /// Navigate to home
  ///
  Future<void> navigateToHome() async {
    navigatorKey.currentContext?.goNamed('main');
  }

  /// Navigate back
  /// @param [OrderAction] result
  ///
  void navigateBack({OrderAction? result}) {
    navigatorKey.currentContext?.pop<OrderAction?>(result);
  }
}
