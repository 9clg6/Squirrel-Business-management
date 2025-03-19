import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/provider/service_type_service.provider.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/widgets/help_text.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

class EditOrAddOrderDialog extends ConsumerStatefulWidget {
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
  ConsumerState<EditOrAddOrderDialog> createState() =>
      _EditOrAddOrderDialogState();
}

class _EditOrAddOrderDialogState extends ConsumerState<EditOrAddOrderDialog> {
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

  /// Mentor controller
  late final TextEditingController mentorController;

  /// Is creation
  late final bool isCreation;

  /// Is commission percentage
  late bool isCommissionPercentage;

  /// Has mentor
  late bool hasMentor = widget.order?.sponsor != null;

  /// Sponsor
  Client? sponsor;

  /// Is hovering sponsor
  late bool _isHoveringSponsor = false;

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
    clientController = TextEditingController(text: widget.order?.client?.name);
    commentController = TextEditingController(text: widget.order?.note);
    mentorController = TextEditingController(text: widget.order?.sponsor);
    formKey = GlobalKey<FormState>();
  }

  /// Build
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(businessTypeServiceNotifierProvider);

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
                    TextVariant(
                      isCreation
                          ? LocaleKeys.createOrder.tr()
                          : LocaleKeys.editOrder.tr(),
                      variantType: TextVariantType.titleLarge,
                    ),
                    IconButton(
                      onPressed: context.pop,
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
                  decoration: InputDecoration(
                    labelText: state.isService
                        ? LocaleKeys.shopName.tr()
                        : LocaleKeys.productName.tr(),
                  ),
                  validator: validator(state.isService
                      ? LocaleKeys.shop.tr()
                      : LocaleKeys.product.tr()),
                ),
                const Gap(32),
                Column(
                  children: [
                    TextFormField(
                      controller: clientController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.clientName.tr(),
                        suffix: InkWell(
                          onTap: () async {
                            final client = await injector<DialogService>()
                                .showSelectClientDialog();

                            if (client != null) {
                              setState(() {
                                clientController.text = client.name;
                              });
                            }
                          },
                          child: TextVariant(
                            "Sélectionner un client",
                            variantType: TextVariantType.bodyMedium,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      validator: validator(LocaleKeys.client.tr()),
                    ),
                    const Gap(8),
                    const HelpText(
                      text:
                          "Si vous saisissez le nom d'un client sans le sélectionner via le bouton, il sera automatiquement ajouté à la liste des clients.\nPour sélectionner un client existant, cliquez sur le champs puis cliquez sur le bouton \"Sélectionner un client\".",
                    ),
                  ],
                ),
                const Gap(32),
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: hasMentor,
                          onChanged: (value) {
                            setState(() {
                              hasMentor = value ?? false;
                            });
                          },
                        ),
                        const Gap(8),
                        TextVariant(
                          "Commande parrainée ?",
                          color: colorScheme.onSurface,
                        ),
                      ],
                    ),
                    if (hasMentor) ...[
                      const Gap(16),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (event) {
                          setState(() {
                            _isHoveringSponsor = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            _isHoveringSponsor = false;
                          });
                        },
                        child: InkWell(
                          onTap: () async {
                            final Client? client =
                                await injector<DialogService>()
                                    .showSelectClientDialog(isSponsor: true);

                            setState(() {
                              sponsor = client;
                              hasMentor = sponsor != null;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: _isHoveringSponsor
                                  ? colorScheme.primary
                                  : colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: colorScheme.outline,
                                width: 1,
                              ),
                            ),
                            child: TextVariant(
                              sponsor != null
                                  ? "Parrain: ${sponsor?.name}"
                                  : "Sélectionner le parrain",
                              color: _isHoveringSponsor
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                const Gap(32),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: orderDateController,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.orderDate.tr(),
                        ),
                        validator: validator(LocaleKeys.orderDate.tr(), true),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: TextFormField(
                        controller: orderDurationController,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.orderDuration.tr(),
                          suffixText: LocaleKeys.days.tr(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: validator(LocaleKeys.orderDuration.tr()),
                      ),
                    ),
                  ],
                ),
                const Gap(32),
                TextFormField(
                  controller: orderAmountController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.orderAmount.tr(),
                    suffixText: LocaleKeys.euros.tr(),
                  ),
                  validator: validator(LocaleKeys.orderAmount.tr()),
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
                              labelText: LocaleKeys.commission.tr(),
                              suffixText: isCommissionPercentage
                                  ? LocaleKeys.percentageSymbol.tr()
                                  : LocaleKeys.euros.tr(),
                            ),
                            validator:
                                validator(LocaleKeys.commission.tr(), true),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: TextFormField(
                            controller: orderInternalFeesController,
                            decoration: InputDecoration(
                              labelText: LocaleKeys.internalFees.tr(),
                              suffixText: LocaleKeys.euros.tr(),
                            ),
                            validator: validator(LocaleKeys.internalFees.tr()),
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
                              LocaleKeys.percentage.tr(),
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
                              LocaleKeys.amount.tr(),
                              color: isCommissionPercentage
                                  ? colorScheme.onSurface
                                  : colorScheme.surface,
                            ),
                          ],
                        ),
                      ]
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 23),
                                child: e,
                              ))
                          .toList(),
                    ),
                  ],
                ),
                const Gap(32),
                TextFormField(
                  controller: trackIdController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.trackId.tr(),
                  ),
                  validator: validatorWithoutNamePrefix(
                    LocaleKeys.trackId.tr(),
                  ),
                ),
                const Gap(32),
                TextFormField(
                  controller: methodController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.method.tr(),
                  ),
                  validator: validator(LocaleKeys.method.tr(), true),
                ),
                const Gap(32),
                TextFormField(
                  controller: intermediaryController,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.intermediary.tr(),
                  ),
                  validator: validator(LocaleKeys.intermediary.tr()),
                ),
                const Gap(32),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.comment.tr(),
                    ),
                    controller: commentController,
                  ),
                ),
                const Gap(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: context.pop,
                      child: Container(
                        width: 150,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(LocaleKeys.cancel.tr()),
                      ),
                    ),
                    const Gap(16),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState?.validate() == false) return;

                        final price = double.tryParse(orderAmountController.text
                                .replaceAll(' €', '')) ??
                            order?.price;
                        final commissionText = double.tryParse(
                                commissionController.text
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

                        context.pop<Order>(
                          order?.copyWith(
                            clientName: clientController.text,
                            intermediaryContact: intermediaryController.text,
                            price: price,
                            shopName: shopNameController.text,
                            startDate: parsedDate ?? order?.startDate,
                            estimatedDuration: Duration(
                                days: duration ??
                                    order?.estimatedDuration.inDays ??
                                    0),
                            commissionRatio:
                                isCommissionPercentage ? commissionText : null,
                            commission: isCommissionPercentage
                                ? price! * commissionText! / 100
                                : commissionText,
                            internalProcessingFee: internalFees,
                            trackId: trackIdController.text,
                            method: methodController.text,
                            note: commentController.text,
                            sponsor: hasMentor ? sponsor?.name : null,
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
                        child: Text(LocaleKeys.save.tr()),
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
