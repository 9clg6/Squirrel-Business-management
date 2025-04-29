import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/foundation/routing/routing_key.dart';
import 'package:squirrel/ui/dialog/confirmation_dialog.dart';
import 'package:squirrel/ui/dialog/customer_details.dialog.dart';
import 'package:squirrel/ui/dialog/edit_or_create_order_dialog.dart';
import 'package:squirrel/ui/dialog/export_key.dialog.dart';
import 'package:squirrel/ui/dialog/import.dialog.dart';
import 'package:squirrel/ui/dialog/select_customer.dialog.dart';
import 'package:squirrel/ui/dialog/use_conditions.dialog.dart';
import 'package:squirrel/ui/screen/add_order_action/add_order_action.screen.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// The dialog service
class DialogService {
  /// Show add order action dialog
  /// @return The added order action
  ///
  Future<OrderAction?> showAddOrderActionDialog() async {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showAddOrderActionDialog()');
      return null;
    }

    return showDialog<OrderAction>(
      context: context,
      builder: (_) => const AddOrderActionScreen(),
    );
  }

  /// Show date picker dialog
  /// @return The selected date
  ///
  Future<List<DateTime?>?> showDatePickerDialog() async {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showDatePickerDialog()');
      return null;
    }

    return showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        animateToDisplayedMonthDate: true,
        allowSameValueSelection: true,
        calendarType: CalendarDatePicker2Type.single,
        currentDate: DateTime.now(),
        dayBorderRadius: BorderRadius.circular(16),
        firstDayOfWeek: 1,
      ),
      value: <DateTime?>[DateTime.now()],
      dialogSize: const Size(325, 400),
    );
  }

  /// Show confirmation dialog
  /// @param title: The title of the dialog
  /// @param message: The message to display in the dialog
  /// @param onConfirm: The function to call when the user confirms the dialog
  /// @return The result of the dialog
  ///
  Future<void> showConfirmationDialog(
    String title,
    String message,
    Null Function() onConfirm, {
    bool doublePop = false,
  }) {
    return showDialog<void>(
      context: routingKey.currentContext!,
      builder: (_) => ConfirmationDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
        doublePop: doublePop,
      ),
    );
  }

  /// Show import dialog
  Future<(FilePickerResult?, String?, bool?)?>? showImportDialog() {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showEditOrderDialog()');
      return null;
    }

    return showDialog<(FilePickerResult?, String?, bool?)>(
      context: context,
      builder: (_) => const ImportDialog(),
    );
  }

  /// Show edit order dialog
  /// @param isCreation: Whether the order is being created or edited
  /// @param order: The order to edit
  /// @return The edited order
  ///
  Future<Order?> showEditOrderDialog({
    bool isCreation = false,
    Order? order,
  }) async {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showEditOrderDialog()');
      return null;
    }

    return showDialog<Order>(
      context: context,
      builder: (_) => EditOrAddOrderDialog(
        order: order,
        isCreation: isCreation,
      ),
    );
  }

  /// Show select range date dialog
  /// @return The selected range date
  ///
  Future<List<DateTime?>?> selectRangeDate() async {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.selectRangeDate()');
      return null;
    }

    return showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        firstDate: DateTime.now().subtract(const Duration(days: 15)),
        lastDate: DateTime.now(),
        animateToDisplayedMonthDate: true,
        allowSameValueSelection: true,
        calendarType: CalendarDatePicker2Type.range,
        currentDate: DateTime.now(),
        dayBorderRadius: BorderRadius.circular(16),
        firstDayOfWeek: 1,
        rangeBidirectional: false,
        selectableDayPredicate: (DateTime date) {
          return date.isBefore(DateTime.now().add(const Duration(days: 1)));
        },
      ),
      dialogSize: const Size(325, 400),
    );
  }

  /// Show error dialog
  /// @param message: The message to display in the dialog
  ///
  void showError(String message) {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showEditOrderDialog()');
      return;
    }

    final ColorScheme theme = Theme.of(context).colorScheme;

    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        icon: Icon(
          Icons.error_outline,
          color: theme.primary,
          size: 42,
        ),
        title: const Text('Erreur'),
        content: TextVariant(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// Show use conditions dialog
  ///
  Future<bool?> showUseConditions() async {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showUseConditions()');
      return null;
    }

    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (_) => const UseConditionsDialog(),
    );
  }

  /// Show in coming dialog
  ///
  Future<void> showInComingDialog() async {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showInComingDialog()');
      return;
    }

    final ColorScheme theme = Theme.of(context).colorScheme;

    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const TextVariant(
          'Fonctionnalités à venir',
          variantType: TextVariantType.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        icon: Icon(
          Icons.rocket_launch_rounded,
          size: 42,
          color: theme.primary,
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextVariant(
              'Nous travaillons actuellement sur les prochaines versions, '
              'qui inclueront :',
              fontWeight: FontWeight.bold,
            ),
            Gap(28),
            TextVariant(
              '- Le lien entre le Bot de commande Telegram et le logiciel, '
              'pour visualiser les commandes reçus en temps réel',
            ),
            Gap(10),
            TextVariant(
              "- L'interface de gestion des clients",
            ),
            Gap(10),
            TextVariant(
              "- L'interface \"Planification\" si l'idée est soutenue par vous",
            ),
            Gap(10),
            TextVariant(
              "- L'ajout de nouvelles statistiques en fonction des demandes",
            ),
            Gap(10),
            TextVariant(
              '- Un système de remontée de bug et de suggestions',
            ),
            Gap(28),
            TextVariant(
              "N'hésitez pas à remonter les bugs, faire des suggestions, "
              'demandes etc. Cela sera recompensé. 🎁',
            ),
          ],
        ),
      ),
    );
  }

  /// Show select customer dialog
  /// @return The selected customer
  ///
  Future<Customer?> showSelectCustomerDialog({
    bool isSponsor = false,
  }) async {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showSelectCustomerDialog()');
      return null;
    }

    return showDialog<Customer>(
      context: context,
      barrierDismissible: false,
      builder: (_) => SelectCustomerDialog(isSponsor: isSponsor),
    );
  }

  /// Show customer details dialog
  /// @param customer: The customer to show
  ///
  Future<void> showCustomerDetailsDialog(Customer customer) async {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint(
        'Context is null in DialogService.showCustomerDetailsDialog()',
      );
      return;
    }

    return showDialog<void>(
      context: context,
      builder: (_) => CustomerDetailDialog(customer: customer),
    );
  }

  /// Show export key dialog
  /// @param key: The key to export
  ///
  Future<void> showExportKeyDialog({required String key}) async {
    final BuildContext? context = routingKey.currentContext;

    if (context == null) {
      debugPrint('Context is null in DialogService.showExportKeyDialog()');
      return;
    }

    return showDialog<void>(
      context: context,
      builder: (_) => ExportKeyDialog(exportKey: key),
    );
  }
}
