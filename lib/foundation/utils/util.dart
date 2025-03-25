import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Create text theme
/// @return [TextTheme] text theme
///
TextTheme createTextTheme() {
  return GoogleFonts.interTextTheme();
}

/// Compute data row color
/// @param [colorScheme] color scheme
/// @return [WidgetStateProperty<Color?>] widget state property
///
WidgetStateProperty<Color?> computeDataRowColor(ColorScheme colorScheme) {
  return WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };

    if (states.any(interactiveStates.contains)) {
      return colorScheme.primaryContainer;
    }
    return Colors.transparent;
  });
}

/// Validator
/// @param [label] label
/// @param [feminine] feminine
/// @return [String? Function(String?)] validator
///
String? Function(String?)? validator(
  String label, {
  bool feminine = false,
}) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return 'Le ${feminine ? 'nom de la' : 'nom du'} '
          '${label.toLowerCase()} est obligatoire';
    }
    return null;
  };
}

/// Validator without name prefix
/// @param [label] label
/// @return [String? Function(String?)] validator
///
String? Function(String?)? validatorWithoutNamePrefix(
  String label,
) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return 'Le ${label.toLowerCase()} est obligatoire';
    }
    return null;
  };
}
