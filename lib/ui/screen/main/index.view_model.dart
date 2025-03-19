import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/domain/service/order.service.dart';
import 'package:squirrel/ui/screen/main/index.view_state.dart';

part 'index.view_model.g.dart';

///
/// [Index]
///
@riverpod
class Index extends _$Index {
  late final OrderService _orderService;
  late final NavigatorService _navigatorService;
  late final DialogService _dialogService;

  /// Constructor
  ///
  Index() {
    _orderService = injector<OrderService>();
    _navigatorService = injector<NavigatorService>();
    _dialogService = injector<DialogService>();
  }

  /// Build
  ///
  @override
  IndexScreenState build() {
    _orderService.addListener((s) {
      state = IndexScreenState(false, s);
    });

    return IndexScreenState(
      false,
      _orderService.orderState,
    );
  }

  /// Pin order
  /// @param [order] order
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
  /// @param [columnIndex] column index
  /// @param [ascending] ascending
  ///
  void sortOrders(int columnIndex, bool ascending) {
    _orderService.sortOrders(columnIndex, ascending);
  }

  /// Select order
  /// @param [order] order
  ///
  void selectOrder(Order order) {
    _orderService.selectOrder(order);
  }

  /// Navigate to details
  /// @param [order] order
  ///
  void navigateToDetails(Order order) {
    _navigatorService.navigateToDetails(order);
  }

  /// Create order
  ///
  Future<void> createOrder() async {
    final Order? order = await _dialogService.showEditOrderDialog(
      order: Order.empty(),
      isCreation: true,
    );
    
    if (order != null) {
      _orderService.addOrder(order);
    }
  }
}
