import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/screen/clients/clients.view_model.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Second screen
///
class ClientsScreen extends ConsumerStatefulWidget {
  /// Constructor
  /// @param key : [Key]
  ///
  const ClientsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientsScreenState();
}

/// State of the second screen
class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  /// Builds the second screen
  /// @param context : [BuildContext]
  /// @return [Widget]
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
        child: Container(
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
          child: state.clients.isEmpty
              ? Center(
                  child: TextVariant(
                    LocaleKeys.noClients.tr(),
                    variantType: TextVariantType.titleMedium,
                  ),
                )
              : DataTable(
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
                    DataColumn(
                      label: TextVariant(
                        LocaleKeys.totalSponsors.tr(),
                        variantType: TextVariantType.bodyMedium,
                      ),
                    ),
                  ],
                  rows: state.clients
                      .map((entry) => DataRow(
                            onSelectChanged: (bool? value) {
                              viewModel.selectClient(entry);
                            },
                            cells: [
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: colorScheme.primary,
                                      child: Center(
                                        child: Text(
                                          entry.name
                                              .substring(0, 1)
                                              .toUpperCase(),
                                        ),
                                      ),
                                    ),
                                    const Gap(8),
                                    Hero(
                                      tag: entry.id,
                                      child: Text(entry.name.capitalize),
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(
                                Text(
                                  entry.orderQuantity.toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  entry.orderTotalAmount.toStringAsFixed(2),
                                ),
                              ),
                              DataCell(
                                Text(
                                  entry.commissionTotalAmount
                                      .toStringAsFixed(2),
                                ),
                              ),
                              DataCell(
                                Text(
                                  entry.sponsorshipQuantity.toString(),
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
        ),
      ),
    );
  }
}
