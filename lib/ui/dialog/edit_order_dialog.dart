import 'package:flutter/material.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/foundation/extensions/date_time.extension.dart';
import 'package:init/foundation/routing/app_router.dart';

/// Edit order dialog
///
class EditOrderDialog extends StatelessWidget {
  /// Order
  ///
  final Order? order;

  /// Shop name controller
  ///
  final TextEditingController shopNameController;

  /// Order date controller
  ///
  final TextEditingController orderDateController;

  /// Order duration controller
  ///
  final TextEditingController orderDurationController;

  /// Commission controller
  ///
  final TextEditingController commissionController;

  /// Order amount controller
  ///
  final TextEditingController orderAmountController;

  /// Order internal fees controller
  ///
  final TextEditingController orderInternalFeesController;

  /// Order track id controller
  ///
  final TextEditingController trackIdController;

  /// Order method controller
  ///
  final TextEditingController methodController;

  /// Order intermediary controller
  ///
  final TextEditingController intermediaryController;

  /// Is creation
  ///
  final bool isCreation;

  /// Constructor
  ///
  EditOrderDialog({
    super.key,
    this.order,
    required this.isCreation,
  })  : shopNameController = TextEditingController(text: order?.shopName),
        orderDateController =
            TextEditingController(text: order?.startDate.toDDMMYYYY()),
        orderDurationController = TextEditingController(
          text: "${order?.estimatedDuration.inDays} jours",
        ),
        commissionController = TextEditingController(
          text: "${order?.commission} €",
        ),
        orderAmountController = TextEditingController(
          text: "${order?.price} €",
        ),
        orderInternalFeesController = TextEditingController(
          text: "${order?.internalProcessingFee} €",
        ),
        trackIdController = TextEditingController(
          text: order?.trackId,
        ),
        methodController = TextEditingController(
          text: order?.method,
        ),
        intermediaryController = TextEditingController(
          text: order?.intermediaryContact,
        );

  /// Build
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(22),
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isCreation ? "Créer une commande" : "Editer la commande",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: appRouter.pop,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Divider(
                color: colorScheme.outline.withValues(alpha: .2),
                height: 36,
                thickness: 1,
              ),
              TextField(
                controller: shopNameController,
                decoration: const InputDecoration(
                  labelText: "Nom du magasin",
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: orderDateController,
                      decoration: const InputDecoration(
                        labelText: "Date de la commande",
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: orderDurationController,
                      decoration: const InputDecoration(
                        labelText: "Durée de la commande",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              TextField(
                controller: orderAmountController,
                decoration: const InputDecoration(
                  labelText: "Montant de la commande",
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commissionController,
                      decoration: const InputDecoration(
                        labelText: "Commission",
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: orderInternalFeesController,
                      decoration: const InputDecoration(
                        labelText: "Frais interne",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              TextField(
                controller: trackIdController,
                decoration: const InputDecoration(
                  labelText: "Numéro de suivi",
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: methodController,
                decoration: const InputDecoration(
                  labelText: "Méthode",
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: intermediaryController,
                decoration: const InputDecoration(
                  labelText: "Intermédiaire",
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: appRouter.pop,
                    child: Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text("Annuler"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      final price = double.tryParse(orderAmountController.text
                              .replaceAll(' €', '')) ??
                          order?.price;
                      final commission = double.tryParse(
                              commissionController.text.replaceAll(' €', '')) ??
                          order?.commission;
                      final internalFees = double.tryParse(
                              orderInternalFeesController.text
                                  .replaceAll(' €', '')) ??
                          order?.internalProcessingFee;
                      final duration = int.tryParse(orderDurationController.text
                              .replaceAll(' jours', '')) ??
                          order?.estimatedDuration.inDays;

                      DateTime? parsedDate;
                      try {
                        final dateParts = orderDateController.text.split('/');
                        if (dateParts.length == 3) {
                          final formattedDate =
                              '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';
                          parsedDate = DateTime.parse(formattedDate);
                        }
                      } catch (e) {
                        parsedDate = order?.startDate;
                      }

                      appRouter.pop<Order>(
                        order?.copyWith(
                          intermediaryContact: intermediaryController.text,
                          price: price,
                          shopName: shopNameController.text,
                          startDate: parsedDate ?? order?.startDate,
                          estimatedDuration: Duration(
                              days: duration ??
                                  order?.estimatedDuration.inDays ??
                                  0),
                          commissionRatio: commission,
                          internalProcessingFee: internalFees,
                          trackId: trackIdController.text,
                          method: methodController.text,
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text("Sauvegarder"),
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
