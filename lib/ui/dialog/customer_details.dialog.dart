import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Customer details dialog
class CustomerDetailDialog extends StatefulWidget {
  /// Public constructor
  /// @param customer: The customer to show
  ///
  const CustomerDetailDialog({
    required this.customer,
    super.key,
  });

  /// The customer to show
  final Customer customer;

  /// Build
  ///
  @override
  State<CustomerDetailDialog> createState() => _CustomerDetailDialogState();
}

/// Customer details dialog state
class _CustomerDetailDialogState extends State<CustomerDetailDialog> {
  /// Build
  /// @param context: The build context
  /// @return The widget
  ///
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final DateFormat dateFormat = DateFormat.yMMMMd('fr_FR');

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 24,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextVariant(
                widget.customer.name.capitalize,
                variantType: TextVariantType.headlineSmall,
                color: colorScheme.onSurface,
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: <Widget>[
                  _StatCard(
                    label: 'Total des commandes',
                    value: LocaleKeys.priceWithSymbol.tr(
                      args: <String>[
                        widget.customer.orderTotalAmount.toStringAsFixed(2),
                      ],
                    ),
                  ),
                  _StatCard(
                    label: 'Commission totale',
                    value: LocaleKeys.priceWithSymbol.tr(
                      args: <String>[
                        widget.customer.commissionTotalAmount.toStringAsFixed(2),
                      ],
                    ),
                  ),
                  _StatCard(
                    label: 'Quantité de commandes',
                    value: '${widget.customer.orderQuantity}',
                  ),
                  _StatCard(
                    label: 'Quantité de parrainages',
                    value: '${widget.customer.sponsorshipQuantity}',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (widget.customer.lastOrderDate != null) ...<Widget>[
                TextVariant(
                  LocaleKeys.lastDateOrder.tr(),
                  color: colorScheme.onSurface,
                ),
                TextVariant(
                  dateFormat.format(widget.customer.lastOrderDate!),
                  color: colorScheme.onSurface,
                ),
              ],
              const SizedBox(height: 12),
              if (widget.customer.firstOrderDate != null) ...<Widget>[
                TextVariant(
                  LocaleKeys.firstDateOrder.tr(),
                  color: colorScheme.onSurface,
                ),
                TextVariant(
                  dateFormat.format(widget.customer.firstOrderDate!),
                  color: colorScheme.onSurface,
                ),
              ],
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.onPrimary,
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextVariant(
                      LocaleKeys.close.tr(),
                      color: colorScheme.onPrimary,
                    ),
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

class _StatCard extends StatelessWidget {
  /// Public constructor
  /// @param label: The label
  /// @param value: The value
  ///
  const _StatCard({
    required this.label,
    required this.value,
  });

  /// The label
  final String label;

  /// The value
  final dynamic value;

  /// Build
  /// @param context: The build context
  /// @return The widget
  ///
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: colorScheme.surfaceContainerLow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextVariant(
            label,
            color: colorScheme.onSurface,
          ),
          const SizedBox(height: 4),
          TextVariant(
            value.toString(),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}
