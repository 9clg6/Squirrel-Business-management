import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/use_case/params/save_clients.param.dart';

/// Customers repository
abstract class CustomerRepository {
  /// Get customers from local
  /// @return list of customers from local
  /// 
  Future<List<Customer>> getCustomersFromLocal();
  
  /// Save customers in local
  /// @param customers : list of customers
  /// 
  Future<void> saveCustomers(SaveCustomersParam customers);
}
