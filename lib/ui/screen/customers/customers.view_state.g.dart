// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomersScreenStateCWProxy {
  CustomersScreenState selectedCustomer(Customer? selectedCustomer);

  CustomersScreenState customers(List<Customer> customers);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomersScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomersScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomersScreenState call({
    Customer? selectedCustomer,
    List<Customer>? customers,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCustomersScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCustomersScreenState.copyWith.fieldName(...)`
class _$CustomersScreenStateCWProxyImpl
    implements _$CustomersScreenStateCWProxy {
  const _$CustomersScreenStateCWProxyImpl(this._value);

  final CustomersScreenState _value;

  @override
  CustomersScreenState selectedCustomer(Customer? selectedCustomer) =>
      this(selectedCustomer: selectedCustomer);

  @override
  CustomersScreenState customers(List<Customer> customers) =>
      this(customers: customers);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomersScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomersScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomersScreenState call({
    Object? selectedCustomer = const $CopyWithPlaceholder(),
    Object? customers = const $CopyWithPlaceholder(),
  }) {
    return CustomersScreenState(
      selectedCustomer: selectedCustomer == const $CopyWithPlaceholder()
          ? _value.selectedCustomer
          // ignore: cast_nullable_to_non_nullable
          : selectedCustomer as Customer?,
      customers: customers == const $CopyWithPlaceholder() || customers == null
          ? _value.customers
          // ignore: cast_nullable_to_non_nullable
          : customers as List<Customer>,
    );
  }
}

extension $CustomersScreenStateCopyWith on CustomersScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfCustomersScreenState.copyWith(...)` or like so:`instanceOfCustomersScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomersScreenStateCWProxy get copyWith =>
      _$CustomersScreenStateCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `CustomersScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomersScreenState(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  CustomersScreenState copyWithNull({
    bool selectedCustomer = false,
  }) {
    return CustomersScreenState(
      selectedCustomer: selectedCustomer == true ? null : this.selectedCustomer,
      customers: customers,
    );
  }
}
