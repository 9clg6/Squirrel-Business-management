import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:init/foundation/enums/headers.enum.dart';
import 'package:init/foundation/extensions/date_time.extension.dart';
import 'package:init/foundation/utils/util.dart';
import 'package:init/ui/screen/history/history.view_model.dart';
import 'package:init/ui/screen/history/history.view_state.dart';
import 'package:init/ui/widgets/status_card.dart';
import 'package:init/ui/widgets/text_variant.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: const Column(
        children: [
          Text("History"),
          _OrdersList(),
        ],
      ),
    );
  }
}

class _OrdersList extends ConsumerWidget {
  const _OrdersList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HistoryState state = ref.watch(historyProvider);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 22,
              top: 22,
              bottom: 10,
            ),
            child: TextVariant(
              "Commandes",
              variantType: TextVariantType.titleMedium,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: state.orders.isEmpty
                ? const SizedBox(
                    height: 100,
                    child: Center(
                      child: TextVariant(
                        "Aucune commande trouvée",
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
                    horizontalMargin: 12,
                    dividerThickness: .5,
                    columns: Headers.values
                        .where((h) => h != Headers.actions)
                        .map(
                          (e) => DataColumn(
                            label: TextVariant(
                              e.label,
                              variantType: TextVariantType.bodyMedium,
                            ),
                            numeric: e.isNumeric,
                            headingRowAlignment: MainAxisAlignment.center,
                          ),
                        )
                        .toList(),
                    rows: state.orders.map((order) {
                      return DataRow(
                        onSelectChanged: (bool? value) {
                          if (context.mounted) {
                            context.pushNamed(
                              'order-details',
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
                                tooltip: "Ouvrir",
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
