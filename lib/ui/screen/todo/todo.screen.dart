import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/foundation/enums/priority.enum.dart';
import 'package:squirrel/ui/screen/todo/todo.view_model.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Todo screen
class TodoScreen extends ConsumerStatefulWidget {
  /// Constructor
  /// @param [key] key
  ///
  const TodoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoScreenState();
}

/// State of the todo screen
class _TodoScreenState extends ConsumerState<TodoScreen> {
  /// Column position
  Map<OrderStatus, double> columnPosition = {};

  /// Builds the todo screen
  /// @param [context] context
  /// @return [Widget] widget of the todo screen
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final orderStatusLength = OrderStatus.values.length;
    const double paddingWidth = 8;
    final TodoViewModel viewModel = ref.read(todoViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: Container(
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double parentSize = constraints.maxWidth;

            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: orderStatusLength,
              separatorBuilder: (_, __) => const SizedBox(width: paddingWidth),
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
    );
  }
}

/// Todo status column
class TodoStatusColumn extends ConsumerWidget {
  /// Parent size
  final double parentSize;

  /// Order status length
  final int orderStatusLength;

  /// Padding width
  final double paddingWidth;
  final ColorScheme colorScheme;

  /// View model
  final TodoViewModel viewModel;

  /// Status
  final OrderStatus status;

  /// Constructor
  /// @param [parentSize] parent size
  /// @param [orderStatusLength] order status length
  /// @param [paddingWidth] padding width
  /// @param [colorScheme] color scheme
  /// @param [viewModel] view model
  /// @param [status] status
  ///
  const TodoStatusColumn({
    super.key,
    required this.parentSize,
    required this.orderStatusLength,
    required this.paddingWidth,
    required this.colorScheme,
    required this.viewModel,
    required this.status,
  });

  /// Builds the todo status column
  /// @param [context] context
  /// @param [ref] ref
  /// @return [Widget] widget of the todo status column
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoViewModelProvider);

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
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                  child: Center(
                    child: TextVariant(
                      status.name,
                      variantType: TextVariantType.labelMedium,
                      fontWeight: FontWeight.w600,
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

/// Todo item
class TodoItem extends ConsumerWidget {
  /// Status
  final OrderStatus status;

  /// Order
  final Order order;

  /// Constructor
  /// @param [status] status
  /// @param [order] order
  ///
  const TodoItem({
    super.key,
    required this.status,
    required this.order,
  });

  /// Builds the todo item
  /// @param [context] context
  /// @param [ref] ref
  /// @return [Widget] widget of the todo item
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      TextVariant(
                        order.shopName,
                        variantType: TextVariantType.bodyMedium,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                      TextVariant(
                        order.client?.name ?? "",
                        variantType: TextVariantType.labelSmall,
                        fontWeight: FontWeight.w400,
                        color: colorScheme.onSurface,
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
