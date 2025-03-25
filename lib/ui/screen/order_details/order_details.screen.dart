import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/screen/order_details/order_details.view_model.dart';
import 'package:squirrel/ui/screen/order_details/order_details.view_state.dart';
import 'package:squirrel/ui/widgets/help_text.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Order details screen
class OrderDetailsScreen extends ConsumerStatefulWidget {
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
  /// Builds the order details screen
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      appBar: const _OrderDetailAppBar(),
      body: _OrderDetailBody(order: widget.order),
    );
  }
}

/// Body of the order details screen
class _OrderDetailBody extends StatelessWidget {
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _OrderDetailBody({
    required this.order,
  });

  /// Builds the body of the order details screen
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _OrderActionsRow(order),
          const SizedBox(height: 16),
          _OrderDetailHeader(order),
          const SizedBox(height: 16),
          _OrderQuickDetails(order),
          const SizedBox(height: 16),
          _OrderDetailsContent(order),
        ],
      ),
    );
  }
}

/// Order quick details
class _OrderQuickDetails extends ConsumerWidget {
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _OrderQuickDetails(
    this.order,
  );

  /// Builds the order quick details
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final state = ref.watch(orderDetailsViewModelProvider(order));
    final businessState = ref.watch(businessTypeServiceProvider);
    final stateOrder = state.order;

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
          switch (businessState) {
            AsyncData(value: BusinessTypeState()) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextVariant(
                    businessState.value.isService
                        ? LocaleKeys.shop.tr()
                        : LocaleKeys.product.tr(),
                    variantType: TextVariantType.bodyMedium,
                    fontSize: 12,
                  ),
                  TextVariant(
                    stateOrder!.shopName,
                    variantType: TextVariantType.titleLarge,
                    fontSize: 16,
                  ),
                ],
              ),
            _ => const SizedBox.shrink(),
          },
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
                    stateOrder?.price.toString() ?? "",
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
                    stateOrder?.commission.toString() ?? "",
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
                    (stateOrder?.commission ??
                            0 - (stateOrder?.internalProcessingFee ?? 0))
                        .toString(),
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
class _OrderActionsRow extends ConsumerWidget {
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _OrderActionsRow(
    this.order,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = ref.read(orderDetailsViewModelProvider(order).notifier);

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

/// Order details content
class _OrderDetailsContent extends StatelessWidget {
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _OrderDetailsContent(
    this.order,
  );

  /// Builds the order details content
  /// @param [context] context
  /// @return [Widget] widget
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
            _StatusRow(order),
            Divider(
              color: colorScheme.outline.withValues(alpha: .2),
              height: 46,
              thickness: 1,
            ),
            _SummaryOrder(order),
            const SizedBox(height: 16),
            _OrderInformations(order),
          ],
        ),
      ),
    );
  }
}

/// Actions history
class _ActionsHistory extends ConsumerWidget {
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _ActionsHistory(
    this.order,
  );

