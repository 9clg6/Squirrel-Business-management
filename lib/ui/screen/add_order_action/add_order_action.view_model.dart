import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';
import 'package:squirrel/ui/screen/add_order_action/add_order_action.view_state.dart';

part 'add_order_action.view_model.g.dart';

/// [AddOrderAction]
@riverpod
class AddOrderAction extends _$AddOrderAction {
  late final DialogService _dialogService;
  late final NavigatorService _navigatorService;

  /// Build
  ///
  @override
  AddOrderActionViewState build() {
    _dialogService = ref.read(dialogServiceProvider.notifier);
    _navigatorService = ref.read(navigatorServiceProvider.notifier);
    return AddOrderActionViewState.initial();
  }

  /// Pick date
  ///
  Future<void> pickDate() async {
    final DateTime? selectedDate =
        (await _dialogService.showDatePickerDialog())?.firstOrNull;

    if (selectedDate != null) {
      state = state.copyWith(selectedDate: selectedDate);
    }
  }

  /// Navigate back
  /// @param [result] result
  ///
  void navigateBack({OrderAction? result}) {
    _navigatorService.navigateBack(result: result);
  }

  /// Navigate back with result
  ///
  void navigateBackWithResult() {
    if (state.formKey.currentState?.validate() == false) {
      return;
    }

    navigateBack(
      result: OrderAction(
        date: state.selectedDate!,
        description: state.controller.text,
      ),
    );
  }
}
