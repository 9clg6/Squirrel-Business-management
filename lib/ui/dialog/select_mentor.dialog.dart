import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Select Mentor dialog
///
class SelectMentorDialog extends StatefulWidget {
  const SelectMentorDialog({super.key});

  @override
  State<SelectMentorDialog> createState() => _SelectMentorDialogState();
}

class _SelectMentorDialogState extends State<SelectMentorDialog> {
  /// Client service
  late final List<Client> clients;

  /// Constructor
  /// @param super.key
  ///
  _SelectMentorDialogState() {
    clients = injector<ClientService>().clientState.clients;
  }

  /// Build
  /// @param context
  /// @return Widget
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: clients.isEmpty
                ? [
                    const Text('Aucun client trouvé'),
                  ]
                : [
                    const TextVariant(
                      "Sélectionner un parrain",
                      variantType: TextVariantType.titleMedium,
                    ),
                    const Gap(6),
                    const TextVariant(
                      "Un parrain ne peut être qu'un client existant",
                      variantType: TextVariantType.bodySmall,
                    ),
                    const Gap(12),
                    Divider(
                      height: 1,
                      color: colorScheme.outline.withValues(alpha: 0.5),
                    ),
                    const Gap(12),
                    ...clients.map((client) => _ClientItem(
                          client: client,
                          isLast: clients.last == client,
                        )),
                    const Gap(12),
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: TextVariant(
                          "Aucun",
                          variantType: TextVariantType.bodyMedium,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}

/// Client item
///
class _ClientItem extends StatefulWidget {
  /// Constructor
  /// @param client
  /// @param isLast
  ///
  const _ClientItem({
    required this.client,
    required this.isLast,
  });

  /// Client
  final Client client;

  /// Is last
  final bool isLast;

  /// Create state
  /// @return State<_ClientItem>
  ///
  @override
  State<_ClientItem> createState() => _ClientItemState();
}

class _ClientItemState extends State<_ClientItem> {
  /// Is hovered
  bool isHovered = false;

  /// Build
  /// @param context
  /// @return Widget
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        context.pop(widget.client);
      },
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isHovered ? colorScheme.primary : null,
              ),
              child: Text(widget.client.name),
            ),
            if (!widget.isLast)
              Divider(
                height: 1,
                color: colorScheme.outline,
              ),
          ],
        ),
      ),
    );
  }
}
