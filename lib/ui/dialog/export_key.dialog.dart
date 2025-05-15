// ignore_for_file: lines_longer_than_80_chars w

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Export key dialog
class ExportKeyDialog extends StatelessWidget {
  /// Public constructor
  /// @param key: The key to export
  ///
  const ExportKeyDialog({
    required this.exportKey,
    super.key,
  });

  /// The key to export
  final String exportKey;

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
              const TextVariant(
                'Clé de chiffrement',
                variantType: TextVariantType.titleLarge,
              ),
              const SizedBox(height: 16),
              const TextVariant(
                'Afin de pouvoir importer les données vous devez IMPÉRATIVEMENT sauvegarder cette clé.',
              ),
              const SizedBox(height: 16),
              const TextVariant(
                'Vous ne pourrez plus importer les données sans cette clé.',
              ),
              const SizedBox(height: 16),
              SelectableText(
                exportKey,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: context.pop,
                child: TextVariant(
                  'Fermer',
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
