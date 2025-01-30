// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HistoryScreenStateCWProxy {
  HistoryScreenState loading(bool? loading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HistoryScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HistoryScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  HistoryScreenState call({
    bool? loading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHistoryScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHistoryScreenState.copyWith.fieldName(...)`
class _$HistoryScreenStateCWProxyImpl implements _$HistoryScreenStateCWProxy {
  const _$HistoryScreenStateCWProxyImpl(this._value);

  final HistoryScreenState _value;

  @override
  HistoryScreenState loading(bool? loading) => this(loading: loading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HistoryScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HistoryScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  HistoryScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
  }) {
    return HistoryScreenState(
      loading == const $CopyWithPlaceholder()
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool?,
    );
  }
}

extension $HistoryScreenStateCopyWith on HistoryScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfHistoryScreenState.copyWith(...)` or like so:`instanceOfHistoryScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HistoryScreenStateCWProxy get copyWith =>
      _$HistoryScreenStateCWProxyImpl(this);
}
