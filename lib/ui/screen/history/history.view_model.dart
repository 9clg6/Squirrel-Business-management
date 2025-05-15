import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/domain/state/order.state.dart';
import 'package:squirrel/ui/screen/history/history.view_state.dart';

part 'history.view_model.g.dart';

/// [History]
@Riverpod(
  keepAlive: true,
)
class History extends _$History {
  /// Build
  ///
  @override
  HistoryState build() {
    final AsyncValue<OrderState> state = ref.watch(orderServiceProvider);

    ref.listen(orderServiceProvider, (_, AsyncValue<OrderState> next) {
      _onOrderChange(next.value!);
    });

    return HistoryState.initial(state.value!.endedOrders);
  }

  /// On order change
  /// @param orderState [OrderState]
  ///
  void _onOrderChange(OrderState orderState) {
    state = state.copyWith(
      orders: orderState.endedOrders,
    );
  }
}
