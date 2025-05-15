import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/repositories/customer.repository.dart';
import 'package:squirrel/domain/use_case/future.usecases.dart';

/// Load customers use case
class GetLocalCustomersUseCase extends FutureUseCase<List<Customer>?> {
  /// Constructor
  /// @param customerRepository : customer repository
  ///
  GetLocalCustomersUseCase({required this.customerRepository});

  /// Customers repo
  final CustomerRepository customerRepository;

  /// Invoke use case
  @override
  Future<List<Customer>?> invoke() {
    return customerRepository.getCustomersFromLocal();
  }
}
