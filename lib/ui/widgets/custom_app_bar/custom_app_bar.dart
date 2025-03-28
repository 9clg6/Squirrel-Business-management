import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/state/auth.state.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/domain/state/request.state.dart';
import 'package:squirrel/foundation/enums/service_type.enum.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Custom app bar
class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  /// Constructor
  /// @param [key] key
  ///
  const CustomAppBar({super.key});

  /// Build the app bar
  /// @param [context] context
  /// @return [Widget] widget of the app bar
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AsyncValue<AuthState> authState = ref.watch(authServiceProvider);

    return AppBar(
      elevation: 0,
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: TextVariant(
            LocaleKeys.squirrel.tr(),
            variantType: TextVariantType.bodyLarge,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: colorScheme.surfaceDim,
      surfaceTintColor: Colors.transparent,
      foregroundColor: colorScheme.onSurface,
      actions: <Widget>[
        authState.when(
          data: (AuthState authValue) {
            return TextVariant(
              LocaleKeys.yourLicenseWillExpireIn.tr(
                args: <String>[
                  authValue.expirationDate?.toDDMMYYYY() ?? '',
                ],
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (Object object, StackTrace stackTrace) =>
              Text(object.toString()),
        ),
        const Gap(22),
        ref.watch(authServiceProvider).when(
              data: (AuthState authValue) {
                final Duration timeRemain =
                    authValue.expirationDate?.difference(DateTime.now()) ??
                        Duration.zero;
                final int daysRemain = timeRemain.inDays;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    if (daysRemain <= 0) ...<Widget>[
                      TextVariant(
                        LocaleKeys.contactYourProviderToRenew.tr(),
                        variantType: TextVariantType.bodySmall,
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                      const Gap(10),
                    ],
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
        const Gap(22),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final AsyncValue<BusinessTypeState> bState =
                ref.watch(businessTypeServiceProvider);
            final BusinessTypeService bVm =
                ref.read(businessTypeServiceProvider.notifier);

            return switch (bState) {
              AsyncData<BusinessTypeState>() => SizedBox(
                  height: 32,
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(10),
                    borderColor: colorScheme.outline.withValues(alpha: .5),
                    borderWidth: 1,
                    fillColor: colorScheme.primary,
                    selectedColor: colorScheme.onPrimary,
                    isSelected: <bool>[
                      bState.value.businessType == BusinessType.service,
                      bState.value.businessType != BusinessType.service,
                    ],
                    onPressed: (_) => bVm.invertServiceType(),
                    children: <Row>[
                      Row(
                        children: <Widget>[
                          if (bState.value.businessType == BusinessType.service)
                            Icon(
                              Icons.check_circle_outline,
                              color: colorScheme.onPrimary,
                              size: 16,
                            ),
                          const Gap(10),
                          TextVariant(
                            LocaleKeys.serviceMode.tr(),
                            color: bState.value.businessType ==
                                    BusinessType.service
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          if (bState.value.businessType == BusinessType.shop)
                            Icon(
                              Icons.check_circle_outline,
                              color: colorScheme.onPrimary,
                              size: 16,
                            ),
                          const Gap(10),
                          TextVariant(
                            LocaleKeys.shopMode.tr(),
                            color:
                                bState.value.businessType == BusinessType.shop
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurface,
                          ),
                        ],
                      ),
                    ]
                        .map(
                          (Row e) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: e,
                          ),
                        )
                        .toList(),
                  ),
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
        const Gap(22),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final RequestService requestServiceNotifier =
                ref.read(requestServiceProvider.notifier);
            final RequestState requestService =
                ref.watch(requestServiceProvider);

            return FilledButton.icon(
              onPressed: requestServiceNotifier.toggleRequest,
              label: TextVariant(
                LocaleKeys.requestWeb.tr(),
              ),
              icon: Icon(
                Icons.language,
                size: 18,
                color: colorScheme.onSurface,
              ),
              style: FilledButton.styleFrom(
                backgroundColor: requestService.isRequestShow
                    ? colorScheme.primary
                    : colorScheme.surface,
                foregroundColor: colorScheme.onSurface,
                overlayColor: colorScheme.secondary,
                side: BorderSide(
                  color: colorScheme.outline.withValues(alpha: .5),
                ),
              ),
            );
          },
        ),
        const Gap(10),
      ],
    );
  }

  /// Get the preferred size of the app bar
  /// @return [Size] preferred size of the app bar
  ///
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
