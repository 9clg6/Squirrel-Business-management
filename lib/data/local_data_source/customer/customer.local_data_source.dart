import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/use_case/params/save_clients.param.dart';

/// Customer local data source
abstract class CustomerLocalDataSource {
  /// Get customers from local
  Future<List<Customer>?> getCustomersFromLocal();

  /// Save customers
  Future<void> saveCustomers(SaveCustomersParam customers);
}
