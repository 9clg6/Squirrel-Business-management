// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomerStateCWProxy {
  CustomerState customers(List<Customer> customers);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomerState(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomerState call({
    List<Customer>? customers,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCustomerState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCustomerState.copyWith.fieldName(...)`
class _$CustomerStateCWProxyImpl implements _$CustomerStateCWProxy {
  const _$CustomerStateCWProxyImpl(this._value);

  final CustomerState _value;

  @override
  CustomerState customers(List<Customer> customers) =>
      this(customers: customers);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomerState(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomerState call({
    Object? customers = const $CopyWithPlaceholder(),
  }) {
    return CustomerState(
      customers: customers == const $CopyWithPlaceholder() || customers == null
          ? _value.customers
          // ignore: cast_nullable_to_non_nullable
          : customers as List<Customer>,
    );
  }
}

extension $CustomerStateCopyWith on CustomerState {
  /// Returns a callable class that can be used as follows: `instanceOfCustomerState.copyWith(...)` or like so:`instanceOfCustomerState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomerStateCWProxy get copyWith => _$CustomerStateCWProxyImpl(this);
}
