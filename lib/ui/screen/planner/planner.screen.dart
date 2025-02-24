import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:squirrel/gen/assets.gen.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

///
/// Planner screen
///
class PlannerScreen extends ConsumerStatefulWidget {
  ///
  /// Constructor
  ///
  const PlannerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlannerScreenState();
}

///
/// State of the planner screen
///
class _PlannerScreenState extends ConsumerState<PlannerScreen> {
  ///
  /// Builds the planner screen
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
              'Fonctionnalités à venir',
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
