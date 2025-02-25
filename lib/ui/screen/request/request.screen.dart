import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/domain/provider/request_service.provider.dart';
import 'package:squirrel/foundation/extensions/date_time.extension.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// [RequestScreen]
class RequestScreen extends ConsumerStatefulWidget {
  /// Constructor
  /// @param key: Key
  ///
  const RequestScreen({super.key});

  /// Create state
  ///
  @override
  ConsumerState<RequestScreen> createState() => _RequestScreenState();
}

/// [_RequestScreenState]
class _RequestScreenState extends ConsumerState<RequestScreen> {
  /// Build
  /// @param context: Build context
  /// @return Widget
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final requestServiceState = ref.watch(requestServiceNotifierProvider);

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border.all(
            color: colorScheme.outline,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextVariant(
                  LocaleKeys.date.tr(),
                  variantType: TextVariantType.titleMedium,
                ),
                TextVariant(
                  LocaleKeys.name.tr(),
                  variantType: TextVariantType.titleMedium,
                ),
                TextVariant(
                  LocaleKeys.destination.tr(),
                  variantType: TextVariantType.titleMedium,
                ),
                TextVariant(
                  LocaleKeys.description.tr(),
                  variantType: TextVariantType.titleMedium,
                ),
                TextVariant(
                  LocaleKeys.parameters.tr(),
                  variantType: TextVariantType.titleMedium,
                ),
              ],
            ),
            const Gap(20),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: requestServiceState.requests.length,
              itemBuilder: (context, index) {
                final request = requestServiceState.requests[index];
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: TextVariant(
                            request.date?.toDDMMYYYY() ?? '',
                            variantType: TextVariantType.bodyMedium,
                          ),
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextVariant(
                            request.name ?? '',
                            variantType: TextVariantType.bodyMedium,
                          ),
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextVariant(
                            request.destination ?? '',
                            variantType: TextVariantType.bodyMedium,
                          ),
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextVariant(
                            request.description ?? '',
                            variantType: TextVariantType.bodyMedium,
                          ),
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextVariant(
                            request.parameters?.toString() ?? '',
                            variantType: TextVariantType.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: colorScheme.outline.withValues(alpha: .5),
                      height: 20,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
