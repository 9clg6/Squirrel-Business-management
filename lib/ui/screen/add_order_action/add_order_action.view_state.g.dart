// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_order_action.view_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddOrderActionViewStateCWProxy {
  AddOrderActionViewState selectedDate(DateTime? selectedDate);

  AddOrderActionViewState controller(TextEditingController controller);

  AddOrderActionViewState formKey(GlobalKey<FormState> formKey);

  AddOrderActionViewState dateKey(GlobalKey<FormFieldState<DateTime>> dateKey);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddOrderActionViewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddOrderActionViewState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddOrderActionViewState call({
    DateTime? selectedDate,
    TextEditingController? controller,
    GlobalKey<FormState>? formKey,
    GlobalKey<FormFieldState<DateTime>>? dateKey,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddOrderActionViewState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddOrderActionViewState.copyWith.fieldName(...)`
class _$AddOrderActionViewStateCWProxyImpl
    implements _$AddOrderActionViewStateCWProxy {
  const _$AddOrderActionViewStateCWProxyImpl(this._value);

  final AddOrderActionViewState _value;

  @override
  AddOrderActionViewState selectedDate(DateTime? selectedDate) =>
      this(selectedDate: selectedDate);

  @override
  AddOrderActionViewState controller(TextEditingController controller) =>
      this(controller: controller);

  @override
  AddOrderActionViewState formKey(GlobalKey<FormState> formKey) =>
      this(formKey: formKey);

  @override
  AddOrderActionViewState dateKey(
          GlobalKey<FormFieldState<DateTime>> dateKey) =>
      this(dateKey: dateKey);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddOrderActionViewState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddOrderActionViewState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddOrderActionViewState call({
    Object? selectedDate = const $CopyWithPlaceholder(),
    Object? controller = const $CopyWithPlaceholder(),
    Object? formKey = const $CopyWithPlaceholder(),
    Object? dateKey = const $CopyWithPlaceholder(),
  }) {
    return AddOrderActionViewState(
      selectedDate: selectedDate == const $CopyWithPlaceholder()
          ? _value.selectedDate
          // ignore: cast_nullable_to_non_nullable
          : selectedDate as DateTime?,
      controller:
          controller == const $CopyWithPlaceholder() || controller == null
              ? _value.controller
              // ignore: cast_nullable_to_non_nullable
              : controller as TextEditingController,
      formKey: formKey == const $CopyWithPlaceholder() || formKey == null
          ? _value.formKey
          // ignore: cast_nullable_to_non_nullable
          : formKey as GlobalKey<FormState>,
      dateKey: dateKey == const $CopyWithPlaceholder() || dateKey == null
          ? _value.dateKey
          // ignore: cast_nullable_to_non_nullable
          : dateKey as GlobalKey<FormFieldState<DateTime>>,
    );
  }
}

extension $AddOrderActionViewStateCopyWith on AddOrderActionViewState {
  /// Returns a callable class that can be used as follows: `instanceOfAddOrderActionViewState.copyWith(...)` or like so:`instanceOfAddOrderActionViewState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddOrderActionViewStateCWProxy get copyWith =>
      _$AddOrderActionViewStateCWProxyImpl(this);
}
