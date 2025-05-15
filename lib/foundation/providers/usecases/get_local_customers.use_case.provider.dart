import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/repositories/customer.repository.dart';
import 'package:squirrel/domain/use_case/get_local_customers.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/customer.repository.provider.dart';

part 'get_local_customers.use_case.provider.g.dart';

/// Load customers use case
/// @paran ref : ref
@riverpod
Future<List<Customer>?> getLocalCustomersUseCase(Ref ref) async {
  final CustomerRepository customerRepository =
      await ref.watch(customerRepositoryProvider.future);

  return GetLocalCustomersUseCase(customerRepository: customerRepository)
      .invoke();
}
