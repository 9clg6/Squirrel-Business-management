import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/state/auth.state.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/foundation/enums/service_type.enum.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authServiceProvider);

    final Duration timeRemain =
        authState.value?.expirationDate?.difference(DateTime.now()) ??
            const Duration(days: 0);
    final int daysRemain = timeRemain.inDays;
    final int hoursRemain = timeRemain.inHours % 24;
    final int minutesRemain = timeRemain.inMinutes % 60;

    switch (authState) {
      case AsyncData(value: AuthState()):
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
          actions: [
            TextVariant(
              LocaleKeys.yourLicenseWillExpireIn.tr(
                args: [
                  daysRemain.toString(),
                  hoursRemain.toString(),
                  minutesRemain.toString(),
                ],
              ),
              variantType: TextVariantType.bodyMedium,
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            const Gap(22),
            if (daysRemain <= 0) ...[
              TextVariant(
                LocaleKeys.contactYourProviderToRenew.tr(),
                variantType: TextVariantType.bodySmall,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              const Gap(10),
            ],
            const Gap(22),
            Consumer(
              builder: (context, ref, child) {
                final bState = ref.watch(businessTypeServiceProvider);
                final bVm = ref.read(businessTypeServiceProvider.notifier);

                return switch (bState) {
                  AsyncData(value: BusinessTypeState()) => SizedBox(
                      height: 32,
                      child: ToggleButtons(
                        borderRadius: BorderRadius.circular(10),
                        borderColor: colorScheme.outline.withValues(alpha: .5),
                        borderWidth: 1,
                        fillColor: colorScheme.primary,
                        selectedColor: colorScheme.onPrimary,
                        isSelected: [
                          bState.value.businessType == BusinessType.service,
                          bState.value.businessType != BusinessType.service,
                        ],
                        onPressed: (_) => bVm.invertServiceType(),
                        children: [
                          Row(
                            children: [
                              if (bState.value.businessType ==
                                  BusinessType.service)
                                Icon(
                                  Icons.check_circle_outline,
                                  color: colorScheme.onSurface,
                                  size: 16,
                                ),
                              const Gap(10),
                              TextVariant(
                                "Mode service",
                                variantType: TextVariantType.bodyMedium,
                                color: colorScheme.onSurface,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              if (bState.value.businessType ==
                                  BusinessType.shop)
                                Icon(
                                  Icons.check_circle_outline,
                                  color: colorScheme.onSurface,
                                  size: 16,
                                ),
                              const Gap(10),
                              TextVariant(
                                "Mode boutique",
                                variantType: TextVariantType.bodyMedium,
                                color: colorScheme.onSurface,
                              )
                            ],
                          ),
                        ]
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: e,
                                ))
                            .toList(),
                      ),
                    ),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
            const Gap(22),
            Consumer(
              builder: (context, ref, child) {
                final requestServiceNotifier =
                    ref.read(requestServiceProvider.notifier);
                final requestService = ref.watch(requestServiceProvider);

                return FilledButton.icon(
                  onPressed: requestServiceNotifier.toggleRequest,
                  label: TextVariant(
                    LocaleKeys.requestWeb.tr(),
                    variantType: TextVariantType.bodyMedium,
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
                      width: 1,
                    ),
                  ),
                );
              },
            ),
            const Gap(10)
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  /// Get the preferred size of the app bar
  /// @return [Size] preferred size of the app bar
  ///
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
