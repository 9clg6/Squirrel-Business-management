import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/domain/entities/request.entity.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/state/request.state.dart';
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final RequestState requestServiceState = ref.watch(requestServiceProvider);

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
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
              itemBuilder: (BuildContext context, int index) {
                final Request request = requestServiceState.requests[index];
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: TextVariant(
                            request.date?.toDDMMYYYY() ?? '',
                          ),
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextVariant(
                            request.name ?? '',
                          ),
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextVariant(
                            request.destination ?? '',
                          ),
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextVariant(
                            request.description ?? '',
                          ),
                        ),
                        const Gap(5),
                        Flexible(
                          child: TextVariant(
                            request.parameters?.toString() ?? '',
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
