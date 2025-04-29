import 'package:squirrel/domain/entities/customer.entity.dart';

/// Save Customers Param
final class SaveCustomersParam {
  /// Constructor
  /// @param customers : list of customers
  ///
  SaveCustomersParam(this.customers);

  /// List of customers
  List<Customer> customers;
}
