import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:init/domain/entities/order.entity.dart';

/// Order details screen
class OrderDetailsScreen extends ConsumerStatefulWidget {
  /// Constructor
  const OrderDetailsScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderDetailsScreenState();
}

///
/// State of the order details screen
///
class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  ///
  /// Builds the order details screen
  ///
  @override
  Widget build(BuildContext context) {
    final Order order = GoRouterState.of(context).extra! as Order;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Hero(
        tag: 'order-${order.id}',
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return SingleChildScrollView(
            child: fromHeroContext.widget,
          );
        },
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Order #${order.id}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
