import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'add_order_action.view_state.g.dart';
    
/// [AddOrderActionViewState]
@CopyWith()
class AddOrderActionViewState extends ViewStateAbs {
  final DateTime? selectedDate;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState<DateTime>> dateKey;

  /// Constructor
  /// @param [selectedDate] selected date
  /// @param [controller] controller
  /// @param [formKey] form key
  /// @param [dateKey] date key
  ///
  AddOrderActionViewState({
    this.selectedDate,
    required this.controller,
    required this.formKey,
    required this.dateKey,
  });

  /// Initial state
  ///
  factory AddOrderActionViewState.initial() => AddOrderActionViewState(
        controller: TextEditingController(),
        formKey: GlobalKey<FormState>(),
        dateKey: GlobalKey<FormFieldState<DateTime>>(),
      );

  /// Get props
  ///
  @override
  List<Object?> get props => [
        selectedDate,
      ];
}
