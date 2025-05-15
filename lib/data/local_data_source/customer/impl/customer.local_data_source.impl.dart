import 'dart:convert';

import 'package:squirrel/data/local_data_source/customer/customer.local_data_source.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/use_case/params/save_clients.param.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

/// Customer local data source impl
class CustomerLocalDataSourceImpl implements CustomerLocalDataSource {
  /// Constructor
  /// @param storage : storage interface
  ///
  CustomerLocalDataSourceImpl({required StorageInterface<dynamic> storage})
      : _storage = storage;

  /// Storage interface
  final StorageInterface<dynamic> _storage;

  /// Storage key
  static const String _storageKey = 'customers';

  /// Get customers from local
  /// @return list of customers
  ///
  @override
  Future<List<Customer>?> getCustomersFromLocal() async {
    final String? o = await _storage.get(_storageKey) as String?;
    if (o == null) return null;
    final List<dynamic> decoded = jsonDecode(o) as List<dynamic>;

    return decoded
        .map((dynamic e) => Customer.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Save customers in local storage
  /// @param customers: customers to save
  @override
  Future<void> saveCustomers(SaveCustomersParam customers) {
    return _storage.set(
      _storageKey,
      jsonEncode(
        customers.customers.map((Customer e) => e.toJson()).toList(),
      ),
    );
  }
}
