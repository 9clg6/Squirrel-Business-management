import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:init/foundation/enums/chart_type.enum.dart';
import 'package:init/foundation/extensions/date_time.extension.dart';
import 'package:init/ui/screen/stats/stats.view_model.dart';
import 'package:init/ui/screen/stats/stats.view_state.dart';
import 'package:init/ui/widgets/text_variant.dart';

// STATS BOTS :
// Nombre de messages par jour / semaine / mois
// Horaires habituels des messages
// Horaires habituels des actions
// Horaires habituels des réponses

///
/// Stats screen
///
class StatsScreen extends ConsumerStatefulWidget {
  ///
  /// Constructor
  ///
  const StatsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatsScreenState();
}

///
/// State of the stats screen
///
class _StatsScreenState extends ConsumerState<StatsScreen> {
  ///
  /// Builds the second screen
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final StatsScreenState state = ref.watch(statsViewModelProvider);

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: const SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowQuickStats(),
                    Gap(22),
                    OrdersByDayChart(),
                    Gap(22),
                    // Top 5 des produits / Boutiques
                    // Selectionner plage de dates
                    // Nombre de commandes sur le mois
                    // Nombre de commandes total
                    // Stats par boutique
                    // Stats par client
                    // Duree moyenne des commandes
                    // Duree moyenne des commandes par boutique
                    // Montant total des commandes
                    // Montant total des commandes par boutique
                    // Nombre de commandes par jour
                    // Nombre de commandes par semaine
                    // Nombre de commandes par mois
                    // Nombre de commandes par an
                  ],
                ),
              ),
            ),
    );
  }
}

class OrdersByDayChart extends ConsumerStatefulWidget {
  const OrdersByDayChart({super.key});

  @override
  ConsumerState<OrdersByDayChart> createState() => _OrdersByDayChartState();
}

class _OrdersByDayChartState extends ConsumerState<OrdersByDayChart> {
  bool isHoveringDate = false;
  bool isHoveringRevenue = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(statsViewModelProvider);
    final viewModel = ref.read(statsViewModelProvider.notifier);
    final dateRange = state.dateRange;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextVariant(
            'Nombre de commandes par jour',
            variantType: TextVariantType.titleMedium,
            color: colorScheme.onSurface,
          ),
          const Gap(20),
          InkWell(
            onTap: viewModel.changeDateRange,
            child: MouseRegion(
              onExit: (_) => setState(() => isHoveringDate = false),
              onHover: (_) => setState(() => isHoveringDate = true),
              cursor: SystemMouseCursors.click,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isHoveringDate
                      ? colorScheme.primary
                      : colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: .2),
                    width: 1,
                  ),
                ),
                child: TextVariant(
                  '${dateRange.start.toDDMMYYYY()} - ${dateRange.end.toDDMMYYYY()}',
                  variantType: TextVariantType.bodyMedium,
                  color: isHoveringDate
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const Gap(20),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {
                    viewModel.setRevenueType(ChartType.dailyRevenue);
                  },
                  child: MouseRegion(
                    onExit: (_) => setState(() => isHoveringRevenue = false),
                    onHover: (_) => setState(() => isHoveringRevenue = true),
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: state.chartType == ChartType.dailyRevenue ||
                                isHoveringRevenue
                            ? colorScheme.primary
                            : colorScheme.surfaceBright,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: .2),
                          width: 1,
                        ),
                      ),
                      child: TextVariant(
                        'Revenus journalier',
                        variantType: TextVariantType.bodyMedium,
                        color: isHoveringRevenue ||
                                state.chartType == ChartType.dailyRevenue
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(40),
          SizedBox(
            height: 500,
            child: Builder(
              builder: (context) {
                return LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: state.maxY,
                    gridData: const FlGridData(show: true),
                    titlesData: FlTitlesData(
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final date = DateTime.fromMillisecondsSinceEpoch(
                              value.toInt(),
                            ).getDateWithoutTime();

                            return TextVariant(
                              date.toDDMMYYYY(),
                              variantType: TextVariantType.bodyMedium,
                            );
                          },
                          reservedSize: 42,
                          interval:
                              const Duration(days: 1).inMilliseconds.toDouble(),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: state.yInterval,
                          getTitlesWidget: (value, meta) {
                            return TextVariant(
                              value.toInt().toString(),
                              variantType: TextVariantType.bodyMedium,
                            );
                          },
                          reservedSize: 42,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(
                          dateRange.end.difference(dateRange.start).inDays + 1,
                          (index) {
                            final date = dateRange.start.add(
                              Duration(days: index),
                            );

                            return FlSpot(
                              date.millisecondsSinceEpoch.toDouble(),
                              state.dataToShow[date.getDateWithoutTime()]
                                      ?.toDouble() ??
                                  0,
                            );
                          },
                        ),
                        isCurved: false,
                        color: colorScheme.primary,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                            radius: 6,
                            color: colorScheme.primary,
                            strokeWidth: 2,
                            strokeColor: colorScheme.surface,
                          ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color: colorScheme.primary.withValues(alpha: .1),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

class RowQuickStats extends ConsumerWidget {
  const RowQuickStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(statsViewModelProvider);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: .2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: .2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.store,
                      color: colorScheme.primary,
                    ),
                  ),
                  const Gap(10),
                  const TextVariant(
                    'Boutiques les plus performantes',
                    variantType: TextVariantType.bodySmall,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(10),
                  ...state.totalByShop.entries.map(
                    (entry) => TextVariant(
                      '${entry.key}: ${entry.value.toStringAsFixed(2)}€',
                      variantType: TextVariantType.titleMedium,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Gap(22),
          Expanded(
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: .2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: .2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      color: colorScheme.primary,
                    ),
                  ),
                  const Gap(10),
                  const TextVariant(
                    'Meilleur client',
                    variantType: TextVariantType.bodySmall,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(10),
                  ...state.orders
                      .fold<Map<String, Map<String, dynamic>>>(
                        {},
                        (map, order) => map
                          ..update(
                            order.clientContact,
                            (value) => {
                              'count': value['count'] + 1,
                              'total': value['total'] + order.price,
                            },
                            ifAbsent: () => {
                              'count': 1,
                              'total': order.price,
                            },
                          ),
                      )
                      .entries
                      .toList()
                      .sorted((a, b) => (b.value['total'] as double)
                          .compareTo(a.value['total'] as double))
                      .take(5)
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextVariant(
                            '${entry.key}: ${entry.value['total'].toStringAsFixed(2)}€',
                            variantType: TextVariantType.titleMedium,
                          ),
                        ),
                      )
                ],
              ),
            ),
          ),
          const Gap(22),
          Expanded(
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: .2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: .2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: colorScheme.primary,
                    ),
                  ),
                  const Gap(10),
                  const TextVariant(
                    'Client le plus fidèle',
                    variantType: TextVariantType.bodySmall,
                    fontWeight: FontWeight.bold,
                  ),
                  const Gap(10),
                  ...state.orders
                      .fold<Map<String, int>>(
                        {},
                        (map, order) => map
                          ..update(
                            order.clientContact,
                            (value) => value + 1,
                            ifAbsent: () => 1,
                          ),
                      )
                      .entries
                      .toList()
                      .sorted((a, b) => b.value.compareTo(a.value))
                      .take(5)
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: TextVariant(
                            '${entry.key}: ${entry.value} commandes',
                            variantType: TextVariantType.titleMedium,
                          ),
                        ),
                      )
                ],
              ),
            ),
          ),
          const Gap(22),
          const StatsChart(),
        ],
      ),
    );
  }
}

