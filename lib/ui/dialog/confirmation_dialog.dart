import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Confirmation dialog
///
class ConfirmationDialog extends StatelessWidget {
  /// Constructor
  ///
  const ConfirmationDialog({
    required this.title,
    required this.message,
    required this.onConfirm,
    super.key,
    this.doublePop = false,
  });

  /// Title
  final String title;

  /// Message
  final String message;

  /// On confirm
  final Null Function() onConfirm;

  /// Double pop
  final bool doublePop;

  /// Build
  ///
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.warning_amber_rounded,
                color: colorScheme.error,
                size: 32,
              ),
              const SizedBox(height: 16),
              TextVariant(
                title,
                variantType: TextVariantType.titleLarge,
              ),
              const SizedBox(height: 16),
              TextVariant(
                message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: context.pop,
                    child: Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.center,
                      child: TextVariant(
                        LocaleKeys.cancel.tr(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      context.pop();
                      if (doublePop) {
                        context.pop();
                      }
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
                        color: colorScheme.onPrimary,
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
