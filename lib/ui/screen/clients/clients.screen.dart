import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/screen/clients/clients.view_model.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

///
/// Second screen
///
class ClientsScreen extends ConsumerStatefulWidget {
  ///
  /// Constructor
  ///
  const ClientsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientsScreenState();
}

///
/// State of the second screen
///
class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  ///
  /// Builds the second screen
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = ref.read(clientsProvider.notifier);
    final state = ref.watch(clientsProvider);

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
              child: DataTable(
                dataRowColor: computeDataRowColor(colorScheme),
                showCheckboxColumn: false,
                columns: [
                  DataColumn(
                    label: TextVariant(
                      LocaleKeys.clientName.tr(),
                      variantType: TextVariantType.bodyMedium,
                    ),
                  ),
                  DataColumn(
                    label: TextVariant(
                      LocaleKeys.totalOrders.tr(),
                      variantType: TextVariantType.bodyMedium,
                    ),
                  ),
                  DataColumn(
                    label: TextVariant(
                      LocaleKeys.totalAmount.tr(),
                      variantType: TextVariantType.bodyMedium,
                    ),
                  ),
                  DataColumn(
                    label: TextVariant(
                      LocaleKeys.totalCommissions.tr(),
                      variantType: TextVariantType.bodyMedium,
                    ),
                  ),
                ],
                rows: state.clients
                    .map((entry) => DataRow(
                          onSelectChanged: (bool? value) {
                            viewModel.selectClient(entry.name);
                          },
                          cells: [
                            DataCell(Text(entry.name)),
                            DataCell(
                              Text(
                                entry.orderQuantity.toString(),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.orderTotalAmount?.toStringAsFixed(2) ??
                                    '-',
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.commissionTotalAmount
                                        ?.toStringAsFixed(2) ??
                                    '-',
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
