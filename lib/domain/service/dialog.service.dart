import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:init/domain/entities/action.entity.dart';
import 'package:init/ui/screen/add_order_action/add_order_action.screen.dart';

class DialogService {
  final GlobalKey<NavigatorState> navigatorKey;

  DialogService(this.navigatorKey);

  /// Show add order action dialog
  ///
  Future<OrderAction?> showAddOrderActionDialog() async {
    final context = navigatorKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showAddOrderActionDialog()');
      return null;
    }

    return showDialog<OrderAction>(
      context: context,
      builder: (_) => const AddOrderActionScreen(),
    );
  }

  Future<List<DateTime?>?> showDatePickerDialog() async {
    final context = navigatorKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showDatePickerDialog()');
      return null;
    }

    return showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        animateToDisplayedMonthDate: true,
        allowSameValueSelection: true,
        calendarType: CalendarDatePicker2Type.single,
        currentDate: DateTime.now(),
        dayBorderRadius: BorderRadius.circular(16),
        firstDayOfWeek: 1,
        selectableDayPredicate: (DateTime date) {
          return date.isAfter(DateTime.now().subtract(const Duration(days: 1)));
        },
      ),
      
      value: [DateTime.now()],
      dialogSize: const Size(325, 400),
    );
  }
}
