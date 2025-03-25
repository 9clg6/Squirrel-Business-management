import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Client details dialog
class ClientDetailDialog extends StatefulWidget {

  /// Public constructor
  /// @param client: The client to show
  ///
  const ClientDetailDialog({
    required this.client, super.key,
  });
  /// The client to show
  final Client client;

  /// Build
  ///
  @override
  State<ClientDetailDialog> createState() => _ClientDetailDialogState();
}

/// Client details dialog state
class _ClientDetailDialogState extends State<ClientDetailDialog> {
  /// Build
  /// @param context: The build context
  /// @return The widget
  ///
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      insetPadding: const EdgeInsets.all(100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            title: Hero(
              tag: widget.client.id,
              child: TextVariant(
                widget.client.name,
                variantType: TextVariantType.titleMedium,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                onPressed: context.pop,
                icon: const Icon(Icons.close),
              ),
              const Gap(20),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 40,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceDim,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: .2),
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: .2),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            child: TextVariant(
                              widget.client.name.substring(0, 1),
                              variantType: TextVariantType.titleLarge,
                            ),
                          ),
                          const Gap(20),
                          TextVariant(
                            widget.client.name,
                            variantType: TextVariantType.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
