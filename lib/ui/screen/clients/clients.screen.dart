import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init/foundation/utils/util.dart';
import 'package:init/ui/screen/clients/clients.view_model.dart';

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
                columns: const [
                  DataColumn(label: Text('Nom d\'utilisateur')),
                  DataColumn(label: Text('Nombre de commandes')),
                  DataColumn(label: Text('Total des commandes')),
                  DataColumn(label: Text('Total des commissions')),
                ],
                rows: state.clients.entries
                    .map((entry) => DataRow(
                          onSelectChanged: (bool? value) {
                            viewModel.selectClient(entry.key);
                          },
                          cells: [
                            DataCell(Text(entry.key)),
                            DataCell(
                              Text(
                                entry.value['totalOrders'].toString(),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.value['totalAmount'].toStringAsFixed(2),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.value['totalCommissions']
                                    .toStringAsFixed(2),
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
