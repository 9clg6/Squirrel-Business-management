// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RequestViewStateCWProxy {
  RequestViewState loading(bool loading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestViewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestViewState(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestViewState call({
    bool? loading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRequestViewState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRequestViewState.copyWith.fieldName(...)`
class _$RequestViewStateCWProxyImpl implements _$RequestViewStateCWProxy {
  const _$RequestViewStateCWProxyImpl(this._value);

  final RequestViewState _value;

  @override
  RequestViewState loading(bool loading) => this(loading: loading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RequestViewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RequestViewState(...).copyWith(id: 12, name: "My name")
  /// ````
  RequestViewState call({
    Object? loading = const $CopyWithPlaceholder(),
  }) {
    return RequestViewState(
      loading: loading == const $CopyWithPlaceholder() || loading == null
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool,
    );
  }
}

extension $RequestViewStateCopyWith on RequestViewState {
  /// Returns a callable class that can be used as follows: `instanceOfRequestViewState.copyWith(...)` or like so:`instanceOfRequestViewState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RequestViewStateCWProxy get copyWith => _$RequestViewStateCWProxyImpl(this);
}
