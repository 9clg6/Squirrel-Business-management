import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/service/navigator.service.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/ui/screen/todo/todo.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo.view_model.g.dart';

///
/// [TodoViewModel]
///
@riverpod
class TodoViewModel extends _$TodoViewModel {
  /// Order service
  late final OrderService orderService;

  /// Navigator service
  late final NavigatorService navigatorService;

  /// Constructor
  ///
  factory TodoViewModel() {
    return TodoViewModel._();
  }

  /// Private constructor
  ///
  TodoViewModel._() {
    orderService = injector<OrderService>();
    navigatorService = injector<NavigatorService>();
  }

  ///
  /// Build
  ///
  @override
  TodoScreenState build() {
    orderService.orderState.addListener(() {
      state = TodoScreenState(
        false,
        orderService.orderState.value,
      );
    });

    return TodoScreenState(
      false,
      orderService.orderState.value,
    );
  }

  ///
  /// Init
  ///
  Future<void> init() async {}
}
