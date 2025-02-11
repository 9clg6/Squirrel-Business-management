import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/foundation/extensions/date_time.extension.dart';
import 'package:init/ui/screen/order_details/order_details.view_model.dart';
import 'package:init/ui/screen/order_details/order_details.view_state.dart';
import 'package:init/ui/widgets/help_text.dart';

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
    ref.read(orderDetailsViewModelProvider.notifier).init(o: widget.order);
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
///
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
          _OrderActionsRow(),
          SizedBox(height: 16),
          _OrderDetailHeader(),
          SizedBox(height: 16),
          _OrderQuickDetails(),
          SizedBox(height: 16),
          _OrderDetailsContent(),
        ],
      ),
    );
  }
}

/// Order quick details
///
class _OrderQuickDetails extends ConsumerWidget {
  const _OrderQuickDetails();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final state = ref.watch(orderDetailsViewModelProvider);
    final order = state.order;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Boutique",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              Text(
                order!.shopName,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          VerticalDivider(
            color: colorScheme.outline,
            width: 1,
            thickness: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Montant de la commande",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              Text(
                "${order.price} €",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          VerticalDivider(
            color: colorScheme.outline,
            width: 1,
            thickness: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Commission",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              Text(
                "${order.commission} €",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          VerticalDivider(
            color: colorScheme.outline,
            width: 1,
            thickness: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Marge",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              Text(
                "${order.commission - order.internalProcessingFee} €",
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Order actions row
///
class _OrderActionsRow extends ConsumerWidget {
  const _OrderActionsRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = ref.read(orderDetailsViewModelProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FilledButton.icon(
          onPressed: viewModel.editOrder,
          label: const Text(
            "Editer la commande",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          icon: const Icon(Icons.edit),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(width: 10),
        FilledButton.icon(
          onPressed: viewModel.deleteOrder,
          label: const Text(
            "Supprimer la commande",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
          icon: const Icon(Icons.delete_outline),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

///
///
class _OrderDetailsContent extends StatelessWidget {
  /// Constructor
  ///
  const _OrderDetailsContent();

  /// Builds the order details content
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            const _SummaryOrder(),
            const SizedBox(height: 16),
            const _ActionsHistory(),
            const SizedBox(height: 16),
            const _OrderInformations(),
          ],
        ),
      ),
    );
  }
}

class _ActionsHistory extends ConsumerWidget {
  const _ActionsHistory();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final OrderDetailsViewModel viewModel =
        ref.read(orderDetailsViewModelProvider.notifier);
    final OrderDetailsScreenState state =
        ref.watch(orderDetailsViewModelProvider);
    final Order? order = state.order;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Historique des actions réalisées",
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 16),
                  FilledButton.icon(
                    onPressed: viewModel.addOrderAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    label: const Text(
                      "Ajouter une action",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    icon: Icon(
                      Icons.add,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              HelpText(
                text:
                    "Pour ajouter une action future il suffit d'ajouter une action avec une date supérieur à celle d'aujourd'hui. Par exemple ${DateTime.now().add(
                          const Duration(days: 2),
                        ).toDDMMYYYY()}",
              ),
            ],
          ),
          const SizedBox(height: 4),
          if (order?.actions.isEmpty == true)
            Text(
              "Aucune action n'a été effectuée",
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: colorScheme.outline.withValues(alpha: .7),
                fontSize: 12,
              ),
            )
          else ...[
            Divider(
              color: colorScheme.outline.withValues(alpha: .2),
              height: 46,
              thickness: 1,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Container(
                    width: 2,
                    height: (order!.actions.length * 48.0),
                    color: colorScheme.primary,
                  ),
                ),
                Column(
                  children: order.actions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final action = entry.value;
                    final isFirst = index == 0;
                    int? dayDiffBetweenActions;

                    // Calculer la différence pour toutes les actions sauf la dernière (la plus récente)
                    if (index < order.actions.length - 1) {
                      final nextDate = order.actions[index + 1].date;
                      dayDiffBetweenActions =
                          action.date.difference(nextDate).inDays;
                    }

                    return SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorScheme.primary
                                          .withValues(alpha: isFirst ? 1 : .6),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(action.date.toDDMMYYYY()),
                                      ),
                                      Expanded(
                                        child: Text(
                                          action.description,
                                        ),
                                      ),
                                      Expanded(
                                        child: Tooltip(
                                          message: dayDiffBetweenActions != null
                                              ? "Jours depuis la dernière action"
                                              : "",
                                          child: Text(
                                            dayDiffBetweenActions != null
                                                ? "+$dayDiffBetweenActions jours"
                                                : "",
                                            style:
                                                textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: IconButton(
                              onPressed: () {
                                viewModel.deleteOrderAction(action);
                              },
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _OrderInformations extends ConsumerWidget {
  const _OrderInformations();

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
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Informations",
            style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
          Divider(
            color: colorScheme.outline.withValues(alpha: .2),
            height: 46,
            thickness: 1,
          ),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  "Date de commande",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(
                  order!.startDate.toDDMMYYYY(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  "Numéro de suivi",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(
                  order.trackId,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  "Fin de dossier prévue",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(
                  order.endDate!.toDDMMYYYY(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  "Méthode",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(
                  order.method,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  "Boutique",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(
                  order.shopName,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  "Intermédiaire",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(
                  order.intermediaryContact,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  "Frais",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(
                  "${order.internalProcessingFee} €",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryOrder extends ConsumerWidget {
  const _SummaryOrder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(orderDetailsViewModelProvider);
    final order = state.order;
    final viewModel = ref.read(orderDetailsViewModelProvider.notifier);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
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
            style: textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            state.order!.nextActionDate?.toDDMMYYYY() ?? 'Aucune action prévue',
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Recontacter la boutique par mail",
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => viewModel.updateOrderPriority(order),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Tooltip(
                verticalOffset: 50,
                message: "Cliquez pour changer la priorité",
                child: Container(
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
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            order.priority.name,
                            style: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const HelpText(
            text:
                "Pour changer la priorité de la commande, veuillez cliquer sur le bouton ci-dessus",
          ),
        ],
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

    return Column(
      children: [
        ClipRRect(
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
                                ? colorScheme.primary
                                    .withValues(alpha: _opacity)
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
        ),
        const SizedBox(height: 16),
        const HelpText(
          text:
              "Pour changer le statut de la commande, veuillez cliquer sur le statut souhaité",
        ),
      ],
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
      scrolledUnderElevation: 0,
      leadingWidth: 220,
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      title: const Text("Détails de la commande"),
      leading: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: context.pop,
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 10),
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
