import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/ui/screen/todo/todo.view_state.dart';

part 'todo.view_model.g.dart';

/// [TodoViewModel]
@riverpod
class TodoViewModel extends _$TodoViewModel {
  /// Order service
  late final OrderService _orderService;

  /// Navigator service
  late final NavigatorService _navigatorService;

  /// Constructor
  ///
  factory TodoViewModel() {
    return TodoViewModel._();
  }

  /// Private constructor
  ///
  TodoViewModel._() {
    _orderService = injector<OrderService>();
    _navigatorService = injector<NavigatorService>();
  }

  /// Build
  ///
  @override
  TodoScreenState build() {
    _orderService.addListener((s) {
      state = TodoScreenState(false, s);
    });

    return TodoScreenState(
      false,
      _orderService.orderState,
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
    _orderService.updateOrderStatus(data, status);
  }
}
