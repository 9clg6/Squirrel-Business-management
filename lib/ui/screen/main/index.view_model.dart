import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/ui/screen/main/index.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'index.view_model.g.dart';

///
/// [Index]
///
@riverpod
class Index extends _$Index {
  late final OrderService _orderService;

  /// Constructor
  ///
  Index() {
    _orderService = injector<OrderService>();
  }

  /// Build
  ///
  @override
  IndexScreenState build() {
    _orderService.orderState.addListener(() {
      state = IndexScreenState(
        false,
        _orderService.orderState.value,
      );
    });

    return IndexScreenState(false, _orderService.orderState.value);
  }

  /// Pin order
  ///
  void pinOrder(Order order) {
    _orderService.pinOrder(order);
  }

  /// Delete selected orders
  ///
  void deleteSelectedOrders() {
    _orderService.deleteSelectedOrders();
  }

  /// Show combo box
  ///
  void showComboBox() {
    _orderService.showComboBox();
  }

  /// Select all
  ///
  void selectAll() {
    _orderService.selectAll();
  }

  /// Sort orders
  ///
  void sortOrders(int columnIndex, bool ascending) {
    _orderService.sortOrders(columnIndex, ascending);
  }

  /// Select order
  ///
  void selectOrder(Order order) {
    _orderService.selectOrder(order);
  }
}
