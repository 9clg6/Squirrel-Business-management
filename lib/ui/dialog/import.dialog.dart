import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Import dialog
///
class ImportDialog extends StatefulWidget {
  /// Constructor
  /// @param key: The key of the dialog
  ///
  const ImportDialog({super.key});

  /// Create state
  /// @return The state of the dialog
  ///
  @override
  State<ImportDialog> createState() => _ImportDialogState();
}

/// Import dialog state
///
class _ImportDialogState extends State<ImportDialog> {
  final TextEditingController _keyController = TextEditingController();

  FilePickerResult? _file;

  bool _overrideData = false;

  /// Build
  /// @return The widget of the dialog
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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const TextVariant(
                'Importer les données',
                variantType: TextVariantType.titleLarge,
              ),
              const Gap(16),
              const TextVariant(
                'Pour importer les données, merci de choisir le fichier à importer et de saisir la clé de chiffrement.',
              ),
              const Gap(22),
              Row(
                children: <Widget>[
                  FilledButton(
                    onPressed: () async {
                      final FilePickerResult? temp =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: <String>['json'],
                      );

                      if (temp != null && temp.files.isNotEmpty) {
                        setState(() => _file = temp);
                      }
                    },
                    child: TextVariant(
                      'Choisir un fichier',
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const Gap(16),
                  if (_file != null)
                    Flexible(
                      child: TextVariant(
                        _file!.files.first.path!,
                        color: colorScheme.onSurface,
                      ),
                    ),
                ],
              ),
              const Gap(22),
              if (_file != null)
                TextField(
                  controller: _keyController,
                  decoration: const InputDecoration(
                    labelText: 'Clé de chiffrement',
                  ),
                ),
              const Gap(22),
              Row(
                children: <Widget>[
                  Switch(
                    value: _overrideData,
                    onChanged: (bool value) => setState(
                      () => _overrideData = value,
                    ),
                    activeColor: colorScheme.primary,
                    activeTrackColor:
                        colorScheme.primaryContainer.withAlpha(90),
                    inactiveTrackColor: colorScheme.surfaceContainerLow,
                    inactiveThumbColor: colorScheme.onSurface,
                  ),
                  const Gap(8),
                  TextVariant(
                    'Écraser les données existantes',
                    color: colorScheme.onSurface,
                    fontWeight: _overrideData ? FontWeight.bold : null,
                  ),
                ],
              ),
              const Gap(22),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: context.pop,
                    child: const TextVariant('Annuler'),
                  ),
                  const Gap(16),
                  if (_file != null)
                    FilledButton(
                      onPressed: () => context.pop(
                        (
                          _file,
                          _keyController.text,
                          _overrideData,
                        ),
                      ),
                      child: TextVariant(
                        'Importer',
                        color: colorScheme.onPrimary,
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
