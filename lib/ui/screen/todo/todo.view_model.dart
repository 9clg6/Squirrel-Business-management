import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/ui/screen/todo/todo.view_state.dart';

part 'todo.view_model.g.dart';

/// [TodoViewModel]
@Riverpod(
  keepAlive: true,
)
class TodoViewModel extends _$TodoViewModel {
  bool _isInitialized = false;
  late final NavigatorService _navigatorService;
  late final OrderService _orderService;

  /// Build
  ///
  @override
  Future<TodoScreenState> build() async {
    if (!_isInitialized) {
      _navigatorService = ref.watch(navigatorServiceProvider.notifier);
      _orderService = ref.watch(orderServiceProvider.notifier);
      _isInitialized = true;
    }

    ref.listen(orderServiceProvider, (_, AsyncValue<OrderState> next) {
      _updateState(next.value!);
    });

    return TodoScreenState.initial(
      (await ref.watch(orderServiceProvider.future)).orders,
      loading: ref.watch(orderServiceProvider).value!.isLoading,
    );
  }

  /// Navigate to details
  /// @param [order] order
  ///
  void navigateToDetails(Order order) {
    _navigatorService.navigateToDetails(order);
  }

  /// Update order status
  /// @param [data] data
  /// @param [status] status
  ///
  void updateOrderStatus(Order data, OrderStatus status) {
    if (data.status == status) return;

    _orderService.updateOrderStatus(data, status);
  }

  /// Update state
  /// @param [orderState] order state
  ///
  void _updateState(OrderState orderState) {
    state = AsyncData<TodoScreenState>(
      state.value!.copyWith(
        orders: orderState.orders,
      ),
    );
  }
}
