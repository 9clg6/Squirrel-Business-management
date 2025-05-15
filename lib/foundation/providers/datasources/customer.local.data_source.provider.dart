import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/customer/customer.local_data_source.dart';
import 'package:squirrel/data/local_data_source/customer/impl/customer.local_data_source.impl.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';

part 'customer.local.data_source.provider.g.dart';

/// Customer local data source
/// @param ref : ref
@riverpod
Future<CustomerLocalDataSource> customerLocalDataSource(Ref ref) async {
  final HiveSecureStorageService secureStorageService =
      await ref.watch(hiveSecureStorageServiceProvider.future);

  return CustomerLocalDataSourceImpl(storage: secureStorageService);
}
