// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TodoScreenStateCWProxy {
  TodoScreenState loading(bool? loading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TodoScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TodoScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  TodoScreenState call({
    bool? loading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTodoScreenState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTodoScreenState.copyWith.fieldName(...)`
class _$TodoScreenStateCWProxyImpl implements _$TodoScreenStateCWProxy {
  const _$TodoScreenStateCWProxyImpl(this._value);

  final TodoScreenState _value;

  @override
  TodoScreenState loading(bool? loading) => this(loading: loading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TodoScreenState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TodoScreenState(...).copyWith(id: 12, name: "My name")
  /// ````
  TodoScreenState call({
    Object? loading = const $CopyWithPlaceholder(),
  }) {
    return TodoScreenState(
      loading == const $CopyWithPlaceholder()
          ? _value.loading
          // ignore: cast_nullable_to_non_nullable
          : loading as bool?,
    );
  }
}

extension $TodoScreenStateCopyWith on TodoScreenState {
  /// Returns a callable class that can be used as follows: `instanceOfTodoScreenState.copyWith(...)` or like so:`instanceOfTodoScreenState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TodoScreenStateCWProxy get copyWith => _$TodoScreenStateCWProxyImpl(this);
}
