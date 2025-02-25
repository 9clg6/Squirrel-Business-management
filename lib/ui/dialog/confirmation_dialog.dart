import 'package:flutter/material.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/routing/app_router.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Confirmation dialog
///
class ConfirmationDialog extends StatelessWidget {
  /// Title
  final String title;

  /// Message
  final String message;

  /// On confirm
  final Null Function() onConfirm;

  /// Constructor
  ///
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  /// Build
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: colorScheme.error,
                size: 32,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: appRouter.pop,
                    child: Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.center,
                      child: TextVariant(
                        LocaleKeys.cancel.tr(),
                        variantType: TextVariantType.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      appRouter
                        ..pop()
                        ..pop();
                      onConfirm();
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextVariant(
                        LocaleKeys.confirm.tr(),
                        variantType: TextVariantType.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
