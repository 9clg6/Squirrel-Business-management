import 'package:init/domain/entities/order.entity.dart';
import 'package:init/foundation/enums/headers.enum.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/ui/screen/main/index.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'index.view_model.g.dart';

///
/// [Index]
///
@riverpod
class Index extends _$Index {
  ///
  /// Constructor
  ///
  factory Index() {
    return Index._();
  }

  ///
  /// Private constructor
  ///
  Index._();

  ///
  /// Build
  ///
  @override
  IndexScreenState build() {
    // Initialize state here instead of constructor
    return IndexScreenState.initial().copyWith(
      loading: false,
      orders: [
        Order(
          clientContact: 'Jean',
          intermediaryContact: 'Boxer 1',
          internalProcessingFee: 35,
          trackId: '1234567890',
          orderNumber: 'shop-ordreId',
          priority: 0,
          startDate: DateTime(2025, 1, 30),
          estimatedDuration: const Duration(days: 30),
          shopName: 'Amazon',
          price: 1500,
          commissionRatio: .30,
          status: OrderStatus.pending,
          technique: 'FTID MR QR',
        ),
        Order(
          clientContact: 'Louis',
          intermediaryContact: 'Boxer 2',
          internalProcessingFee: 35,
          trackId: '1234567890',
          orderNumber: 'shop-ordreId',
          priority: 0,
          startDate: DateTime(2025, 1, 31),
          estimatedDuration: const Duration(days: 30),
          shopName: 'Zalando',
          price: 800,
          commissionRatio: .30,
          status: OrderStatus.running,
          technique: 'FTID MR QR',
        ),
      ],
    );
  }


  /// Pin order
  void pinOrder(Order order) {
    if (state.pinnedOrders.contains(order)) {
      unpinOrder(order);
    } else {
      state = state.copyWith(
        pinnedOrders: [
          ...state.pinnedOrders,
          order,
        ],
        orders: [
          ...state.orders.where((e) => e != order),
        ],
      );
    }
  }

  /// Unpin order
  ///
  void unpinOrder(Order order) {
    state = state.copyWith(
      pinnedOrders: state.pinnedOrders.where((e) => e != order).toList(),
      orders: [
        ...state.orders,
        order,
      ],
    );
  }

  /// Select order
  ///
  void selectOrder(Order? order) {
    if (order == null) return;
    if (state.selectedOrders.contains(order)) {
      state = state.copyWith(
        selectedOrders: state.selectedOrders..remove(order),
      );
    } else {
      state = state.copyWith(
        selectedOrders: [...state.selectedOrders, order],
      );
    }
  }

  void selectAll() {
    if (state.selectedOrders.length == state.orders.length) {
      unselectOrder();
    } else {
      state = state.copyWith(
        selectedOrders: state.orders,
      );
    }
  }

  ///
  /// Unselect order
  ///
  void unselectOrder() {
    state = state.copyWith(
      selectedOrders: [],
    );
  }

  void deleteSelectedOrders() {
    state = state.copyWith(
      orders: [
        ...state.orders.where(
          (e) => !state.selectedOrders.contains(e),
        ),
      ],
      selectedOrders: [],
    );
  }

  void showComboBox() {
    final newComboBoxState = !state.showComboBox;
    state = state.copyWith(
      showComboBox: newComboBoxState,
    );
    if (!newComboBoxState) {
      state = state.copyWith(
        selectedOrders: [],
      );
    }
  }

  /// Sort orders
  ///
  void sortOrders(int columnIndex, bool ascending) {
    final Headers selectedHeader = Headers.values[columnIndex];
    final orders = state.orders;
    orders.sort((a, b) {
      switch (selectedHeader) {
        case Headers.client:
          return ascending
              ? a.clientContact.compareTo(b.clientContact)
              : b.clientContact.compareTo(a.clientContact);
        case Headers.status:
          return ascending
              ? a.status.index.compareTo(b.status.index)
              : b.status.index.compareTo(a.status.index);
        case Headers.store:
          return ascending
              ? a.shopName.compareTo(b.shopName)
              : b.shopName.compareTo(a.shopName);
        case Headers.startDate:
          return ascending
              ? a.startDate.compareTo(b.startDate)
              : b.startDate.compareTo(a.startDate);
        case Headers.endDate:
          return ascending
              ? a.endDate!.compareTo(b.endDate!)
              : b.endDate!.compareTo(a.endDate!);
        case Headers.price:
          return ascending
              ? a.price.compareTo(b.price)
              : b.price.compareTo(a.price);
        case Headers.commission:
          return ascending
              ? a.commission.compareTo(b.commission)
              : b.commission.compareTo(a.commission);
        default:
          return 0;
      }
    });
    state = state.copyWith(
      orders: orders,
      sortColumnIndex: columnIndex,
      sortAscending: ascending,
    );
  }
}
