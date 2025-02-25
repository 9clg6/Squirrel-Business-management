import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/gen/assets.gen.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Planner screen
class PlannerScreen extends ConsumerStatefulWidget {
  /// Constructor
  /// @param [key] key
  ///
  const PlannerScreen({super.key});

  /// Creates the state of the planner screen
  /// @return [ConsumerState<ConsumerStatefulWidget>] state of the planner screen
  ///
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlannerScreenState();
}

/// State of the planner screen
class _PlannerScreenState extends ConsumerState<PlannerScreen> {
  /// Builds the planner screen
  /// @param [context] context
  /// @return [Widget] widget of the planner screen
  /// 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextVariant(
              LocaleKeys.comingSoon.tr(),
              variantType: TextVariantType.titleLarge,
              color: colorScheme.onSurface.withValues(alpha: .9),
            ),
            const SizedBox(height: 20),
            SvgPicture.asset(
              Assets.images.wip,
              width: 200,
              height: 200,
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface.withValues(alpha: .9),
                BlendMode.srcIn,
              ),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
