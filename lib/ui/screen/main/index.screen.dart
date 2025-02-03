import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:init/foundation/enums/filter.enum.dart';
import 'package:init/foundation/enums/headers.enum.dart';
import 'package:init/foundation/extensions/date_time.extension.dart';
import 'package:init/ui/screen/main/index.view_model.dart';
import 'package:init/ui/screen/main/index.view_state.dart';

/// Main screen
class MainScreen extends ConsumerStatefulWidget {
  /// Constructor
  const MainScreen({super.key});

  /// Creates the state of the main screen
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

/// State of the main screen
class _MainScreenState extends ConsumerState<MainScreen> {
  /// Builds the main screen
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _ResumeHeader(),
          _ManagementBar(),
          _Body(),
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
    final Index viewModel = ref.read(indexProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    if (state.loading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    showCheckboxColumn: state.showComboBox,
                    onSelectAll: (_) {
                      viewModel.selectAll();
                    },
                    columnSpacing: 46,
                    dataTextStyle:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                    headingTextStyle:
                        Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                    horizontalMargin: 12,
                    columns: Headers.values
                        .map(
                          (e) => DataColumn(
                            label: Text(e.label),
                            numeric: e.isNumeric,
                            headingRowAlignment: MainAxisAlignment.center,
                            onSort: viewModel.sortOrders,
                          ),
                        )
                        .toList(),
                    dividerThickness: .5,
                    rows: state.orders.map((order) {
                      return DataRow(
                        selected: state.selectedOrders.contains(order),
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    order.clientContact,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: order.status.color,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(order.status.name),
                              ),
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
                              child: Text("${order.price}€"),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text("${order.commission}€"),
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
          ),
        ),
      ),
    );
  }
}

class _ResumeHeader extends ConsumerWidget {
  const _ResumeHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IndexScreenState state = ref.watch(indexProvider);

    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 250,
                height: 100,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Prochaine action"),
                    const SizedBox(height: 10),
                    Text(
                      state.nextActionDate?.toDDMMYYYY() ?? "",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 250,
                height: 100,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total du mois"),
                    const SizedBox(height: 10),
                    Text(
                      "1000€",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Management bar
class _ManagementBar extends ConsumerWidget {
  /// Constructor
  const _ManagementBar();

  /// Builds the management bar
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(indexProvider);
    final viewModel = ref.read(indexProvider.notifier);

    return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: viewModel.showComboBox,
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                child: Text(state.showComboBox ? "Masquer" : "Sélectionner"),
              ),
              PopupMenuButton<Filter>(
                tooltip: "Trier",
                child: Row(
                  children: [
                    Text(
                      "Trier",
                      style: TextStyle(color: colorScheme.primary),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: colorScheme.primary),
                  ],
                ),
                onSelected: (Filter value) {
                  // Handle menu item selection
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Filter>>[
                  const PopupMenuItem<Filter>(
                    value: Filter.byStartDate,
                    child: Text('Par date de début'),
                  ),
                  const PopupMenuItem<Filter>(
                    value: Filter.byEndDate,
                    child: Text('Par date de fin'),
                  ),
                  const PopupMenuItem<Filter>(
                    value: Filter.byStatus,
                    child: Text('Par statut'),
                  ),
                  const PopupMenuItem<Filter>(
                    value: Filter.byMethod,
                    child: Text('Par méthode'),
                  ),
                  const PopupMenuItem<Filter>(
                    value: Filter.byPriority,
                    child: Text('Par priorité'),
                  ),
                  const PopupMenuItem<Filter>(
                    value: Filter.byShop,
                    child: Text('Par magasin'),
                  ),
                  const PopupMenuItem<Filter>(
                    value: Filter.byPrice,
                    child: Text('Par prix'),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  size: 20,
                  color: colorScheme.onPrimary,
                ),
                label: const Text("Ajouter"),
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
              const SizedBox(width: 10),
              if (state.selectedOrders.isNotEmpty)
                TextButton.icon(
                  onPressed: viewModel.deleteSelectedOrders,
                  icon: const Icon(Icons.delete),
                  label: const Text("Supprimer"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
