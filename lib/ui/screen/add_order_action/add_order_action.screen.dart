import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/ui/screen/add_order_action/add_order_action.view_model.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

class AddOrderActionScreen extends ConsumerWidget {
  const AddOrderActionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final viewModel = ref.read(addOrderActionProvider.notifier);
    final state = ref.watch(addOrderActionProvider);

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Ajouter une nouvelle action",
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le nom de l\'action est obligatoire';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Nom de l\'action',
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
                        return 'La date de l\'action est obligatoire';
                      }
                      return null;
                    },
                    builder: (field) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    "Sélectionner la date de l'action",
                                variantType: TextVariantType.bodyMedium,
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
                                  color: colorScheme.error, fontSize: 12),
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
              children: [
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
                    child: const Text('Annuler'),
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
                    child: const Text('Ajouter'),
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
