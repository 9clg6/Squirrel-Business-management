import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/customer/customer.local_data_source.dart';
import 'package:squirrel/data/repository/customer/customer.repository.impl.dart';
import 'package:squirrel/domain/repositories/customer.repository.dart';
import 'package:squirrel/foundation/providers/datasources/customer.local.data_source.provider.dart';

part 'customer.repository.provider.g.dart';

/// Customer repository
@riverpod
Future<CustomerRepository> customerRepository(Ref ref) async {
  final CustomerLocalDataSource localDataSource =
      await ref.watch(customerLocalDataSourceProvider.future);

  return CustomerRepositoryImpl(customerLocalDataSource: localDataSource);
}
