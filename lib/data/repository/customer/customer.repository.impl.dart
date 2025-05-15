import 'package:squirrel/data/local_data_source/customer/customer.local_data_source.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/repositories/customer.repository.dart';
import 'package:squirrel/domain/use_case/params/save_clients.param.dart';

/// Customer repository
class CustomerRepositoryImpl implements CustomerRepository {
  /// Constructor
  /// @param customerLocalDataSource : customer local data source from provider
  ///
  CustomerRepositoryImpl({
    required CustomerLocalDataSource customerLocalDataSource,
  }) : _customerLocalDataSource = customerLocalDataSource;

  /// Customer local data source
  final CustomerLocalDataSource _customerLocalDataSource;

  /// Get customers from local
  /// @return customers
  @override
  Future<List<Customer>?> getCustomersFromLocal() async {
    final List<Customer>? localCustomers =
        await _customerLocalDataSource.getCustomersFromLocal();

    return localCustomers;
  }

  /// Save customers in local storage
  /// @param customers : customers to save
  @override
  Future<void> saveCustomers(SaveCustomersParam customers) {
    return _customerLocalDataSource.saveCustomers(customers);
  }
}
