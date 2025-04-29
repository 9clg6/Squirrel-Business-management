import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/screen/customers/customers.view_model.dart';
import 'package:squirrel/ui/screen/customers/customers.view_state.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Second screen
///
class CustomersScreen extends ConsumerStatefulWidget {
  /// Constructor
  /// @param key : [Key]
  ///
  const CustomersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersScreenState();
}

/// State of the second screen
class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  /// Builds the second screen
  /// @param context : [BuildContext]
  /// @return [Widget]
  ///
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Customers viewModel = ref.watch(customersProvider.notifier);
    final CustomersScreenState state = ref.watch(customersProvider);

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
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
                SizedBox(
                  width: double.infinity,
                  child: switch (state) {
                    CustomersScreenState(
                      customers: final List<Customer> customers
                    ) =>
                      customers.isEmpty
                          ? Center(
                              child: TextVariant(
                                LocaleKeys.noClients.tr(),
                                variantType: TextVariantType.titleMedium,
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
                                    color: colorScheme.outline
                                        .withValues(alpha: .2),
                                  ),
                                ),
                              ),
                              headingTextStyle: textTheme.titleMedium,
                              horizontalMargin: 12,
                              dividerThickness: .5,
                              showCheckboxColumn: false,
                              columns: <DataColumn>[
                                DataColumn(
                                  label: TextVariant(
                                    LocaleKeys.clientName.tr(),
                                  ),
                                ),
                                DataColumn(
                                  label: TextVariant(
                                    LocaleKeys.totalOrders.tr(),
                                  ),
                                ),
                                DataColumn(
                                  label: TextVariant(
                                    LocaleKeys.totalAmount.tr(),
                                  ),
                                ),
                                DataColumn(
                                  label: TextVariant(
                                    LocaleKeys.totalCommissions.tr(),
                                  ),
                                ),
                                DataColumn(
                                  label: TextVariant(
                                    LocaleKeys.totalSponsors.tr(),
                                  ),
                                ),
                              ],
                              rows: state.customers
                                  .map(
                                    (Customer entry) => DataRow(
                                      onSelectChanged: (bool? value) {
                                        viewModel.selectCustomer(entry);
                                      },
                                      cells: <DataCell>[
                                        DataCell(
                                          Center(
                                            child: Row(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor:
                                                      colorScheme.primary,
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
                                                  child: Text(
                                                    entry.name.capitalize,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            entry.orderQuantity.toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            entry.orderTotalAmount
                                                .toStringAsFixed(2),
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
                                            entry.sponsorshipQuantity
                                                .toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
