import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/provider/service_type_service.provider.dart';
import 'package:squirrel/foundation/enums/headers.enum.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/screen/main/index.view_model.dart';
import 'package:squirrel/ui/screen/main/index.view_state.dart';
import 'package:squirrel/ui/widgets/help_text.dart';
import 'package:squirrel/ui/widgets/status_card.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Main screen
class MainScreen extends ConsumerStatefulWidget {
  /// Constructor
  ///
  const MainScreen({super.key});

  /// Creates the state of the main screen
  ///
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

/// State of the main screen
class _MainScreenState extends ConsumerState<MainScreen> {
  /// Builds the main screen
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: const CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _ResumeHeader(),
          _Body(),
        ],
      ),
    );
  }
}

class _PinnedOrders extends ConsumerWidget {
  const _PinnedOrders();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IndexScreenState state = ref.watch(indexProvider);
    final viewModel = ref.read(indexProvider.notifier);
    if (state.orderState.pinnedOrders.isEmpty) return const SizedBox();

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
      ),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 22,
              top: 22,
              bottom: 10,
            ),
            child: TextVariant(
              LocaleKeys.pinnedOrders.tr(),
              variantType: TextVariantType.titleMedium,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: 46,
              border: TableBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              dataTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
              headingTextStyle:
                  Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
              showCheckboxColumn: false,
              horizontalMargin: 12,
              dividerThickness: .5,
              columns: Headers.values
                  .map((e) => DataColumn(
                        label: Text(e.label),
                        numeric: e.isNumeric,
                        headingRowAlignment: MainAxisAlignment.center,
                        onSort: viewModel.sortOrders,
                      ))
                  .toList(),
              rows: state.orderState.pinnedOrders.map((order) {
                return DataRow(
                  onSelectChanged: (_) {
                    viewModel.navigateToDetails(order);
                  },
                  cells: [
                    DataCell(
                      Center(
                        child: Hero(
                          tag: 'order-${order.id}',
                          child: Text(order.clientContact),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: StatusCard(status: order.status),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(order.shopName),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(order.startDate.toDDMMYYYY()),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(order.endDate?.toDDMMYYYY() ?? ""),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          LocaleKeys.priceWithSymbol.tr(
                            args: [
                              order.price.toString(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          LocaleKeys.priceWithSymbol.tr(
                            args: [
                              order.commission.toString(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: IconButton(
                          onPressed: () {
                            viewModel.navigateToDetails(order);
                          },
                          icon: const Icon(Icons.open_in_new),
                          tooltip: LocaleKeys.open.tr(),
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: IconButton(
                          onPressed: () => viewModel.pinOrder(order),
                          icon: Icon(
                            state.orderState.pinnedOrders.contains(order)
                                ? Icons.push_pin
                                : Icons.push_pin_outlined,
                          ),
                          tooltip: LocaleKeys.pin.tr(),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IndexScreenState state = ref.watch(indexProvider);

    if (state.loading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return const SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _PinnedOrders(),
              _OrdersList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrdersList extends ConsumerWidget {
  const _OrdersList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IndexScreenState state = ref.watch(indexProvider);
    final Index viewModel = ref.read(indexProvider.notifier);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final businessTypeState = ref.watch(businessTypeServiceNotifierProvider);
    final businessTypeNotifier =
        ref.read(businessTypeServiceNotifierProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 22,
                    bottom: 10,
                  ),
                  child: TextVariant(
                    LocaleKeys.orders.tr(),
                    variantType: TextVariantType.titleMedium,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: viewModel.showComboBox,
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      child: TextVariant(
                        state.orderState.showComboBox
                            ? LocaleKeys.hide.tr()
                            : LocaleKeys.select.tr(),
                        variantType: TextVariantType.bodyMedium,
                        color: colorScheme.primary,
                      ),
                    ),
                    const Gap(10),
                    TextButton.icon(
                      onPressed: viewModel.createOrder,
                      icon: Icon(
                        Icons.add,
                        size: 20,
                        color: colorScheme.onPrimary,
                      ),
                      label: TextVariant(
                        LocaleKeys.add.tr(),
                        variantType: TextVariantType.bodyMedium,
                      ),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        foregroundColor: colorScheme.onPrimary,
                        backgroundColor: colorScheme.primary,
                        iconColor: colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    const Gap(10),
                    if (state.orderState.selectedOrders.isNotEmpty)
                      TextButton.icon(
                        onPressed: viewModel.deleteSelectedOrders,
                        icon: const Icon(Icons.delete),
                        label: TextVariant(
                          LocaleKeys.delete.tr(),
                          variantType: TextVariantType.bodyMedium,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: state.orderState.orders.isEmpty
                ? SizedBox(
                    height: 100,
                    child: Center(
                      child: TextVariant(
                        LocaleKeys.noOrdersFound.tr(),
                        variantType: TextVariantType.bodyMedium,
                      ),
                    ),
                  )
                : DataTable(
                    columnSpacing: 46,
                    border: TableBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    dataRowColor: computeDataRowColor(colorScheme),
                    dataTextStyle: textTheme.bodyMedium?.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                    headingTextStyle: textTheme.titleMedium,
                    showCheckboxColumn: state.orderState.showComboBox,
                    horizontalMargin: 12,
                    dividerThickness: .5,
                    onSelectAll: (_) {
                      viewModel.selectAll();
                    },
                    sortColumnIndex: state.orderState.sortColumnIndex,
                    sortAscending: state.orderState.sortAscending,
                    columns: Headers.values
                        .map(
                          (e) => DataColumn(
                            label: TextVariant(
                              e == Headers.store
                                  ? businessTypeNotifier.getServiceTypeWording(
                                      "x",
                                      type: businessTypeState,
                                    )
                                  : e.label,
                              variantType: TextVariantType.bodyMedium,
                            ),
                            numeric: e.isNumeric,
                            headingRowAlignment: MainAxisAlignment.center,
                            onSort: viewModel.sortOrders,
                          ),
                        )
                        .toList(),
                    rows: state.orderState.orders
                        .where((order) => ![
                              OrderStatus.canceled,
                              OrderStatus.failed,
                              OrderStatus.finished,
                            ].contains(order.status))
                        .map((order) {
                      return DataRow(
                        selected:
                            state.orderState.selectedOrders.contains(order),
                        onLongPress: () => viewModel.selectOrder(order),
                        onSelectChanged: (bool? value) {
                          if (state.orderState.showComboBox) {
                            viewModel.selectOrder(order);
                          } else {
                            if (context.mounted) {
                              context.pushNamed(
                                'order-details',
                                pathParameters: {'orderId': order.id},
                                extra: order,
                              );
                            }
                          }
                        },
                        cells: [
                          DataCell(
                            Hero(
                              tag: 'order-${order.id}',
                              child: Center(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: TextVariant(
                                    order.clientContact,
                                    variantType: TextVariantType.bodyMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: StatusCard(
                                status: order.status,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: TextVariant(
                                order.shopName,
                                variantType: TextVariantType.bodyMedium,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: TextVariant(
                                order.startDate.toDDMMYYYY(),
                                variantType: TextVariantType.bodyMedium,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: TextVariant(
                                order.endDate?.toDDMMYYYY() ?? "",
                                variantType: TextVariantType.bodyMedium,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: TextVariant(
                                "${order.price}€",
                                variantType: TextVariantType.bodyMedium,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: TextVariant(
                                "${order.commission}€",
                                variantType: TextVariantType.bodyMedium,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: IconButton(
                                onPressed: () {
                                  if (context.mounted) {
                                    context.pushNamed(
                                      'order-details',
                                      pathParameters: {'orderId': order.id},
                                      extra: order,
                                    );
                                  }
                                },
                                icon: const Icon(Icons.open_in_new),
                                tooltip: LocaleKeys.open.tr(),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: IconButton(
                                onPressed: () {
                                  viewModel.pinOrder(order);
                                },
                                icon: Icon(
                                  state.orderState.pinnedOrders.contains(order)
                                      ? Icons.push_pin
                                      : Icons.push_pin_outlined,
                                ),
                                tooltip: LocaleKeys.pin.tr(),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _ResumeHeader extends ConsumerWidget {
  const _ResumeHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: IntrinsicHeight(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _NextActionContainer(),
                Gap(10),
                _TotalContainer(),
                Gap(10),
                _CurrentMonthTotalContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CurrentMonthTotalContainer extends ConsumerWidget {
  const _CurrentMonthTotalContainer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(indexProvider);
    final currentMonth = DateTime.now().month;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
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
            LocaleKeys.totalWithDate.tr(
              args: [
                DateFormat('MMMM').format(DateTime.now()),
              ],
            ),
            variantType: TextVariantType.bodyMedium,
          ),
          const SizedBox(height: 10),
          TextVariant(
            LocaleKeys.priceWithSymbol.tr(
              args: [
                state.orderState.orders
                    .where((order) => order.startDate.month == currentMonth)
                    .fold(
                      0,
                      (sum, order) =>
                          (sum.toDouble() + order.commission).toInt(),
                    )
                    .toStringAsFixed(2)
              ],
            ),
            variantType: TextVariantType.titleLarge,
          ),
        ],
      ),
    );
  }
}

class _TotalContainer extends ConsumerWidget {
  const _TotalContainer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(indexProvider);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
            LocaleKeys.total.tr(),
            variantType: TextVariantType.bodySmall,
          ),
          const SizedBox(height: 10),
          TextVariant(
            LocaleKeys.priceWithSymbol.tr(
              args: [
                state.orderState.allOrder
                    .fold(
                      0,
                      (sum, order) =>
                          (sum.toDouble() + order.commission).toInt(),
                    )
                    .toStringAsFixed(2),
              ],
            ),
            variantType: TextVariantType.titleLarge,
          ),
        ],
      ),
    );
  }
}

class _NextActionContainer extends ConsumerStatefulWidget {
  const _NextActionContainer();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NextActionContainerState();
}

class _NextActionContainerState extends ConsumerState<_NextActionContainer> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(indexProvider.notifier);
    final state = ref.watch(indexProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: state.orderState.nextAction != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onExit: (_) {
        if (state.orderState.nextAction != null) {
          setState(() => isHover = false);
        }
      },
      onHover: (_) {
        if (state.orderState.nextAction != null) {
          setState(() => isHover = true);
        }
      },
      child: GestureDetector(
        onTap: () {
          viewModel.navigateToDetails(
            state.orderState.nextAction!.keys.first,
          );
        },
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isHover ? colorScheme.primaryContainer : colorScheme.surface,
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
                LocaleKeys.nextAction.tr(),
                variantType: TextVariantType.bodySmall,
                color: isHover ? colorScheme.onPrimary : colorScheme.onSurface,
              ),
              const SizedBox(height: 10),
              if (state.orderState.nextAction != null)
                TextVariant(
                  state.orderState.nextAction!.keys.firstOrNull?.actions
                          .firstOrNull?.date
                          .toDDMMYYYY() ??
                      "",
                  variantType: TextVariantType.titleLarge,
                  color:
                      isHover ? colorScheme.onPrimary : colorScheme.onSurface,
                )
              else
                TextVariant(
                  LocaleKeys.noNextAction.tr(),
                  variantType: TextVariantType.bodyMedium,
                  color: colorScheme.onSurface,
                ),
              const SizedBox(height: 10),
              if (state.orderState.nextAction != null)
                HelpText(text: LocaleKeys.clickToSeeDetails.tr()),
            ],
          ),
        ),
      ),
    );
  }
}
