import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/service/customer.service.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/state/customer.state.dart';
import 'package:squirrel/foundation/providers/service/dialog.service.provider.dart';
import 'package:squirrel/ui/screen/customers/customers.view_state.dart';

part 'customers.view_model.g.dart';

/// [Customers]
@Riverpod(keepAlive: true)
class Customers extends _$Customers {
  bool _isInitialized = false;
  late final DialogService _dialogService;

  /// Build
  ///
  @override
  CustomersScreenState build() {
    if (!_isInitialized) {
      _dialogService = ref.watch(dialogServiceProvider);
      _isInitialized = true;
    }

    ref.listen(customerServiceProvider, (_, AsyncValue<CustomerState> next) {
      _onCustomerStateChanged(next.value!);
    });

    return CustomersScreenState.initial(
      ref.watch(customerServiceProvider).value!.customers,
    );
  }

  /// Gestionnaire de changement d'état
  /// @param s : [CustomerState]
  ///
  void _onCustomerStateChanged(CustomerState s) {
    state = state.copyWith(
      customers: s.customers,
    );
  }

  /// Select customer
  /// @param key : [String]
  ///
  Future<void> selectCustomer(Customer key) async {
    await _dialogService.showCustomerDetailsDialog(key);
  }
}
