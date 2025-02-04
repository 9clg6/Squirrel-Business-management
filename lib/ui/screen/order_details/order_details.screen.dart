import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/ui/screen/order_details/order_details.view_model.dart';

/// Order details screen
///
class OrderDetailsScreen extends ConsumerStatefulWidget {
  final Order order;

  /// Constructor
  ///
  const OrderDetailsScreen({
    required this.order,
    super.key,
  });

  /// Creates the state for the order details screen
  ///
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderDetailsScreenState();
}

/// State of the order details screen
///
class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  @override
  void initState() {
    ref.read(orderDetailsViewModelProvider.notifier).init(order: widget.order);
    super.initState();
  }

  /// Builds the order details screen
  ///
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderDetailsViewModelProvider);
    if (state.loading == true) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const Scaffold(
      appBar: _OrderDetailAppBar(),
      body: _OrderDetailBody(),
    );
  }
}

/// Body of the order details screen
class _OrderDetailBody extends StatelessWidget {
  /// Constructor
  ///
  const _OrderDetailBody();

  /// Builds the body of the order details screen
  ///
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _OrderDetailHeader(),
          SizedBox(height: 16),
          _OrderDetailsContent(),
        ],
      ),
    );
  }
}

///
///
class _OrderDetailsContent extends ConsumerWidget {
  /// Constructor
  ///
  const _OrderDetailsContent();

  /// Builds the order details content
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(orderDetailsViewModelProvider);
    final order = state.order;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _StatusRow(),
            Divider(
              color: colorScheme.outline.withValues(alpha: .2),
              height: 46,
              thickness: 1,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: .2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Prochaine action",
                    style: textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "21/10/2025",
                    style: textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Recontacter la boutique par mail",
                    style: textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: .2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Priorité",
                          style: textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: order!.priority.color,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "Élevé",
                              style: textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusRow extends ConsumerWidget {
  const _StatusRow();

  static const double _borderRadius = 10;
  static const double _opacity = .2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(orderDetailsViewModelProvider);
    final viewModel = ref.read(orderDetailsViewModelProvider.notifier);
    final order = state.order;

    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: _opacity),
          ),
        ),
        child: Row(
          children: OrderStatus.values.take(4).indexed.map(
            (e) {
              final OrderStatus currentStatus = e.$2;
              final isCurrentStatus = order!.status == currentStatus;
              final isPreviousStatus =
                  e.$1 < OrderStatus.values.indexOf(order.status);

              return Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: InkWell(
                    onTap: () => viewModel.updateOrderStatus(
                      order,
                      currentStatus,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isPreviousStatus
                            ? colorScheme.primary.withValues(alpha: _opacity)
                            : isCurrentStatus
                                ? order.status.color
                                : colorScheme.surface,
                      ),
                      child: Text(e.$2.name),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

/// Stats card
///
class _StatsCard extends ConsumerWidget {
  final String subtitle;
  final String title;

  /// Constructor
  ///
  const _StatsCard({
    required this.subtitle,
    required this.title,
  });

  /// Builds the stats card
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
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

class _OrderDetailHeader extends ConsumerWidget {
  /// Constructor
  ///
  const _OrderDetailHeader();

  /// Builds the order detail header
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _ClientInfoCard(),
          Expanded(
            flex: 5,
            child: _buildStatisticsRow(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatsCard(
          subtitle: "Nombre de commandes",
          title: "3",
        ),
        SizedBox(width: 10),
        _StatsCard(
          subtitle: "Parrainage",
          title: "1",
        ),
        SizedBox(width: 10),
        _StatsCard(
          subtitle: "Montant total",
          title: "1000 €",
        ),
        SizedBox(width: 10),
        _StatsCard(
          subtitle: "Première commande",
          title: "2024-01-01",
        ),
      ],
    );
  }
}

class _ClientInfoCard extends ConsumerWidget {
  /// Constructor
  ///
  const _ClientInfoCard();

  /// Builds the client info card
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(orderDetailsViewModelProvider);
    final order = state.order;

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
          tag: "order-${order?.id}",
          child: Text(order?.clientContact ?? ""),
        ),
        leading: CircleAvatar(
          child: Text(order?.clientContact[0] ?? ""),
        ),
        tileColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
    );
  }
}

class _OrderDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
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
