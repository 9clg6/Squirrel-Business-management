import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/enums/headers.enum.dart';
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
    final AsyncValue<OrderState> state = ref.watch(orderServiceProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: switch (state) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncData() => const CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
              _ResumeHeader(),
              _Body(),
            ],
          ),
        AsyncError(:final error) => Center(child: Text(error.toString())),
        AsyncValue<OrderState>() => throw UnimplementedError(),
      },
    );
  }
}

class _PinnedOrders extends ConsumerWidget {
  const _PinnedOrders();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IndexScreenState state = ref.watch(indexProvider);
    final Index viewModel = ref.read(indexProvider.notifier);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    if (state.pinnedOrders.isEmpty) return const SizedBox();

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
            width: 1,
          ),
          left: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
            width: 1,
          ),
          right: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
            width: 1,
          ),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 46,
                dataRowColor: computeDataRowColor(colorScheme),
                dataTextStyle: textTheme.bodyMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                headingTextStyle: textTheme.titleMedium,
                showCheckboxColumn: false,
                horizontalMargin: 12,
                dividerThickness: 1,
                columns: Headers.values
                    .map((e) => DataColumn(
                          label: TextVariant(
                            e.label,
                            variantType: TextVariantType.bodyMedium,
                          ),
                          numeric: e.isNumeric,
                          headingRowAlignment: MainAxisAlignment.center,
                          onSort: viewModel.sortOrders,
                        ))
                    .toList(),
                rows: state.pinnedOrders.map((order) {
                  return DataRow(
                    onSelectChanged: (_) {
                      viewModel.navigateToDetails(order);
                    },
                    cells: [
                      DataCell(
                        Center(
                          child: Hero(
                            tag: 'order-${order.id}',
                            child: TextVariant(
                              order.client?.name ?? "",
                              variantType: TextVariantType.bodyMedium,
                            ),
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
                              state.pinnedOrders.contains(order)
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
    final businessTypeState = ref.watch(businessTypeServiceProvider);
    final businessTypeNotifier = ref.read(businessTypeServiceProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
            width: 1,
          ),
          left: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
            width: 1,
          ),
          right: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
            width: 1,
          ),
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
                        state.showComboBox
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
                        color: colorScheme.onSurface,
                      ),
                      label: TextVariant(
                        LocaleKeys.add.tr(),
                        variantType: TextVariantType.bodyMedium,
                        color: colorScheme.onSurface,
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
                    if (state.selectedOrders.isNotEmpty)
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
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: double.infinity,
              child: state.orders.isEmpty
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
                      dataRowColor: computeDataRowColor(colorScheme),
                      dataTextStyle: textTheme.bodyMedium?.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      headingTextStyle: textTheme.titleMedium,
                      showCheckboxColumn: state.showComboBox,
                      horizontalMargin: 12,
                      dividerThickness: 1,
                      onSelectAll: (_) {
                        viewModel.selectAll();
                      },
                      sortColumnIndex: state.sortColumnIndex,
                      sortAscending: state.sortAscending,
                      columns: Headers.values
                          .map(
                            (e) => switch (businessTypeState) {
                              AsyncData(value: BusinessTypeState()) =>
                                DataColumn(
                                  label: TextVariant(
                                    e == Headers.store
                                        ? businessTypeNotifier
                                            .getServiceTypeWording(
                                            "x",
                                            type: businessTypeState.value,
                                          )
                                        : e.label,
                                    variantType: TextVariantType.bodyMedium,
                                  ),
                                  numeric: e.isNumeric,
                                  headingRowAlignment: MainAxisAlignment.center,
                                  onSort: viewModel.sortOrders,
                                ),
                              _ => const DataColumn(
                                  label: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            },
                          )
                          .toList(),
                      rows: state.orders.map((order) {
                        return DataRow(
                          selected: state.selectedOrders.contains(order),
                          onLongPress: () => viewModel.selectOrder(order),
                          onSelectChanged: (bool? value) {
                            if (state.showComboBox) {
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
                                      order.client?.name ?? "",
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
                                    state.pinnedOrders.contains(order)
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
            variantType: TextVariantType.bodySmall,
          ),
          const SizedBox(height: 10),
          TextVariant(
            LocaleKeys.priceWithSymbol.tr(
              args: [
                state.orders
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
            LocaleKeys.total.tr(),
            variantType: TextVariantType.bodySmall,
          ),
          const SizedBox(height: 10),
          TextVariant(
            LocaleKeys.priceWithSymbol.tr(
              args: [
                state.orders
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

    return switch (state) {
      AsyncError(:final error) => TextVariant(
          error.toString(),
          variantType: TextVariantType.bodyMedium,
        ),
      AsyncLoading() => const CircularProgressIndicator(),
      AsyncData(:final OrderState value) => MouseRegion(
          cursor: state.nextAction != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onExit: (_) {
            if (value.nextAction != null) {
              setState(() => isHover = false);
            }
          },
          onHover: (_) {
            if (state.nextAction != null) {
              setState(() => isHover = true);
            }
          },
          child: GestureDetector(
            onTap: () {
              viewModel.navigateToDetails(
                state.nextAction!.keys.first,
              );
            },
            child: Container(
              width: 250,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isHover
                    ? colorScheme.primaryContainer
                    : colorScheme.surface,
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
                    color:
                        isHover ? colorScheme.onPrimary : colorScheme.onSurface,
                  ),
                  const SizedBox(height: 10),
                  if (state.nextAction != null)
                    TextVariant(
                      state.nextAction!.keys.firstOrNull?.actions.firstOrNull
                              ?.date
                              .toDDMMYYYY() ??
                          "",
                      variantType: TextVariantType.titleLarge,
                      color: isHover
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                    )
                  else
                    TextVariant(
                      LocaleKeys.noNextAction.tr(),
                      variantType: TextVariantType.bodyMedium,
                      color: colorScheme.onSurface,
                    ),
                  const SizedBox(height: 10),
                  if (state.nextAction != null)
                    HelpText(text: LocaleKeys.clickToSeeDetails.tr()),
                ],
              ),
            ),
          ),
        ),
      IndexScreenState() => const SizedBox.shrink(),
    };
  }
}
