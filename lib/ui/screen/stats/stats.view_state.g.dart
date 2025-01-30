// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StatsScreenStateCWProxy {
  StatsScreenState loading(bool? loading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StatsScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StatsScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  StatsScreenState call({
    bool? loading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStatsScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStatsScreenState.copyWith.fieldName(...)`
class _$StatsScreenStateCWProxyImpl implements _$StatsScreenStateCWProxy {
  const _$StatsScreenStateCWProxyImpl(this._value);

  final StatsScreenState _value;

  @override
  StatsScreenState loading(bool? loading) => this(loading: loading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StatsScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StatsScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  StatsScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
  }) {
    return StatsScreenState(
      loading == const $CopyWithPlaceholder()
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool?,
    );
  }
}

extension $StatsScreenStateCopyWith on StatsScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfStatsScreenState.copyWith(...)` or like so:`instanceOfStatsScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StatsScreenStateCWProxy get copyWith => _$StatsScreenStateCWProxyImpl(this);
}
