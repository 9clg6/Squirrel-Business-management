import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'add_order_action.view_state.g.dart';

/// [AddOrderActionViewState]
@CopyWith()
class AddOrderActionViewState extends ViewStateAbs {
  /// Constructor
  /// @param [selectedDate] selected date
  /// @param [controller] controller
  /// @param [formKey] form key
  /// @param [dateKey] date key
  ///
  AddOrderActionViewState({
    required this.controller,
    required this.formKey,
    required this.dateKey,
    this.selectedDate,
  });

  /// Initial state
  ///
  factory AddOrderActionViewState.initial() => AddOrderActionViewState(
        controller: TextEditingController(),
        formKey: GlobalKey<FormState>(),
        dateKey: GlobalKey<FormFieldState<DateTime>>(),
      );

  /// Selected date
  final DateTime? selectedDate;

  /// Controller
  final TextEditingController controller;

  /// Form key
  final GlobalKey<FormState> formKey;

  /// Date key
  final GlobalKey<FormFieldState<DateTime>> dateKey;

  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        selectedDate,
      ];
}
