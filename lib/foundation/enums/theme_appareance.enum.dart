// ignore_for_file: sort_constructors_first Enum cant declare constructor in 
//  first

import 'package:flutter/material.dart';

///
/// Theme appearance
///
enum ThemeAppearance {
  ///
  /// Light appearance for [ThemeMode.light]
  ///
  light(ThemeMode.light),

  ///
  /// Dark appearance for [ThemeMode.dark]
  ///
  dark(ThemeMode.dark),

  ///
  /// System appearance
  ///
  system(ThemeMode.system);

  /// Matching [ThemeMode] of this [ThemeAppearance]
  final ThemeMode matchingThemeMode;

  /// Constructor
  /// @param [matchingThemeMode] matching theme mode
  ///
  const ThemeAppearance(this.matchingThemeMode);
}
