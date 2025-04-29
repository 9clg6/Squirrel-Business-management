import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

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
    final AsyncValue<BusinessTypeState> businessTypeState =
        ref.watch(businessTypeServiceProvider);
    final BusinessTypeService businessTypeNotifier =
        ref.watch(businessTypeServiceProvider.notifier);

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
        ),
      ),
      width: double.infinity,
      child: switch (state) {
        AsyncLoading<HistoryState>() => const Center(
            child: CircularProgressIndicator(),
          ),
        AsyncError<HistoryState>(:final Object error) => Center(
            child: TextVariant(
              error.toString(),
            ),
          ),
        HistoryState() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
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
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: colorScheme.outline.withValues(alpha: .2),
                            ),
                          ),
                        ),
                        headingTextStyle: textTheme.titleMedium,
                        horizontalMargin: 12,
                        dividerThickness: .5,
                        showCheckboxColumn: false,
                        columns: Headers.values
                            .where((Headers h) => h != Headers.actions)
                            .map(
                              (Headers e) => switch (businessTypeState) {
                                AsyncData<BusinessTypeState>(
                                  :final BusinessTypeState value
                                ) =>
                                  DataColumn(
                                    label: TextVariant(
                                      e == Headers.store
                                          ? businessTypeNotifier
                                              .getServiceTypeWording(
                                              'x',
                                              type: value,
                                            )
                                          : e.label,
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
                              },
                            )
                            .toList(),
                        rows: state.orders.map((Order order) {
                          return DataRow(
                            onSelectChanged: (bool? value) {
                              if (context.mounted) {
                                context.pushNamed(
                                  RouterEnum.orderDetails.name,
                                  pathParameters: <String, String>{
                                    'orderId': order.id,
                                  },
                                  extra: order,
                                );
                              }
                            },
                            cells: <DataCell>[
                              DataCell(
                                Hero(
                                  tag: 'order-${order.id}',
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: TextVariant(
                                        order.customer?.name.capitalize ?? '',
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
                                    order.shopName.capitalize,
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
                                    LocaleKeys.priceWithSymbol.tr(
                                      args: <String>[
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
                                      if (context.mounted) {
                                        context.pushNamed(
                                          RouterEnum.orderDetails.name,
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
