import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/repositories/customer.repository.dart';
import 'package:squirrel/domain/use_case/params/save_clients.param.dart';
import 'package:squirrel/domain/use_case/save_customers.use_case.dart';
import 'package:squirrel/foundation/providers/repositories/customer.repository.provider.dart';

part 'save_customer.use_case.provider.g.dart';

/// Save customer use case
@riverpod
Future<void> saveCustomersUseCase(
  Ref ref, {
  required SaveCustomersParam param,
}) async {
  final CustomerRepository repository =
      await ref.watch(customerRepositoryProvider.future);

  return SaveCustomersUseCase(customerRepository: repository).invoke(param);
}
