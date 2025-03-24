// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthScreenStateCWProxy {
  AuthScreenState loading(bool loading);

  AuthScreenState isRequestLoading(bool isRequestLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthScreenState call({
    bool? loading,
    bool? isRequestLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthScreenState.copyWith.fieldName(...)`
class _$AuthScreenStateCWProxyImpl implements _$AuthScreenStateCWProxy {
  const _$AuthScreenStateCWProxyImpl(this._value);

  final AuthScreenState _value;

  @override
  AuthScreenState loading(bool loading) => this(loading: loading);

  @override
  AuthScreenState isRequestLoading(bool isRequestLoading) =>
      this(isRequestLoading: isRequestLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
    Object? isRequestLoading = const $CopyWithPlaceholder(),
  }) {
    return AuthScreenState(
      loading: loading == const $CopyWithPlaceholder() || loading == null
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool,
      isRequestLoading: isRequestLoading == const $CopyWithPlaceholder() ||
              isRequestLoading == null
          ? _value.isRequestLoading
          // ignore: cast_nullable_to_non_nullable
          : isRequestLoading as bool,
    );
  }
}

extension $AuthScreenStateCopyWith on AuthScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfAuthScreenState.copyWith(...)` or like so:`instanceOfAuthScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthScreenStateCWProxy get copyWith => _$AuthScreenStateCWProxyImpl(this);
}
