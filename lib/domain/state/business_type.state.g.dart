// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_type.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BusinessTypeStateCWProxy {
  BusinessTypeState businessType(BusinessType businessType);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessTypeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessTypeState(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessTypeState call({
    BusinessType? businessType,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBusinessTypeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBusinessTypeState.copyWith.fieldName(...)`
class _$BusinessTypeStateCWProxyImpl implements _$BusinessTypeStateCWProxy {
  const _$BusinessTypeStateCWProxyImpl(this._value);

  final BusinessTypeState _value;

  @override
  BusinessTypeState businessType(BusinessType businessType) =>
      this(businessType: businessType);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BusinessTypeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BusinessTypeState(...).copyWith(id: 12, name: "My name")
  /// ````
  BusinessTypeState call({
    Object? businessType = const $CopyWithPlaceholder(),
  }) {
    return BusinessTypeState(
      businessType:
          businessType == const $CopyWithPlaceholder() || businessType == null
              ? _value.businessType
              // ignore: cast_nullable_to_non_nullable
              : businessType as BusinessType,
    );
  }
}

extension $BusinessTypeStateCopyWith on BusinessTypeState {
  /// Returns a callable class that can be used as follows: `instanceOfBusinessTypeState.copyWith(...)` or like so:`instanceOfBusinessTypeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BusinessTypeStateCWProxy get copyWith =>
      _$BusinessTypeStateCWProxyImpl(this);
}
