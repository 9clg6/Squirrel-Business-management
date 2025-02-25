import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/ui/screen/history/history.view_state.dart';

part 'history.view_model.g.dart';

/// [History]
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

  /// Map order state to history state
  /// @param [orderState] order state
  /// @return [HistoryState] history state
  ///
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
