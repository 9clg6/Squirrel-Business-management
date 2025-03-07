import 'package:flutter/material.dart';

/// Help text
class HelpText extends StatelessWidget {
  /// Text
  final String text;

  /// Constructor
  /// @param [key] key
  /// @param [text] text
  /// 
  const HelpText({
    super.key,
    required this.text,
  });

  /// Build
  /// @param [context] context
  /// @return [Widget] widget of the help text
  /// 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(
          Icons.info_outline,
          color: colorScheme.onSurface.withValues(alpha: .6),
          size: 16,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: colorScheme.onSurface.withValues(alpha: .6),
            ),
          ),
        ),
      ],
    );
  }
}
