import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/enums/headers.enum.dart';
import 'package:squirrel/foundation/enums/router.enum.dart';
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
  /// @param [key] key
  ///
  const MainScreen({super.key});

  /// Creates the state of the main screen
  /// @return [ConsumerState<ConsumerStatefulWidget>] state
  ///
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

/// State of the main screen
class _MainScreenState extends ConsumerState<MainScreen> {
  /// Builds the main screen
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context) {
    final AsyncValue<OrderState> state = ref.watch(orderServiceProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: switch (state) {
        AsyncLoading<OrderState>() =>
          const Center(child: CircularProgressIndicator()),
        AsyncData<OrderState>(value: OrderState()) => const CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              _ResumeHeader(),
              _Body(),
            ],
          ),
        AsyncError<OrderState>(:final Object error) => Center(
            child: Text(
              error.toString(),
            ),
          ),
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
    final Index viewModel = ref.watch(indexProvider.notifier);
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
          ),
          left: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
          ),
          right: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
          ),
        ),
      ),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                    .map(
                      (Headers e) => DataColumn(
                        label: TextVariant(
                          e.label,
                        ),
                        numeric: e.isNumeric,
                        headingRowAlignment: MainAxisAlignment.center,
                        onSort: (_, __) => viewModel.sortOrders(
                          e.index,
                          ascending: state.sortAscending,
                        ),
                      ),
                    )
                    .toList(),
                rows: state.pinnedOrders.map((Order order) {
                  return DataRow(
                    onSelectChanged: (_) {
                      viewModel.navigateToDetails(order);
                    },
                    cells: <DataCell>[
                      DataCell(
                        Center(
                          child: Hero(
                            tag: 'order-${order.id}',
                            child: TextVariant(
                              order.client?.name.capitalize ?? '',
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
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: TextVariant(
                            order.startDate.toDDMMYYYY(),
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: TextVariant(
                            order.endDate?.toDDMMYYYY() ?? '',
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: TextVariant(
                            '${order.price}€',
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: TextVariant(
                            '${order.commission}€',
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
    return const SliverPadding(
      padding: EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
    final Index viewModel = ref.watch(indexProvider.notifier);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AsyncValue<BusinessTypeState> businessTypeState =
        ref.watch(businessTypeServiceProvider);
    final BusinessTypeService businessTypeNotifier =
        ref.watch(businessTypeServiceProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
          ),
          left: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
          ),
          right: BorderSide(
            color: colorScheme.outline.withValues(alpha: .3),
          ),
        ),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                  children: <Widget>[
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
                        color: colorScheme.onPrimary,
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
                            (Headers e) => switch (businessTypeState) {
                              AsyncData<BusinessTypeState>(
                                value: BusinessTypeState()
                              ) =>
                                DataColumn(
                                  label: TextVariant(
                                    e == Headers.store
                                        ? businessTypeNotifier
                                            .getServiceTypeWording(
                                            'x',
                                            type: businessTypeState.value,
                                          )
                                        : e.label,
                                  ),
                                  numeric: e.isNumeric,
                                  headingRowAlignment: MainAxisAlignment.center,
                                  onSort: (_, __) => viewModel.sortOrders(
                                    e.index,
                                    ascending: state.sortAscending,
                                  ),
                                ),
                              _ => const DataColumn(
                                  label: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            },
                          )
                          .toList(),
                      rows: state.orders.map((Order order) {
                        return DataRow(
                          selected: state.selectedOrders.contains(order),
                          onLongPress: () => viewModel.selectOrder(order),
                          onSelectChanged: (bool? value) {
                            if (state.showComboBox) {
                              viewModel.selectOrder(order);
                            } else {
                              if (context.mounted) {
                                context.pushNamed(
                                  RouterEnum.orderDetails.name,
                                  pathParameters: <String, String>{
                                    'orderId': order.id,
                                  },
                                  extra: order,
                                );
                              }
                            }
                          },
                          cells: <DataCell>[
                            DataCell(
                              Hero(
                                tag: 'order-${order.id}',
                                child: Center(
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: TextVariant(
                                      order.client?.name ?? '',
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
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: TextVariant(
                                  order.startDate.toDDMMYYYY(),
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: TextVariant(
                                  order.endDate?.toDDMMYYYY() ?? '',
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: TextVariant(
                                  '${order.price}€',
                                ),
                              ),
                            ),
                            DataCell(
                              Center(
                                child: TextVariant(
                                  '${order.commission}€',
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
                                        pathParameters: <String, String>{
                                          'orderId': order.id,
                                        },
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
              children: <Widget>[
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
    final IndexScreenState state = ref.watch(indexProvider);
    final int currentMonth = DateTime.now().month;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextVariant(
            LocaleKeys.totalWithDate.tr(
              args: <String>[
                DateFormat('MMMM').format(DateTime.now()),
              ],
            ),
            variantType: TextVariantType.bodySmall,
          ),
          const SizedBox(height: 10),
          TextVariant(
            LocaleKeys.priceWithSymbol.tr(
              args: <String>[
                state.orders
                    .where(
                      (Order order) => order.startDate.month == currentMonth,
                    )
                    .fold(
                      0,
                      (int sum, Order order) =>
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

class _TotalContainer extends ConsumerWidget {
  const _TotalContainer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IndexScreenState state = ref.watch(indexProvider);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextVariant(
            LocaleKeys.total.tr(),
            variantType: TextVariantType.bodySmall,
          ),
          const SizedBox(height: 10),
          TextVariant(
            LocaleKeys.priceWithSymbol.tr(
              args: <String>[
                state.orders
                    .fold(
                      0,
                      (int sum, Order order) =>
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
    final Index viewModel = ref.watch(indexProvider.notifier);
    final AsyncValue<OrderState> state = ref.watch(orderServiceProvider);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return state.when(
      data: (OrderState data) => MouseRegion(
        cursor: data.nextAction != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onExit: (_) {
          if (data.nextAction != null) {
            setState(() => isHover = false);
          }
        },
        onHover: (_) {
          if (data.nextAction != null) {
            setState(() => isHover = true);
          }
        },
        child: GestureDetector(
          onTap: () {
            viewModel.navigateToDetails(
              data.nextAction!.keys.first,
            );
          },
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:
                  isHover ? colorScheme.primaryContainer : colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: .2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextVariant(
                  LocaleKeys.nextAction.tr(),
                  variantType: TextVariantType.bodySmall,
                  color:
                      isHover ? colorScheme.onPrimary : colorScheme.onSurface,
                ),
                const SizedBox(height: 10),
                if (data.nextAction != null)
                  TextVariant(
                    data.nextAction!.keys.firstOrNull?.actions.firstOrNull?.date
                            .toDDMMYYYY() ??
                        '',
                    variantType: TextVariantType.titleLarge,
                    color:
                        isHover ? colorScheme.onPrimary : colorScheme.onSurface,
                  )
                else
                  TextVariant(
                    LocaleKeys.noNextAction.tr(),
                    color:
                        isHover ? colorScheme.onPrimary : colorScheme.onSurface,
                  ),
                const SizedBox(height: 10),
                if (data.nextAction != null)
                  HelpText(
                    text: LocaleKeys.clickToSeeDetails.tr(),
                    color:
                        isHover ? colorScheme.onPrimary : colorScheme.onSurface,
                  ),
              ],
            ),
          ),
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (Object error, StackTrace stackTrace) => TextVariant(
        error.toString(),
      ),
    );
  }
}
