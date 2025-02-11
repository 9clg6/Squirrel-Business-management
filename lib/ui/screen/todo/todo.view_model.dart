import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/domain/service/navigator.service.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/ui/screen/todo/todo.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo.view_model.g.dart';

///
/// [TodoViewModel]
///
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

  ///
  /// Build
  ///
  @override
  TodoScreenState build() {
    _orderService.orderState.addListener(() {
      state = TodoScreenState(
        false,
        _orderService.orderState.value,
      );
    });

    return TodoScreenState(
      false,
      _orderService.orderState.value,
    );
  }

  ///
  /// Init
  ///
  Future<void> init() async {}

  /// Navigate to details
  ///
  void navigateToDetails(Order order) {
    _navigatorService.navigateToDetails(order);
  }

  /// Update order status
  ///
  void updateOrderStatus(Order data, OrderStatus status) {
    _orderService.updateOrderStatus(data, status);
  }
}
