import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/foundation/enums/router.enum.dart';

/// Navigator service
class NavigatorService {
  /// Constructor
  /// @param [navigatorKey] navigator key
  ///
  NavigatorService(this.navigatorKey);

  /// Navigator key
  final GlobalKey<NavigatorState> navigatorKey;

  /// Navigate to details
  /// @param [Order] order
  ///
  void navigateToDetails(Order order) {
    navigatorKey.currentContext?.goNamed(
      RouterEnum.orderDetails.name,
      pathParameters: <String, String>{'orderId': order.id},
      extra: order,
    );
  }

  /// Navigate to home
  ///
  Future<void> navigateToHome() async {
    final BuildContext? context = navigatorKey.currentContext;
    if (context != null) {
      final String currentRoute = GoRouterState.of(context).matchedLocation;

      if (currentRoute == RouterEnum.main.name) {
        return;
      }

      context.goNamed(RouterEnum.main.name);
    }
  }

  /// Navigate back
  /// @param [OrderAction] result
  ///
  void navigateBack({OrderAction? result}) {
    navigatorKey.currentContext?.pop<OrderAction?>(result);
  }
}
