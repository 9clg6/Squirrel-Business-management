import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/provider/service_type_service.provider.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/screen/order_details/order_details.view_model.dart';
import 'package:squirrel/ui/screen/order_details/order_details.view_state.dart';
import 'package:squirrel/ui/widgets/help_text.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Order details screen
///
class OrderDetailsScreen extends ConsumerStatefulWidget {
  /// Order
  final Order order;

  /// Constructor
  /// @param [order] order
  /// @param [key] key
  ///
  const OrderDetailsScreen({
    required this.order,
    super.key,
  });

  /// Creates the state for the order details screen
  /// @return [ConsumerState] state
  ///
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderDetailsScreenState();
}

/// State of the order details screen
class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  /// Initializes the order details screen
  ///
  @override
  void initState() {
    ref.read(orderDetailsViewModelProvider.notifier).init(
          o: widget.order,
        );
    super.initState();
  }

  /// Builds the order details screen
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(orderDetailsViewModelProvider);

    if (state.loading == true) {
      return Scaffold(
        backgroundColor: colorScheme.surfaceDim,
        body: Center(
          child: CircularProgressIndicator(
            color: colorScheme.primary,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      appBar: const _OrderDetailAppBar(),
      body: const _OrderDetailBody(),
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
  /// @param [context] context
  /// @return [Widget] widget
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
  /// Constructor
  ///
  const _OrderQuickDetails();

  /// Builds the order quick details
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final state = ref.watch(orderDetailsViewModelProvider);
    final businessState = ref.watch(businessTypeServiceNotifierProvider);
    final order = state.order;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextVariant(
                businessState.isService
                    ? LocaleKeys.shop.tr()
                    : LocaleKeys.product.tr(),
                variantType: TextVariantType.bodyMedium,
                fontSize: 12,
              ),
              TextVariant(
                order!.shopName,
                variantType: TextVariantType.titleLarge,
                fontSize: 16,
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
              TextVariant(
                LocaleKeys.orderAmount.tr(),
                variantType: TextVariantType.bodyMedium,
                fontSize: 12,
              ),
              TextVariant(
                LocaleKeys.priceWithSymbol.tr(
                  args: [
                    order.price.toString(),
                  ],
                ),
                variantType: TextVariantType.titleLarge,
                fontSize: 16,
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
              TextVariant(
                LocaleKeys.commission.tr(),
                variantType: TextVariantType.bodyMedium,
                fontSize: 12,
              ),
              TextVariant(
                LocaleKeys.priceWithSymbol.tr(
                  args: [
                    order.commission.toString(),
                  ],
                ),
                variantType: TextVariantType.titleLarge,
                fontSize: 16,
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
              TextVariant(
                LocaleKeys.margin.tr(),
                variantType: TextVariantType.bodyMedium,
                fontSize: 12,
              ),
              TextVariant(
                LocaleKeys.priceWithSymbol.tr(
                  args: [
                    (order.commission - order.internalProcessingFee).toString(),
                  ],
                ),
                variantType: TextVariantType.titleLarge,
                fontSize: 16,
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
          label: TextVariant(
            LocaleKeys.editOrder.tr(),
            variantType: TextVariantType.bodyMedium,
            fontSize: 12,
          ),
          icon: Icon(
            Icons.edit,
            color: colorScheme.onSurface,
          ),
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
          label: TextVariant(
            LocaleKeys.deleteOrder.tr(),
            variantType: TextVariantType.bodyMedium,
            fontSize: 12,
          ),
          icon: Icon(
            Icons.delete_outline,
            color: colorScheme.onSurface,
          ),
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
          onPressed: viewModel.markAsFailed,
          label: const TextVariant(
            "Marquer comme échouée",
            variantType: TextVariantType.bodyMedium,
            fontSize: 12,
          ),
          icon: Icon(
            Icons.error_outline,
            color: colorScheme.onSurface,
          ),
          style: FilledButton.styleFrom(
            side: BorderSide(
              color: colorScheme.outline.withValues(alpha: .2),
              width: 1,
            ),
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
            overlayColor: colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: colorScheme.surface,
              ),
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
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
    final OrderDetailsViewModel viewModel =
        ref.read(orderDetailsViewModelProvider.notifier);
    final OrderDetailsScreenState state =
        ref.watch(orderDetailsViewModelProvider);
    final Order? order = state.order;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextVariant(
                  LocaleKeys.actionsHistory.tr(),
                  variantType: TextVariantType.labelLarge,
                  fontWeight: FontWeight.w400,
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
                  label: TextVariant(
                    LocaleKeys.addOrderAction.tr(),
                    variantType: TextVariantType.bodyMedium,
                    fontSize: 12,
                  ),
                  icon: Icon(
                    Icons.add,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            HelpText(
              text: LocaleKeys.addOrderActionFuture.tr(
                args: [
                  DateTime.now().add(const Duration(days: 2)).toDDMMYYYY(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (order?.actions.isEmpty == true)
          TextVariant(
            LocaleKeys.noOrderAction.tr(),
            variantType: TextVariantType.labelLarge,
            fontWeight: FontWeight.w400,
            color: colorScheme.outline.withValues(alpha: .7),
            fontSize: 12,
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
                                    color: isFirst
                                        ? colorScheme.tertiary
                                        : colorScheme.primary
                                            .withValues(alpha: .6),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                            ? LocaleKeys.daysSinceLastAction
                                                .tr()
                                            : "",
                                        child: TextVariant(
                                          dayDiffBetweenActions != null
                                              ? LocaleKeys.daysDiffWithSymbol
                                                  .tr(
                                                  args: [
                                                    dayDiffBetweenActions
                                                        .toString()
                                                  ],
                                                )
                                              : "",
                                          variantType:
                                              TextVariantType.bodySmall,
                                          fontWeight: FontWeight.w400,
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
    final businessTypeState = ref.watch(businessTypeServiceNotifierProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextVariant(
            LocaleKeys.informations.tr(),
            variantType: TextVariantType.labelLarge,
            fontWeight: FontWeight.w400,
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
                  LocaleKeys.orderDate.tr(),
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
                  LocaleKeys.trackingNumber.tr(),
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
                  LocaleKeys.endOfFile.tr(),
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
                  LocaleKeys.method.tr(),
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
                  businessTypeState.isService
                      ? LocaleKeys.shop.tr()
                      : LocaleKeys.product.tr(),
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(order.shopName),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SelectableText(
                  LocaleKeys.intermediary.tr(),
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
                  LocaleKeys.fees.tr(),
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: SelectableText(
                  LocaleKeys.priceWithSymbol.tr(
                    args: [
                      order.internalProcessingFee.toString(),
                    ],
                  ),
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
    final state = ref.watch(orderDetailsViewModelProvider);
    final order = state.order;
    final viewModel = ref.read(orderDetailsViewModelProvider.notifier);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextVariant(
                    LocaleKeys.nextAction.tr(),
                    variantType: TextVariantType.labelSmall,
                    fontWeight: FontWeight.w400,
                  ),
                  const Gap(4),
                  TextVariant(
                    state.order!.nextActionDate?.toDDMMYYYY() ??
                        LocaleKeys.noNextAction.tr(),
                    variantType: TextVariantType.headlineMedium,
                  ),
                  const Gap(16),
                  TextVariant(
                    state.order!.nextAction?.description ??
                        LocaleKeys.noNextAction.tr(),
                    variantType: TextVariantType.bodyMedium,
                    fontWeight: FontWeight.w400,
                  ),
                  const Gap(16),
                  InkWell(
                    onTap: () => viewModel.updateOrderPriority(order),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                        verticalOffset: 50,
                        message: LocaleKeys.clickToChangePriority.tr(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: colorScheme.outline.withValues(alpha: .2),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextVariant(
                                LocaleKeys.priority.tr(),
                                variantType: TextVariantType.bodyLarge,
                                fontWeight: FontWeight.w400,
                              ),
                              const Gap(16),
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
                                  TextVariant(
                                    order.priority.name,
                                    variantType: TextVariantType.bodyMedium,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(16),
                  HelpText(
                    text: LocaleKeys.clickToChangePriority.tr(),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 75,
              child: VerticalDivider(
                color: colorScheme.outline.withValues(alpha: .2),
                thickness: 1,
                width: 60,
              ),
            ),
            const Expanded(
              flex: 3,
              child: _ActionsHistory(),
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
                                ? colorScheme.outline
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
        HelpText(
          text: LocaleKeys.clickToChangeStatus.tr(),
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
          subtitle: TextVariant(
            subtitle,
            variantType: TextVariantType.bodyMedium,
          ),
          title: TextVariant(
            title,
            variantType: TextVariantType.titleLarge,
          ),
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final OrderDetailsScreenState state =
        ref.watch(orderDetailsViewModelProvider);
    final Order? order = state.order;

    if (order == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _ClientInfoCard(),
          Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatsCard(
                    subtitle: LocaleKeys.numberOfOrders.tr(),
                    title: state.client?.orderQuantity.toString() ?? "",
                  ),
                  const SizedBox(width: 10),
                  _StatsCard(
                    subtitle: LocaleKeys.sponsorship.tr(),
                    title: state.client?.sponsorshipQuantity.toString() ?? "",
                  ),
                  const SizedBox(width: 10),
                  _StatsCard(
                    subtitle: LocaleKeys.totalAmount.tr(),
                    title: state.client?.orderTotalAmount.toString() ?? "",
                  ),
                  const SizedBox(width: 10),
                  _StatsCard(
                    subtitle: LocaleKeys.firstOrder.tr(),
                    title: state.client?.firstOrderDate?.toDDMMYYYY() ?? "",
                  ),
                ],
              )),
        ],
      ),
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
        subtitle: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextVariant(
                order?.client?.name ?? "",
                variantType: TextVariantType.bodyMedium,
              ),
            ],
          ),
        ),
        title: Hero(
          tag: "order-${order?.id}",
          child: TextVariant(
            order?.client?.name ?? "",
            variantType: TextVariantType.bodyMedium,
          ),
        ),
        leading: CircleAvatar(
          child: TextVariant(
            order?.client?.name[0] ?? "",
            variantType: TextVariantType.bodyMedium,
          ),
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
      title: TextVariant(
        LocaleKeys.orderDetails.tr(),
        variantType: TextVariantType.titleMedium,
      ),
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
                TextVariant(
                  LocaleKeys.backToDashboard.tr(),
                  variantType: TextVariantType.bodyMedium,
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
