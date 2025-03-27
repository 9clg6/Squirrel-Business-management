import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/foundation/enums/router.enum.dart';
import 'package:squirrel/foundation/routing/routing_key.dart';

part 'navigator.service.g.dart';

/// Navigator service
@riverpod
class NavigatorService extends _$NavigatorService {
  /// Build
  ///
  @override
  NavigatorService build() {
    return NavigatorService();
  }

  /// Navigate to details
  /// @param [Order] order
  ///
  void navigateToDetails(Order order) {
    routingKey.currentContext?.goNamed(
      RouterEnum.orderDetails.name,
      pathParameters: <String, String>{'orderId': order.id},
      extra: order,
    );
  }

  /// Navigate to home
  ///
  Future<void> navigateToHome() async {
    final BuildContext? context = routingKey.currentContext;
    if (context != null) {
      context.goNamed(RouterEnum.main.name);
    }
  }

  /// Navigate back
  /// @param [OrderAction] result
  ///
  void navigateBack({OrderAction? result}) {
    routingKey.currentContext?.pop<OrderAction?>(result);
  }

  /// Navigate to auth
  ///
  void navigateToAuth() {
    log('🔐 Navigating to auth');
    routingKey.currentContext?.goNamed(RouterEnum.auth.name);
  }
}
