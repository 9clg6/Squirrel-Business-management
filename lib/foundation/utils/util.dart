import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme() {
  return GoogleFonts.interTextTheme();
}

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

String? Function(String?)? validator(
  String label, [
  bool feminine = false,
]) {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Le ${feminine ? 'nom de la' : 'nom du'} ${label.toLowerCase()} est obligatoire';
    }
    return null;
  };
}

String? Function(String?)? validatorWithoutNamePrefix(
  String label,
) {
  return (value) {
    if (value == null || value.isEmpty) {
      return 'Le ${label.toLowerCase()} est obligatoire';
    }
    return null;
  };
}
