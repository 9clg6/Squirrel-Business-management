import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/service/auth.service.dart';
import 'package:init/ui/widgets/text_variant.dart';

/// Custom app bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor
  const CustomAppBar({super.key});

  /// Build the app bar
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authService = injector<AuthService>();
    final Duration timeRemain =
        authService.expirationDate!.difference(DateTime.now());
    final bool timeRemainInDays = timeRemain.inDays > 0;
    final int timeRemainAdjuster =
        timeRemainInDays ? timeRemain.inDays : timeRemain.inHours;

    return AppBar(
      elevation: 0,
      leadingWidth: 200,
      leading: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Center(
          child: TextVariant(
            "Squirrel",
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
          "Votre licence expire dans ${timeRemainInDays ? timeRemainAdjuster.toString() : timeRemainAdjuster.toString()} ${timeRemainInDays ? "jours" : "heures"}",
          variantType: TextVariantType.bodyMedium,
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
        const Gap(10),
        if(!timeRemainInDays) TextVariant(
          "| Contactez votre fournisseur pour la renouveler",
          variantType: TextVariantType.bodyMedium,
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
        const Gap(10),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surface,
            fixedSize: const Size(15, 15),
            hoverColor: colorScheme.primaryContainer,
          ),
          icon: const Icon(
            Icons.notifications,
            size: 18,
          ),
        ),
        const Gap(10),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surface,
            fixedSize: const Size(15, 15),
            hoverColor: colorScheme.primaryContainer,
          ),
          icon: const Icon(
            Icons.person,
            size: 18,
          ),
        ),
        const Gap(10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
