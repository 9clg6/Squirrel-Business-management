import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/service/client.service.dart';
import 'package:squirrel/domain/state/client.state.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Select client dialog
///
class SelectClientDialog extends ConsumerStatefulWidget {
  /// Constructor
  /// @param super.key
  ///
  const SelectClientDialog({
    super.key,
    this.isSponsor = false,
  });

  /// Is sponsor
  final bool isSponsor;

  /// Create state
  /// @return State<SelectClientDialog>
  ///
  @override
  ConsumerState<SelectClientDialog> createState() => _SelectClientDialogState();
}

class _SelectClientDialogState extends ConsumerState<SelectClientDialog> {
  /// Build
  /// @param context
  /// @return Widget
  ///
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AsyncValue<ClientState> clients = ref.watch(clientServiceProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: switch (clients) {
              AsyncData<ClientState>(:final ClientState value) => <Widget>[
                  TextVariant(
                    widget.isSponsor
                        ? 'Sélectionner un parrain'
                        : 'Sélectionner un client',
                    variantType: TextVariantType.titleMedium,
                  ),
                  const Gap(6),
                  if (widget.isSponsor)
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
                  ...value.clients.map(
                    (Client client) => _ClientItem(
                      client: client,
                      isLast: value.clients.last == client,
                    ),
                  ),
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
                        'Aucun',
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              AsyncError<ClientState>(:final Object error) => <Widget>[
                  TextVariant(
                    error.toString(),
                  ),
                ],
              AsyncLoading<ClientState>() => <Widget>[
                  const CircularProgressIndicator(),
                ],
              AsyncValue<ClientState>() => <Widget>[
                  const Text('Aucun client trouvé'),
                ],
            },
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        context.pop(widget.client);
      },
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
