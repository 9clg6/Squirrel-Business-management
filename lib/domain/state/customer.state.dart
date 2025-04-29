import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';

part 'customer.state.g.dart';

/// [CustomerState]
@CopyWith()
class CustomerState with EquatableMixin {
  /// Constructor
  /// @param customers: List<Customer>
  ///
  CustomerState({
    this.customers = const <Customer>[],
  });

  /// Initial
  /// @param customers: List<Customer>
  ///
  CustomerState.initial({
    this.customers = const <Customer>[],
  });

  /// Customers
  final List<Customer> customers;

  /// Props
  @override
  List<Object?> get props => <Object?>[
        customers,
      ];
}
