import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/service/customer.service.dart';
import 'package:squirrel/domain/state/customer.state.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Select customer dialog
///
class SelectCustomerDialog extends ConsumerStatefulWidget {
  /// Constructor
  /// @param super.key
  ///
  const SelectCustomerDialog({
    super.key,
    this.isSponsor = false,
  });

  /// Is sponsor
  final bool isSponsor;

  /// Create state
  /// @return State<SelectcustomerDialog>
  ///
  @override
  ConsumerState<SelectCustomerDialog> createState() =>
      _SelectcustomerDialogState();
}

class _SelectcustomerDialogState extends ConsumerState<SelectCustomerDialog> {
  /// Build
  /// @param context
  /// @return Widget
  ///
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AsyncValue<CustomerState> customers =
        ref.watch(customerServiceProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: switch (customers) {
              AsyncData<CustomerState>(:final CustomerState value) => <Widget>[
                  TextVariant(
                    widget.isSponsor
                        ? 'Sélectionner un parrain'
                        : 'Sélectionner un customer',
                    variantType: TextVariantType.titleMedium,
                  ),
                  const Gap(6),
                  if (widget.isSponsor)
                    const TextVariant(
                      "Un parrain ne peut être qu'un customer existant",
                      variantType: TextVariantType.bodySmall,
                    ),
                  const Gap(12),
                  Divider(
                    height: 1,
                    color: colorScheme.outline.withValues(alpha: 0.5),
                  ),
                  const Gap(12),
                  ...value.customers.map(
                    (Customer customer) => _customerItem(
                      customer: customer,
                      isLast: value.customers.last == customer,
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
              AsyncError<CustomerState>(:final Object error) => <Widget>[
                  TextVariant(
                    error.toString(),
                  ),
                ],
              AsyncLoading<CustomerState>() => <Widget>[
                  const CircularProgressIndicator(),
                ],
              AsyncValue<CustomerState>() => <Widget>[
                  const Text('Aucun customer trouvé'),
                ],
            },
          ),
        ),
      ),
    );
  }
}

/// customer item
///
class _customerItem extends StatefulWidget {
  /// Constructor
  /// @param customer
  /// @param isLast
  ///
  const _customerItem({
    required this.customer,
    required this.isLast,
  });

  /// customer
  final Customer customer;

  /// Is last
  final bool isLast;

  /// Create state
  /// @return State<_customerItem>
  ///
  @override
  State<_customerItem> createState() => _customerItemState();
}

class _customerItemState extends State<_customerItem> {
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
        context.pop(widget.customer);
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
              child: Text(widget.customer.name),
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
