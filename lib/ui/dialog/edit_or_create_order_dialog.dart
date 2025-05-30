import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/customer.entity.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/providers/service/dialog.service.provider.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/widgets/help_text.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Edit or add order dialog
class EditOrAddOrderDialog extends ConsumerStatefulWidget {
  /// Constructor
  /// @param [isCreation] is creation
  /// @param [order] order
  ///
  const EditOrAddOrderDialog({
    super.key,
    this.isCreation = false,
    this.order,
  });

  /// Is creation
  final bool isCreation;

  /// Order
  final Order? order;

  /// Creates the state of the edit or add order dialog
  /// @return [ConsumerState<EditOrAddOrderDialog>] state \
  ///   of the edit or add order dialog
  ///
  @override
  ConsumerState<EditOrAddOrderDialog> createState() =>
      _EditOrAddOrderDialogState();
}

class _EditOrAddOrderDialogState extends ConsumerState<EditOrAddOrderDialog> {
  /// Constructor
  ///
  _EditOrAddOrderDialogState();

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

  /// Order clicustent controller
  late final TextEditingController customerController;

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
  Customer? sponsor;

  /// Is hovering sponsor
  late bool _isHoveringSponsor = false;

  /// Initializes the state of the edit or add order dialog
  ///
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
      text: '${widget.order?.estimatedDuration.inDays}',
    );
    commissionController = TextEditingController(
      text: widget.order?.commissionRatio != null
          ? '${widget.order?.commissionRatio}'
          : '${widget.order?.commission}',
    );
    orderAmountController =
        TextEditingController(text: '${widget.order?.price}');
    orderInternalFeesController =
        TextEditingController(text: '${widget.order?.internalProcessingFee}');
    trackIdController = TextEditingController(text: widget.order?.trackId);
    methodController = TextEditingController(text: widget.order?.method);
    intermediaryController =
        TextEditingController(text: widget.order?.intermediaryContact);
    customerController =
        TextEditingController(text: widget.order?.customer?.name);
    commentController = TextEditingController(text: widget.order?.note);
    mentorController = TextEditingController(text: widget.order?.sponsor);
    formKey = GlobalKey<FormState>();
  }

  /// Builds the edit or add order dialog
  /// @return [Widget] widget of the edit or add order dialog
  ///
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AsyncValue<BusinessTypeState> state =
        ref.watch(businessTypeServiceProvider);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(22),
        width: 600,
        child: switch (state) {
          AsyncData<BusinessTypeState>(value: BusinessTypeState()) =>
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                        labelText: state.value.isService
                            ? LocaleKeys.shopName.tr()
                            : LocaleKeys.productName.tr(),
                      ),
                      validator: validator(
                        state.value.isService
                            ? LocaleKeys.shop.tr()
                            : LocaleKeys.product.tr(),
                      ),
                    ),
                    const Gap(32),
                    Column(
                      children: <Widget>[
                        TextFormField(
                          controller: customerController,
                          decoration: InputDecoration(
                            labelText: LocaleKeys.clientName.tr(),
                            suffix: InkWell(
                              onTap: () async {
                                final Customer? customer = await ref
                                    .watch(dialogServiceProvider)
                                    .showSelectCustomerDialog();

                                if (customer != null) {
                                  setState(() {
                                    customerController.text = customer.name;
                                  });
                                }
                              },
                              child: TextVariant(
                                LocaleKeys.selectClient.tr(),
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                          validator: validator(LocaleKeys.client.tr()),
                        ),
                        const Gap(8),
                        HelpText(text: LocaleKeys.clientSelection.tr()),
                      ],
                    ),
                    const Gap(32),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: hasMentor,
                              onChanged: (bool? value) {
                                setState(() {
                                  hasMentor = value ?? false;
                                });
                              },
                            ),
                            const Gap(8),
                            TextVariant(
                              LocaleKeys.sponsoredOrder.tr(),
                              color: colorScheme.onSurface,
                            ),
                          ],
                        ),
                        if (hasMentor) ...<Widget>[
                          const Gap(16),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (PointerEnterEvent event) {
                              setState(() {
                                _isHoveringSponsor = true;
                              });
                            },
                            onExit: (PointerExitEvent event) {
                              setState(() {
                                _isHoveringSponsor = false;
                              });
                            },
                            child: InkWell(
                              onTap: () async {
                                final Customer? customer = await ref
                                    .watch(dialogServiceProvider)
                                    .showSelectCustomerDialog(
                                      isSponsor: true,
                                    );

                                setState(() {
                                  sponsor = customer;
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
                                  ),
                                ),
                                child: TextVariant(
                                  sponsor != null
                                      ? LocaleKeys.sponsorWithName.tr(
                                          args: <String>[
                                            sponsor?.name ?? '',
                                          ],
                                        )
                                      : LocaleKeys.selectSponsor.tr(),
                                  color: _isHoveringSponsor
                                      ? colorScheme.onPrimary
                                      : colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const Gap(32),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: orderDateController,
                            decoration: InputDecoration(
                              labelText: LocaleKeys.orderDate.tr(),
                            ),
                            validator: validator(
                              LocaleKeys.orderDate.tr(),
                              feminine: true,
                            ),
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
                            inputFormatters: <TextInputFormatter>[
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    const Gap(32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: commissionController,
                                decoration: InputDecoration(
                                  labelText: LocaleKeys.commission.tr(),
                                  suffixText: isCommissionPercentage
                                      ? LocaleKeys.percentageSymbol.tr()
                                      : LocaleKeys.euros.tr(),
                                ),
                                validator: validator(
                                  LocaleKeys.commission.tr(),
                                  feminine: true,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
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
                                validator: validator(
                                  LocaleKeys.internalFees.tr(),
                                  feminine: true,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
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
                          isSelected: <bool>[
                            isCommissionPercentage,
                            !isCommissionPercentage,
                          ],
                          onPressed: (int value) {
                            setState(() {
                              isCommissionPercentage = !isCommissionPercentage;
                            });
                          },
                          children: <Row>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
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
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
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
                              .map(
                                (Row e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 23,
                                  ),
                                  child: e,
                                ),
                              )
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
                      validator: validator(
                        LocaleKeys.method.tr(),
                        feminine: true,
                      ),
                    ),
                    const Gap(32),
                    TextFormField(
                      controller: intermediaryController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.intermediary.tr(),
                      ),
                      validator: validator(
                        LocaleKeys.intermediary.tr(),
                        feminine: true,
                      ),
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
                      children: <Widget>[
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
                            if (formKey.currentState?.validate() == false) {
                              return;
                            }

                            final double? price = double.tryParse(
                                  orderAmountController.text
                                      .replaceAll(' €', ''),
                                ) ??
                                order?.price;
                            final double? commissionText = double.tryParse(
                                  commissionController.text
                                      .replaceAll(' €', ''),
                                ) ??
                                order?.commission;
                            final double? internalFees = double.tryParse(
                                  orderInternalFeesController.text
                                      .replaceAll(' €', ''),
                                ) ??
                                order?.internalProcessingFee;
                            final int? duration = int.tryParse(
                                  orderDurationController.text
                                      .replaceAll(' jours', ''),
                                ) ??
                                order?.estimatedDuration.inDays;

                            DateTime? parsedDate;
                            try {
                              final List<String> dateParts =
                                  orderDateController.text.split('/');
                              if (dateParts.length == 3) {
                                final String formattedDate =
                                    '${dateParts[2]}-${dateParts[1]}-'
                                    '${dateParts[0]}';
                                parsedDate = DateTime.parse(formattedDate);
                              }
                            } on Exception catch (_) {
                              parsedDate = order?.startDate;
                            }

                            context.pop<Order>(
                              order?.copyWith(
                                customerName: customerController.text,
                                intermediaryContact:
                                    intermediaryController.text,
                                price: price,
                                shopName: shopNameController.text,
                                startDate: parsedDate ?? order?.startDate,
                                estimatedDuration: Duration(
                                  days: duration ??
                                      order?.estimatedDuration.inDays ??
                                      0,
                                ),
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
                            child: TextVariant(
                              LocaleKeys.save.tr(),
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          _ => const Center(
              child: CircularProgressIndicator(),
            ),
        },
      ),
    );
  }
}
