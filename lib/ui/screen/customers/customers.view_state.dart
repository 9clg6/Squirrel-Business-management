import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'customers.view_state.g.dart';

/// [CustomersScreenState]
@CopyWith(copyWithNull: true)
class CustomersScreenState extends ViewStateAbs {
  /// Constructor
  /// @param [selectedCustomer] selected customer
  /// @param [customers] customers
  ///
  CustomersScreenState({
    required this.selectedCustomer,
    required this.customers,
  });

  /// Initial state
  /// @param [customers] customers
  ///
  CustomersScreenState.initial(this.customers) : selectedCustomer = null;

  /// Selected customer
  final Customer? selectedCustomer;

  /// Clients
  final List<Customer> customers;

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        selectedCustomer,
        customers,
      ];
}
