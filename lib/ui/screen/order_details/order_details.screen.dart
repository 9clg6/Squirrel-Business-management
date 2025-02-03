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
      appBar: const _OrderDetailAppBar(),
      body: _OrderDetailBody(order: order),
    );
  }
}

class _OrderDetailBody extends StatelessWidget {
  const _OrderDetailBody({
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildClientInfoCard(colorScheme),
        ],
      ),
    );
  }

  Widget _buildClientInfoCard(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildClientProfile(colorScheme),
          Expanded(
            flex: 5,
            child: _buildStatisticsRow(colorScheme),
          ),
        ],
      ),
    );
  }

  Widget _buildClientProfile(ColorScheme colorScheme) {
    return Expanded(
      child: ListTile(
        subtitle: const SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("@ojfewpo"),
            ],
          ),
        ),
        title: Hero(
          tag: "order-${order.id}",
          child: Text(order.clientContact),
        ),
        leading: CircleAvatar(
          child: Text(order.clientContact[0]),
        ),
        tileColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
    );
  }

  Widget _buildStatisticsRow(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard(
          colorScheme,
          "Nombre de commandes",
          "3",
        ),
        const SizedBox(width: 10),
        _buildStatCard(
          colorScheme,
          "Parrainage",
          "1",
        ),
        const SizedBox(width: 10),
        _buildStatCard(
          colorScheme,
          "Montant total",
          "1000 €",
        ),
        const SizedBox(width: 10),
        _buildStatCard(
          colorScheme,
          "Première commande",
          "2024-01-01",
        ),
      ],
    );
  }

  Widget _buildStatCard(ColorScheme colorScheme, String subtitle, String title) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: .2),
          ),
        ),
        child: ListTile(
          subtitle: Text(subtitle),
          title: Text(title),
        ),
      ),
    );
  }
}

class _OrderDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _OrderDetailAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 220,
      title: const Text("Détails de la commande"),
      leading: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: context.pop,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                const Icon(Icons.arrow_back),
                const SizedBox(width: 10),
                Text(
                  "Retour au dashboard",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
