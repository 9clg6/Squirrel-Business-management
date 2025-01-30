import 'package:init/domain/entities/order.entity.dart';
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

}
