import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/service/logger.service.dart';
import 'package:squirrel/domain/state/customer.state.dart';
import 'package:squirrel/foundation/interfaces/storage.interface.dart';

part 'customer.service.g.dart';

/// [CustomerService]
@Riverpod(keepAlive: true)
class CustomerService extends _$CustomerService {
  /// Storage
  late final StorageInterface<dynamic> _storage;

  /// Storage key
  static const String _storageKey = 'customers';

  bool _isInitialized = false;

  /// Build
  ///
  @override
  Future<CustomerState> build() async {
    if (!_isInitialized) {
      LoggerService.instance.i('🔌 Initializing CustomerService');
      _storage = ref.watch(hiveSecureStorageServiceProvider.notifier);
      _isInitialized = true;
    }

    return _loadCustomersFromLocal();
  }

  /// Load customers
  ///
  Future<CustomerState> _loadCustomersFromLocal() async {
    LoggerService.instance.i('📚 Loading customers');
    final String? o = await _storage.get(_storageKey) as String?;
    if (o != null) {
      final List<dynamic> customers = jsonDecode(o) as List<dynamic>;

      return CustomerState.initial(
        customers: customers
            .map((dynamic e) => Customer.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }
    return CustomerState.initial();
  }

  /// Load customers
  /// @param [customers] customers
  /// @return [void] void
  ///
  void loadCustomers(List<Customer> customers) {
    state = AsyncData<CustomerState>(
      state.value!.copyWith(customers: customers),
    );
    _save(state.requireValue);
  }

  /// Save customers
  /// @param [os] customer state
  ///
  void _save(CustomerState os) {
    LoggerService.instance.i('📚💾 Saving customers');
    if (os.customers.isEmpty) return;
    _storage.set(
      _storageKey,
      jsonEncode(
        os.customers
            .map(
              (Customer e) => e.toJson(),
            )
            .toList(),
      ),
    );
  }

  /// Get customer by id
  /// @param [id] id
  /// @return [Customer] customer
  ///
  Customer getcustomerById(String id) {
    return state.value!.customers
        .firstWhere((Customer customer) => customer.id == id);
  }

  /// Get customer by name or create
  /// @param [customerContact] customer contact
  /// @return [Customer] customer
  ///
  Customer? getCustomerByName(String customerContact) {
    return state.value!.customers.firstWhereOrNull(
      (Customer customer) =>
          customer.name.toLowerCase().trim() ==
          customerContact.toLowerCase().trim(),
    );
  }

  /// Create customer with order
  /// @param [customerName] customer
  /// @param [order] order
  /// @return [Customer] customer
  ///
  Customer createCustomerWithOrder(String customerName, Order order) {
    final Customer customer = Customer(
      name: customerName.trim(),
      orderQuantity: 1,
      orderTotalAmount: order.price,
      commissionTotalAmount: order.commission,
      firstOrderDate: order.startDate,
    );

    state = AsyncData<CustomerState>(
      state.value!.copyWith(
        customers: <Customer>[
          ...state.value!.customers,
          customer,
        ],
      ),
    );

    if (order.sponsor != null) {
      final Customer? sponsor = getCustomerByName(order.sponsor!);
      if (sponsor != null) {
        final Customer updatedSponsor = sponsor.copyWith(
          sponsorshipQuantity: sponsor.sponsorshipQuantity + 1,
        );

        final int sponsorIndex = state.value!.customers
            .indexWhere((Customer c) => c.id == sponsor.id);

        state = AsyncData<CustomerState>(
          state.value!.copyWith(
            customers: <Customer>[
              ...state.value!.customers.take(sponsorIndex),
              updatedSponsor,
              ...state.value!.customers.skip(sponsorIndex + 1),
            ],
          ),
        );
      }
    }

    _save(state.value!);

    return customer;
  }

  /// Update customer with new order information
  /// @param [customer] customer to update
  /// @param [newVersion] new version of customer
  /// @throws StateError if customer is not found
  ///
  void updateCustomer(
    Customer customer, {
    required Customer newVersion,
  }) {
    final int customerIndex = state.value!.customers.indexWhere(
      (Customer c) => c.id == customer.id,
    );

    if (customerIndex == -1) {
      throw StateError('Customer with id ${customer.id} not found');
    }

    state = AsyncData<CustomerState>(
      state.value!.copyWith(
        customers: <Customer>[
          ...state.value!.customers.take(customerIndex),
          newVersion,
          ...state.value!.customers.skip(customerIndex + 1),
        ],
      ),
    );

    _save(state.value!);
  }

  /// Update customer with new order information
  /// @param [customer] customer to update
  /// @param [order] order to add to customer statistics
  /// @throws StateError if customer is not found
  ///
  void updateCustomerWithOrder(
    Customer customer, {
    required Order order,
    required bool isNewOrder,
  }) {
    final int customerIndex = state.value!.customers.indexWhere(
      (Customer c) => c.id == customer.id,
    );

    if (customerIndex == -1) {
      throw StateError('Customer with id ${customer.id} not found');
    }

    final Customer customerTemp = state.value!.customers[customerIndex];
    final DateTime newLastOrderDate = order.startDate.isAfter(
      customerTemp.lastOrderDate ?? DateTime.fromMillisecondsSinceEpoch(0),
    )
        ? order.startDate
        : customerTemp.lastOrderDate ?? order.startDate;

    final Customer customerUpdated = customerTemp.copyWith(
      orderQuantity: isNewOrder
          ? customerTemp.orderQuantity + 1
          : customerTemp.orderQuantity,
      orderTotalAmount: isNewOrder
          ? customerTemp.orderTotalAmount + order.price
          : customerTemp.orderTotalAmount,
      commissionTotalAmount: isNewOrder
          ? customerTemp.commissionTotalAmount + order.commission
          : customerTemp.commissionTotalAmount,
      lastOrderDate: newLastOrderDate,
    );

    state = AsyncData<CustomerState>(
      state.value!.copyWith(
        customers: <Customer>[
          ...state.value!.customers.take(customerIndex),
          customerUpdated,
          ...state.value!.customers.skip(customerIndex + 1),
        ],
      ),
    );

    if (order.sponsor != null) {
      final Customer? sponsor = getCustomerByName(order.sponsor!);
      if (sponsor != null) {
        final Customer updatedSponsor = sponsor.copyWith(
          sponsorshipQuantity: sponsor.sponsorshipQuantity + 1,
        );

        final int sponsorIndex = state.value!.customers
            .indexWhere((Customer c) => c.id == sponsor.id);
        state = AsyncData<CustomerState>(
          state.value!.copyWith(
            customers: <Customer>[
              ...state.value!.customers.take(sponsorIndex),
              updatedSponsor,
              ...state.value!.customers.skip(sponsorIndex + 1),
            ],
          ),
        );
      }
    }

    _save(state.value!);
  }
}
