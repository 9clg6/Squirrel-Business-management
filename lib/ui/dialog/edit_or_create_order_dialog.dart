import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/routing/app_router.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

class EditOrAddOrderDialog extends StatefulWidget {
  /// Is creation
  final bool isCreation;

  /// Order
  final Order? order;

  /// Constructor
  const EditOrAddOrderDialog({
    super.key,
    this.isCreation = false,
    this.order,
  });

  @override
  State<EditOrAddOrderDialog> createState() => _EditOrAddOrderDialogState();
}

class _EditOrAddOrderDialogState extends State<EditOrAddOrderDialog> {
  /// Form key
  late final GlobalKey<FormState> formKey;

  /// Order
  late final Order? order;

  /// Shop name controller
  late final TextEditingController shopNameController;

  /// Order date controller
  late final TextEditingController orderDateController;

  /// Order duration controller
  late final TextEditingController orderDurationController;

  /// Commission controller
  late final TextEditingController commissionController;

  /// Order amount controller
  late final TextEditingController orderAmountController;

  /// Order internal fees controller
  late final TextEditingController orderInternalFeesController;

  /// Order track id controller
  late final TextEditingController trackIdController;

  /// Order method controller
  late final TextEditingController methodController;

  /// Order intermediary controller
  late final TextEditingController intermediaryController;

  /// Order client controller
  late final TextEditingController clientController;

  /// Order comment controller
  late final TextEditingController commentController;

  /// Is creation
  late final bool isCreation;

  /// Is commission percentage
  late bool isCommissionPercentage;

  /// Constructor
  ///
  _EditOrAddOrderDialogState();

  @override
  void initState() {
    super.initState();
    order = widget.order;
    isCreation = widget.isCreation;
    isCommissionPercentage = widget.order?.commissionRatio != null;
    shopNameController = TextEditingController(text: widget.order?.shopName);
    orderDateController =
        TextEditingController(text: widget.order?.startDate.toDDMMYYYY());
    orderDurationController = TextEditingController(
        text: "${widget.order?.estimatedDuration.inDays}");
    commissionController = TextEditingController(
        text: widget.order?.commissionRatio != null
            ? "${widget.order?.commissionRatio}"
            : "${widget.order?.commission}");
    orderAmountController =
        TextEditingController(text: "${widget.order?.price}");
    orderInternalFeesController =
        TextEditingController(text: "${widget.order?.internalProcessingFee}");
    trackIdController = TextEditingController(text: widget.order?.trackId);
    methodController = TextEditingController(text: widget.order?.method);
    intermediaryController =
        TextEditingController(text: widget.order?.intermediaryContact);
    clientController = TextEditingController(text: widget.order?.clientContact);
    commentController = TextEditingController(text: widget.order?.note);
    formKey = GlobalKey<FormState>();
  }

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
          child: Form(
            key: formKey,
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
                TextFormField(
                  controller: shopNameController,
                  decoration: const InputDecoration(
                    labelText: "Nom du magasin",
                  ),
                  validator: validator('nom du magasin'),
                ),
                const Gap(32),
                TextFormField(
                  controller: clientController,
                  decoration: const InputDecoration(
                    labelText: "Nom du client",
                  ),
                  validator: validator('nom du client'),
                ),
                const Gap(32),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: orderDateController,
                        decoration: const InputDecoration(
                          labelText: "Date de la commande",
                        ),
                        validator: validator('date de la commande', true),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: orderDurationController,
                        decoration: const InputDecoration(
                          labelText: "Durée de la commande",
                          suffixText: "jours",
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: validator('durée de la commande'),
                      ),
                    ),
                  ],
                ),
                const Gap(32),
                TextFormField(
                  controller: orderAmountController,
                  decoration: const InputDecoration(
                    labelText: "Montant de la commande",
                    suffixText: "€",
                  ),
                  validator: validator('montant de la commande'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const Gap(32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: commissionController,
                            decoration: InputDecoration(
                              labelText: "Commission",
                              suffixText: isCommissionPercentage
                                  ? "%"
                                  : "€",
                            ),
                            validator: validator('commission', true),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: orderInternalFeesController,
                            decoration: const InputDecoration(
                              labelText: "Frais internes",
                              suffixText: "€",
                            ),
                            validator: validator('frais internes'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(8),
                      borderColor: colorScheme.outline,
                      borderWidth: 1,
                      fillColor: colorScheme.primary,
                      selectedColor: colorScheme.onPrimary,
                      isSelected: [
                        isCommissionPercentage,
                        !isCommissionPercentage,
                      ],
                      onPressed: (value) {
                        setState(() {
                          isCommissionPercentage = !isCommissionPercentage;
                        });
                      },
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isCommissionPercentage)
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.check_circle,
                                  color: colorScheme.surface,
                                  size: 16,
                                ),
                              ),
                            TextVariant(
                              "Pourcentage",
                              color: isCommissionPercentage
                                  ? colorScheme.surface
                                  : colorScheme.onSurface,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isCommissionPercentage)
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  Icons.check_circle,
                                  color: colorScheme.surface,
                                  size: 16,
                                ),
                              ),
                            TextVariant(
                              "Montant",
                              color: isCommissionPercentage
                                  ? colorScheme.onSurface
                                  : colorScheme.surface,
                            ),
                          ],
                        ),
                      ].map((e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 23),
                            child: e,
                          )).toList(),
                    ),
                  ],
                ),
                const Gap(32),
                TextFormField(
                  controller: trackIdController,
                  decoration: const InputDecoration(
                    labelText: "Numéro de suivi",
                  ),
                  validator: validator('numéro de suivi'),
                ),
                const Gap(32),
                TextFormField(
                  controller: methodController,
                  decoration: const InputDecoration(
                    labelText: "Méthode",
                  ),
                  validator: validator('méthode', true),
                ),
                const Gap(32),
                TextFormField(
                  controller: intermediaryController,
                  decoration: const InputDecoration(
                    labelText: "Intermédiaire",
                  ),
                  validator: validator('intermédiaire'),
                ),
                const Gap(32),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: TextFormField(
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: "Commentaire",
                    ),
                    controller: commentController,
                  ),
                ),
                const Gap(32),
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
                        if (formKey.currentState?.validate() == false) return;

                        final price = double.tryParse(orderAmountController.text
                                .replaceAll(' €', '')) ??
                            order?.price;
                        final commissionText = double.tryParse(commissionController
                                .text
                                .replaceAll(' €', '')) ??
                            order?.commission;
                        final internalFees = double.tryParse(
                                orderInternalFeesController.text
                                    .replaceAll(' €', '')) ??
                            order?.internalProcessingFee;
                        final duration = int.tryParse(orderDurationController
                                .text
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
                            clientContact: clientController.text,
                            intermediaryContact: intermediaryController.text,
                            price: price,
                            shopName: shopNameController.text,
                            startDate: parsedDate ?? order?.startDate,
                            estimatedDuration: Duration(
                                days: duration ??
                                    order?.estimatedDuration.inDays ??
                                    0),
                            commissionRatio: isCommissionPercentage
                                ? commissionText
                                : null,
                            commission: isCommissionPercentage
                                ? price! * commissionText! / 100
                                : commissionText,
                            internalProcessingFee: internalFees,
                            trackId: trackIdController.text,
                            method: methodController.text,
                            note: commentController.text,
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
      ),
    );
  }
}
