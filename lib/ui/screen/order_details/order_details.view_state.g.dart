// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderDetailsScreenStateCWProxy {
  OrderDetailsScreenState loading(bool? loading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderDetailsScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderDetailsScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderDetailsScreenState call({
    bool? loading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderDetailsScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderDetailsScreenState.copyWith.fieldName(...)`
class _$OrderDetailsScreenStateCWProxyImpl
    implements _$OrderDetailsScreenStateCWProxy {
  const _$OrderDetailsScreenStateCWProxyImpl(this._value);

  final OrderDetailsScreenState _value;

  @override
  OrderDetailsScreenState loading(bool? loading) => this(loading: loading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderDetailsScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderDetailsScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderDetailsScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
  }) {
    return OrderDetailsScreenState(
      loading == const $CopyWithPlaceholder()
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool?,
    );
  }
}

extension $OrderDetailsScreenStateCopyWith on OrderDetailsScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfOrderDetailsScreenState.copyWith(...)` or like so:`instanceOfOrderDetailsScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderDetailsScreenStateCWProxy get copyWith =>
      _$OrderDetailsScreenStateCWProxyImpl(this);
}