class StatsChart extends ConsumerStatefulWidget {
  const StatsChart({super.key});

  @override
  ConsumerState<StatsChart> createState() => _StatsChartState();
}

class _StatsChartState extends ConsumerState<StatsChart> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final viewModel = ref.read(statsViewModelProvider.notifier);
    final state = ref.watch(statsViewModelProvider);

    return Expanded(
      flex: 2,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: .2),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            TextVariant(
              'Montant total des commandes',
              color: colorScheme.onSurface,
              variantType: TextVariantType.bodyMedium,
            ),
            const Gap(12),
            TextVariant(
              '${state.total} €',
              color: colorScheme.onSurface,
              variantType: TextVariantType.titleLarge,
            ),
            Builder(
              builder: (context) {
                final sections = state.totalByShop.entries.map(
                  (entry) => PieChartSectionData(
                    value: entry.value / state.total * 50,
                    color: Colors.primaries[
                        entry.key.hashCode % Colors.primaries.length],
                    showTitle: false,
                    radius: state.hoveredShop == entry.key ? 52 : 42,
                  ),
                );

                return ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.50,
                    widthFactor: 0.70,
                    child: SizedBox(
                      height: 420,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          if (state.hoveredShop != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 130),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceBright,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: colorScheme.outline
                                        .withValues(alpha: .2),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextVariant(
                                      "${state.hoveredShop}",
                                      color: colorScheme.onSurface,
                                      variantType: TextVariantType.bodyMedium,
                                    ),
                                    TextVariant(
                                      "${state.totalByShop[state.hoveredShop!]} €",
                                      color: colorScheme.onSurface,
                                      variantType: TextVariantType.titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          PieChart(
                            PieChartData(
                              startDegreeOffset: 180,
                              sectionsSpace: 12,
                              centerSpaceRadius: 120,
                              sections: [
                                ...sections,
                                PieChartSectionData(
                                  value: 50,
                                  color: Colors.transparent,
                                  showTitle: false,
                                  radius: 0,
                                ),
                              ],
                              pieTouchData: PieTouchData(
                                touchCallback: (FlTouchEvent event,
                                    PieTouchResponse? touchResponse) {
                                  setState(
                                    () {
                                      final touchedSection =
                                          touchResponse?.touchedSection;

                                      final index = touchResponse
                                          ?.touchedSection?.touchedSectionIndex;

                                      if (touchedSection == null ||
                                          index == -1) {
                                        viewModel.changeHoveredShop();
                                        return;
                                      }

                                      if (event is FlPointerHoverEvent &&
                                          touchResponse != null) {
                                        viewModel.changeHoveredShop(
                                          state.totalByShop.entries
                                              .elementAt(index!)
                                              .key,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
