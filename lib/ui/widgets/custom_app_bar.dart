import 'package:flutter/material.dart';

/// Custom app bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor
  const CustomAppBar({super.key});

  /// Build the app bar
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 200,
      leading: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          "Aiir",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      actions: [
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
