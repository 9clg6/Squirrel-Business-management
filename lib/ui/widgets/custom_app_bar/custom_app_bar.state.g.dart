// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_app_bar.state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CustomAppBarStateCWProxy {
  CustomAppBarState expirationDate(DateTime? expirationDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomAppBarState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomAppBarState(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomAppBarState call({
    DateTime? expirationDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCustomAppBarState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCustomAppBarState.copyWith.fieldName(...)`
class _$CustomAppBarStateCWProxyImpl implements _$CustomAppBarStateCWProxy {
  const _$CustomAppBarStateCWProxyImpl(this._value);

  final CustomAppBarState _value;

  @override
  CustomAppBarState expirationDate(DateTime? expirationDate) =>
      this(expirationDate: expirationDate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CustomAppBarState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CustomAppBarState(...).copyWith(id: 12, name: "My name")
  /// ````
  CustomAppBarState call({
    Object? expirationDate = const $CopyWithPlaceholder(),
  }) {
    return CustomAppBarState(
      expirationDate: expirationDate == const $CopyWithPlaceholder()
          ? _value.expirationDate
          // ignore: cast_nullable_to_non_nullable
          : expirationDate as DateTime?,
    );
  }
}

extension $CustomAppBarStateCopyWith on CustomAppBarState {
  /// Returns a callable class that can be used as follows: `instanceOfCustomAppBarState.copyWith(...)` or like so:`instanceOfCustomAppBarState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CustomAppBarStateCWProxy get copyWith =>
      _$CustomAppBarStateCWProxyImpl(this);
}
