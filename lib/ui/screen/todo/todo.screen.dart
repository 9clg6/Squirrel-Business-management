import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/foundation/enums/priority.enum.dart';
import 'package:init/ui/screen/todo/todo.view_model.dart';

///
/// Second screen
///
class TodoScreen extends ConsumerStatefulWidget {
  ///
  /// Constructor
  ///
  const TodoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoScreenState();
}

///
/// State of the second screen
///
class _TodoScreenState extends ConsumerState<TodoScreen> {
  Map<OrderStatus, double> columnPosition = {};

  ///
  /// Builds the second screen
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final orderStatusLength = OrderStatus.values.length;
    const double paddingWidth = 8;
    final TodoViewModel viewModel = ref.read(todoViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height / 2,
          ),
          padding: const EdgeInsets.all(10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double parentSize = constraints.maxWidth;

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: orderStatusLength,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: paddingWidth),
                itemBuilder: (_, int index) {
                  final status = OrderStatus.values[index];

                  return TodoStatusColumn(
                    parentSize: parentSize,
                    orderStatusLength: orderStatusLength,
                    paddingWidth: paddingWidth,
                    colorScheme: colorScheme,
                    viewModel: viewModel,
                    status: status,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class TodoStatusColumn extends ConsumerWidget {
  const TodoStatusColumn({
    super.key,
    required this.parentSize,
    required this.orderStatusLength,
    required this.paddingWidth,
    required this.colorScheme,
    required this.viewModel,
    required this.status,
  });

  final double parentSize;
  final int orderStatusLength;
  final double paddingWidth;
  final ColorScheme colorScheme;
  final TodoViewModel viewModel;
  final OrderStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoViewModelProvider);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: (parentSize / orderStatusLength) - paddingWidth,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: .2),
          width: 1,
        ),
      ),
      child: DragTarget<Order>(
        onAcceptWithDetails: (data) {
          viewModel.updateOrderStatus(
            data.data,
            status,
          );
        },
        builder: (context, candidateData, rejectedData) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      status.name,
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Divider(
                  color: colorScheme.outline,
                  height: 24,
                  thickness: 0.5,
                ),
                ...state.orderState.allOrder
                    .where((o) => o.status == status)
                    .map(
                      (e) => TodoItem(
                        status: status,
                        order: e,
                      ),
                    )
              ],
            ),
          );
        },
      ),
    );
  }
}

class TodoItem extends ConsumerWidget {
  const TodoItem({
    super.key,
    required this.status,
    required this.order,
  });

  final OrderStatus status;
  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final viewModel = ref.read(todoViewModelProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: () {
            viewModel.navigateToDetails(order);
          },
          child: Draggable<Order>(
            data: order,
            childWhenDragging: Container(),
            feedback: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: status.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(order.shopName),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: order.priority == Priority.high ? 12 : 24,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: status.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (order.priority == Priority.high)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.priority_high,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.shopName,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        order.clientContact,
                        style: textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