  /// Builds the actions history
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final OrderDetailsViewModel viewModel =
        ref.read(orderDetailsViewModelProvider(order).notifier);
    final OrderDetailsScreenState state =
        ref.watch(orderDetailsViewModelProvider(order));
    final Order? orderState = state.order;

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
        if (orderState?.actions.isEmpty == true)
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
                  height: (orderState!.actions.length * 48.0),
                  color: colorScheme.primary,
                ),
              ),
              Column(
                children: orderState.actions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final action = entry.value;
                  final isFirst = index == 0;
                  int? dayDiffBetweenActions;

                  // Calculer la différence pour toutes les actions sauf la dernière (la plus récente)
                  if (index < orderState.actions.length - 1) {
                    final nextDate = orderState.actions[index + 1].date;
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

/// Order informations
class _OrderInformations extends ConsumerWidget {
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _OrderInformations(
    this.order,
  );

  /// Builds the order informations
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(orderDetailsViewModelProvider(order));
    final orderState = state.order;
    final businessTypeState = ref.watch(businessTypeServiceProvider);

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
                  orderState!.startDate.toDDMMYYYY(),
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
                  orderState.trackId,
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
                  orderState.endDate!.toDDMMYYYY(),
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
                  orderState.method,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              switch (businessTypeState) {
                AsyncData(value: BusinessTypeState()) => Expanded(
                    child: SelectableText(
                      businessTypeState.value.isService
                          ? LocaleKeys.shop.tr()
                          : LocaleKeys.product.tr(),
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                _ => const SizedBox.shrink(),
              },
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
                  orderState.intermediaryContact,
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
                      orderState.internalProcessingFee.toString(),
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

/// Summary order
class _SummaryOrder extends ConsumerWidget {
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _SummaryOrder(
    this.order,
  );

  /// Builds the summary order
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(orderDetailsViewModelProvider(order));
    final viewModel = ref.read(orderDetailsViewModelProvider(order).notifier);
    final orderState = state.order;

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
                    orderState!.nextActionDate?.toDDMMYYYY() ??
                        LocaleKeys.noNextAction.tr(),
                    variantType: TextVariantType.headlineMedium,
                  ),
                  const Gap(16),
                  TextVariant(
                    orderState.nextAction?.description ??
                        LocaleKeys.noNextAction.tr(),
                    variantType: TextVariantType.bodyMedium,
                    fontWeight: FontWeight.w400,
                  ),
                  const Gap(16),
                  InkWell(
                    onTap: () => viewModel.updateOrderPriority(orderState),
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
                                      color: orderState.priority.color,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  TextVariant(
                                    orderState.priority.name,
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
            Expanded(
              flex: 3,
              child: _ActionsHistory(order),
            ),
          ],
        ),
      ),
    );
  }
}

/// [StatusRow]
class _StatusRow extends ConsumerWidget {
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _StatusRow(
    this.order,
  );

  static const double _borderRadius = 10;
  static const double _opacity = .2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final state = ref.watch(orderDetailsViewModelProvider(order));
    final viewModel = ref.read(orderDetailsViewModelProvider(order).notifier);
    final orderState = state.order;

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
                  final isCurrentStatus = orderState!.status == currentStatus;
                  final isPreviousStatus =
                      e.$1 < OrderStatus.values.indexOf(orderState.status);

                  return Expanded(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: InkWell(
                        onTap: () => viewModel.updateOrderStatus(
                          orderState,
                          currentStatus,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isPreviousStatus
                                ? colorScheme.shadow
                                : isCurrentStatus
                                    ? orderState.status.color
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
class _StatsCard extends ConsumerWidget {
  final String subtitle;
  final String title;

  /// Constructor
  /// @param [subtitle] subtitle
  /// @param [title] title
  ///
  const _StatsCard({
    required this.subtitle,
    required this.title,
  });

  /// Builds the stats card
  /// @param [context] context
  /// @return [Widget] widget
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
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _OrderDetailHeader(
    this.order,
  );

  /// Builds the order detail header
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final OrderDetailsScreenState state =
        ref.watch(orderDetailsViewModelProvider(order));
    final Order? orderState = state.order;

    if (orderState == null) {
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
          _ClientInfoCard(order),
          Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatsCard(
                    subtitle: LocaleKeys.numberOfOrders.tr(),
                    title: orderState.client?.orderQuantity.toString() ?? "",
                  ),
                  const SizedBox(width: 10),
                  _StatsCard(
                    subtitle: LocaleKeys.sponsorship.tr(),
                    title:
                        orderState.client?.sponsorshipQuantity.toString() ?? "",
                  ),
                  const SizedBox(width: 10),
                  _StatsCard(
                    subtitle: LocaleKeys.totalAmount.tr(),
                    title: orderState.client?.orderTotalAmount.toString() ?? "",
                  ),
                  const SizedBox(width: 10),
                  _StatsCard(
                    subtitle: LocaleKeys.firstOrder.tr(),
                    title:
                        orderState.client?.firstOrderDate?.toDDMMYYYY() ?? "",
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class _ClientInfoCard extends ConsumerWidget {
  final Order order;

  /// Constructor
  /// @param [order] order
  ///
  const _ClientInfoCard(
    this.order,
  );

  /// Builds the client info card
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(orderDetailsViewModelProvider(order));
    final orderState = state.order;

    return Expanded(
      child: ListTile(
        subtitle: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextVariant(
                orderState?.client?.name ?? "",
                variantType: TextVariantType.bodyMedium,
              ),
            ],
          ),
        ),
        title: Hero(
          tag: "order-${orderState?.id}",
          child: TextVariant(
            orderState?.client?.name ?? "",
            variantType: TextVariantType.bodyMedium,
          ),
        ),
        leading: CircleAvatar(
          child: TextVariant(
            orderState?.client?.name[0] ?? "",
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
  /// Constructor
  ///
  const _OrderDetailAppBar();

  /// Builds the order detail app bar
  /// @param [context] context
  /// @return [Widget] widget
  ///
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

  /// Gets the preferred size
  /// @return [Size] size
  ///
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
