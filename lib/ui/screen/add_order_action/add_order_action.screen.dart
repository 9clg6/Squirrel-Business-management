import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/screen/add_order_action/add_order_action.view_model.dart';
import 'package:squirrel/ui/screen/add_order_action/add_order_action.view_state.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// [AddOrderActionScreen]
class AddOrderActionScreen extends ConsumerWidget {
  /// Constructor
  /// @param [key] key
  ///
  const AddOrderActionScreen({super.key});

  /// Build
  /// @param [context] context
  /// @param [ref] ref
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AddOrderAction viewModel = ref.read(addOrderActionProvider.notifier);
    final AddOrderActionViewState state = ref.watch(addOrderActionProvider);

    return Dialog(
      backgroundColor: colorScheme.surface,
      insetAnimationCurve: Curves.easeInOut,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetAnimationDuration: const Duration(milliseconds: 500),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
          minWidth: 400,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    LocaleKeys.addOrderAction.tr(),
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Divider(
                    color: colorScheme.outline.withValues(alpha: .2),
                    height: 36,
                    thickness: 1,
                  ),
                  TextFormField(
                    controller: state.controller,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.orderActionNameRequired.tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: LocaleKeys.orderActionName.tr(),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.outline.withValues(alpha: .2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormField<DateTime>(
                    key: state.dateKey,
                    validator: (_) {
                      if (state.selectedDate == null) {
                        return LocaleKeys.orderActionDateRequired.tr();
                      }
                      return null;
                    },
                    builder: (FormFieldState<DateTime> field) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: InkWell(
                            onTap: viewModel.pickDate,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: field.hasError
                                      ? colorScheme.error
                                      : colorScheme.outline,
                                ),
                              ),
                              child: TextVariant(
                                state.selectedDate?.toDDMMYYYY() ??
                                    LocaleKeys.selectOrderActionDate.tr(),
                                style: TextStyle(
                                  color: field.hasError
                                      ? colorScheme.error
                                      : colorScheme.onSurface.withValues(
                                          alpha: state.selectedDate == null
                                              ? .6
                                              : 1,
                                        ),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              left: 12,
                            ),
                            child: Text(
                              field.errorText!,
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.error,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: viewModel.navigateBack,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: colorScheme.outline,
                      ),
                    ),
                    child: TextVariant(
                      LocaleKeys.cancel.tr(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: viewModel.navigateBackWithResult,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.primary,
                    ),
                    child: TextVariant(
                      LocaleKeys.add.tr(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
