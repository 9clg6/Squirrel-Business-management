import 'package:flutter/material.dart';

/// Help text
class HelpText extends StatelessWidget {
  /// Text
  final String text;

  /// Constructor
  ///
  const HelpText({
    super.key,
    required this.text,
  });

  /// Build
  ///
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(
          Icons.info_outline,
          color: colorScheme.outline.withValues(alpha: .8),
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: colorScheme.outline.withValues(alpha: .8),
          ),
        ),
      ],
    );
  }
}
