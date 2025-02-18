import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/domain/state/order.state.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/ui/screen/history/history.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history.view_model.g.dart';

///
/// [History]
///
@riverpod
class History extends _$History {
  late OrderService _orderService;

  /// Build
  ///
  @override
  HistoryState build() {
    _orderService = injector<OrderService>();

    _orderService.addListener((s) {
      state = _mapOrderStateToHistoryState(s);
    });

    return _mapOrderStateToHistoryState(_orderService.orderState);
  }

  HistoryState _mapOrderStateToHistoryState(OrderState orderState) {
    return HistoryState(
      loading: false,
      orders: orderState.allOrder
          .where((order) => [
                OrderStatus.canceled,
                OrderStatus.failed,
                OrderStatus.finished,
              ].contains(order.status))
          .toList(),
    );
  }
}
