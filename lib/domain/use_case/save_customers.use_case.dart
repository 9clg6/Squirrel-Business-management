import 'package:squirrel/domain/repositories/customer.repository.dart';
import 'package:squirrel/domain/use_case/future.usecases.dart';
import 'package:squirrel/domain/use_case/params/save_clients.param.dart';

/// Save Client Use Case
class SaveCustomersUseCase
    extends FutureUseCaseWithParams<void, SaveCustomersParam> {
  /// Constructor
  /// @param customersRepository : customers repo
  SaveCustomersUseCase({
    required this.customerRepository,
  });

  /// Customers repo
  final CustomerRepository customerRepository;

  /// Invoke
  ///
  @override
  Future<void> invoke(SaveCustomersParam params) {
    return customerRepository.saveCustomers(params);
  }
}
