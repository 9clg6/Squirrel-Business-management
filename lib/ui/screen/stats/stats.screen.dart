import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowQuickStats(),
                  Gap(22),
                  StatsChart(),
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
    );
  }
}

class OrdersByDayChart extends ConsumerStatefulWidget {
  const OrdersByDayChart({super.key});

  @override
  ConsumerState<OrdersByDayChart> createState() => _OrdersByDayChartState();
}

class _OrdersByDayChartState extends ConsumerState<OrdersByDayChart> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(statsViewModelProvider);
    final amountOfOrders = state.orders.length;
    final viewModel = ref.read(statsViewModelProvider.notifier);

    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
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
              onExit: (_) {
                setState(() => isHovering = false);
              },
              onHover: (_) {
                setState(() => isHovering = true);
              },
              cursor: SystemMouseCursors.click,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isHovering
                      ? colorScheme.primary
                      : colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextVariant(
                  '${state.dateRange.start.toDDMMYYYY()} - ${state.dateRange.end.toDDMMYYYY()}',
                  variantType: TextVariantType.bodyMedium,
                  color: isHovering
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const Gap(20),
          Expanded(
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: state.orders.isNotEmpty
                    ? amountOfOrders > 50
                        ? 50.toDouble()
                        : amountOfOrders.toDouble()
                    : 10,
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value % 2 != 0 && value != 1) return const SizedBox.shrink();
                        
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final date =
                            DateTime.fromMillisecondsSinceEpoch(value.toInt());

                        if (date.day % 5 == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              date.toDDMMYYYY(),
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      interval:
                          const Duration(days: 1).inMilliseconds.toDouble(),
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: () {
                      // Filtrer les commandes sur le dernier mois et les grouper par date
                      final ordersByDate = state.orders
                          .where((order) =>
                              order.startDate.isAfter(state.dateRange.start))
                          .fold<Map<DateTime, int>>(
                        {},
                        (map, order) {
                          final date = DateTime(
                            order.startDate.year,
                            order.startDate.month,
                            order.startDate.day,
                          );
                          return map
                            ..update(
                              date,
                              (value) => value + 1,
                              ifAbsent: () => 1,
                            );
                        },
                      );

                      // Créer une liste de toutes les dates du mois avec des valeurs à 0 par défaut
                      final allDates = <DateTime, int>{};
                      for (var date = state.dateRange.start;
                          date.isBefore(state.dateRange.end);
                          date = date.add(const Duration(days: 1))) {
                        allDates[DateTime(date.year, date.month, date.day)] = 0;
                      }

                      // Fusionner avec les commandes réelles
                      allDates.addAll(ordersByDate);

                      // Convertir en spots pour le graphique
                      final spots = allDates.entries
                          .map(
                            (entry) => FlSpot(
                              entry.key.millisecondsSinceEpoch.toDouble(),
                              entry.value.toDouble(),
                            ),
                          )
                          .toList()
                        ..sort((a, b) => a.x.compareTo(b.x));

                      return spots;
                    }(),
                    isCurved: false,
                    color: colorScheme.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (
                        spot,
                        percent,
                        barData,
                        index,
                      ) =>
                          FlDotCirclePainter(
                        radius: 6,
                        color: colorScheme.primary,
                        strokeWidth: 2,
                        strokeColor: colorScheme.surface,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: colorScheme.primary.withValues(alpha: 0.1),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        final date = DateTime.fromMillisecondsSinceEpoch(
                            touchedSpot.x.toInt());
                        return LineTooltipItem(
                          '${touchedSpot.y.toInt()} commandes\n${date.day}/${date.month}/${date.year}',
                          TextStyle(color: colorScheme.onSurface),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(10),
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(10),
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(10),
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

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(10),
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
              variantType: TextVariantType.displaySmall,
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
                                  borderRadius: BorderRadius.circular(10),
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
