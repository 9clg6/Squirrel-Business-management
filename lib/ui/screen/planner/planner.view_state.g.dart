// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PlannerScreenStateCWProxy {
  PlannerScreenState loading(bool? loading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlannerScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlannerScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  PlannerScreenState call({
    bool? loading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPlannerScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPlannerScreenState.copyWith.fieldName(...)`
class _$PlannerScreenStateCWProxyImpl implements _$PlannerScreenStateCWProxy {
  const _$PlannerScreenStateCWProxyImpl(this._value);

  final PlannerScreenState _value;

  @override
  PlannerScreenState loading(bool? loading) => this(loading: loading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PlannerScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PlannerScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  PlannerScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
  }) {
    return PlannerScreenState(
      loading: loading == const $CopyWithPlaceholder()
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool?,
    );
  }
}

extension $PlannerScreenStateCopyWith on PlannerScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfPlannerScreenState.copyWith(...)` or like so:`instanceOfPlannerScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PlannerScreenStateCWProxy get copyWith =>
      _$PlannerScreenStateCWProxyImpl(this);
}
