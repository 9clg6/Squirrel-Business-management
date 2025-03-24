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
    // Vérifier si le contexte est déjà sur l'écran principal pour éviter des navigations inutiles
    final BuildContext? context = navigatorKey.currentContext;
    if (context != null) {
      final String currentRoute = GoRouterState.of(context).matchedLocation;
      
      // Si déjà sur la page d'accueil, ne pas naviguer à nouveau
      if (currentRoute == '/main') {
        return;
      }
      
      context.goNamed('main');
    }
  }

  /// Navigate back
  /// @param [OrderAction] result
  ///
  void navigateBack({OrderAction? result}) {
    navigatorKey.currentContext?.pop<OrderAction?>(result);
  }
}
