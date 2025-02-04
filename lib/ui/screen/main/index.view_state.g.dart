// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$IndexScreenStateCWProxy {
  IndexScreenState loading(bool loading);

  IndexScreenState orderState(OrderState orderState);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IndexScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IndexScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  IndexScreenState call({
    bool? loading,
    OrderState? orderState,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfIndexScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfIndexScreenState.copyWith.fieldName(...)`
class _$IndexScreenStateCWProxyImpl implements _$IndexScreenStateCWProxy {
  const _$IndexScreenStateCWProxyImpl(this._value);

  final IndexScreenState _value;

  @override
  IndexScreenState loading(bool loading) => this(loading: loading);

  @override
  IndexScreenState orderState(OrderState orderState) =>
      this(orderState: orderState);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `IndexScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// IndexScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  IndexScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
    Object? orderState = const $CopyWithPlaceholder(),
  }) {
    return IndexScreenState(
      loading == const $CopyWithPlaceholder() || loading == null
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool,
      orderState == const $CopyWithPlaceholder() || orderState == null
          ? _value.orderState
          // ignore: cast_nullable_to_non_nullable
          : orderState as OrderState,
    );
  }
}

extension $IndexScreenStateCopyWith on IndexScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfIndexScreenState.copyWith(...)` or like so:`instanceOfIndexScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$IndexScreenStateCWProxy get copyWith => _$IndexScreenStateCWProxyImpl(this);
}
