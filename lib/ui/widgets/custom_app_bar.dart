import 'package:flutter/material.dart';
import 'package:init/ui/widgets/text_variant.dart';
import 'package:uuid/uuid.dart';

/// Custom app bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor
  const CustomAppBar({super.key});

  /// Build the app bar
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      foregroundColor: colorScheme.onSurface,
      actions: [
        Text(
          "Expire dans 30 jours",
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          const Uuid().v4(),
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
            size: 18,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            size: 18,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
            size: 18,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
