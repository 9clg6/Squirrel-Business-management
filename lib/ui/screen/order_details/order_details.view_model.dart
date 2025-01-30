import 'package:init/ui/screen/order_details/order_details.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_details.view_model.g.dart';

///
/// [OrderDetailsViewModel]
///
@riverpod
class OrderDetailsViewModel extends _$OrderDetailsViewModel {
  ///
  /// Constructor
  ///
  factory OrderDetailsViewModel() {
    return OrderDetailsViewModel._();
  }

  ///
  /// Private constructor
  ///
  OrderDetailsViewModel._() {
    init();
  }

  ///
  /// Build
  ///
  @override
  OrderDetailsScreenState build() => OrderDetailsScreenState.initial();

  ///
  /// Init
  ///
  Future<void> init() async {}
}
