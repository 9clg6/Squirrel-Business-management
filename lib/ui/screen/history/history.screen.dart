import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/foundation/enums/headers.enum.dart';
import 'package:squirrel/foundation/enums/router.enum.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/screen/history/history.view_model.dart';
import 'package:squirrel/ui/screen/history/history.view_state.dart';
import 'package:squirrel/ui/widgets/status_card.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// History screen
class HistoryScreen extends StatefulWidget {
  /// Constructor
  /// @param [key] key
  ///
  const HistoryScreen({super.key});

  /// Create state
  /// Create state
  /// @return [State] state
  ///
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

/// History screen state
class _HistoryScreenState extends State<HistoryScreen> {
  /// Build
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: const _OrdersList(),
    );
  }
}

/// Orders list
class _OrdersList extends ConsumerWidget {
  /// Constructor
  ///
  const _OrdersList();

  /// Build
  /// @param [context] context
  /// @param [ref] ref
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HistoryState state = ref.watch(historyProvider);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final businessTypeState = ref.watch(businessTypeServiceProvider);
    final businessTypeNotifier = ref.read(businessTypeServiceProvider.notifier);

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
      ),
      width: double.infinity,
      child: switch (state) {
        AsyncLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        AsyncError(:final error) => Center(
            child: TextVariant(
              error.toString(),
              variantType: TextVariantType.bodyMedium,
            ),
          ),
        HistoryState() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: colorScheme.outline.withValues(alpha: .2),
                              width: 1,
                            ),
                          ),
                        ),
                        headingTextStyle: textTheme.titleMedium,
                        horizontalMargin: 12,
                        dividerThickness: .5,
                        showCheckboxColumn: false,
                        columns: Headers.values
                            .where((h) => h != Headers.actions)
                            .map((e) => switch (businessTypeState) {
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
                                      headingRowAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                  _ => const DataColumn(
                                      label: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                })
                            .toList(),
                        rows: state.orders.map((order) {
                          return DataRow(
                            onSelectChanged: (bool? value) {
                              if (context.mounted) {
                                context.pushNamed(
                                  RouterEnum.orderDetails.name,
                                  pathParameters: {'orderId': order.id},
                                  extra: order,
                                );
                              }
                            },
                            cells: [
                              DataCell(
                                Hero(
                                  tag: 'order-${order.id}',
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
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
                                    LocaleKeys.priceWithSymbol.tr(
                                      args: [
                                        order.commission.toString(),
                                      ],
                                    ),
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
                                          RouterEnum.orderDetails.name,
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
                            ],
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
      },
    );
  }
}
