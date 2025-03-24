import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFF6600), // --primary-100
      surfaceTint: Color(0xFFFF6600), // --primary-100
      onPrimary: Color(0xFFFFFFFF), // --text-100
      primaryContainer: Color(0xFFff983f), // --primary-200
      onPrimaryContainer: Color(0xFFffffa1), // --primary-300
      secondary: Color(0xFFff983f), // --primary-200
      onSecondary: Color(0xFFFFFFFF),
      outline: Color(0xff74777c),
      shadow: Color(0xffD5D5D5),
      secondaryContainer: Color(0xff288180),
      onSecondaryContainer: Color(0xfff3fffe),
      tertiary: Color(0xff02696a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffafffff),
      onTertiaryContainer: Color(0xff217979),
      error: Color(0xffbb0018),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffe1262c),
      onErrorContainer: Color(0xfffffbff),
      surface: Color(0xffffffff),
      onSurface: Color(0xff1b1c1d),
      onSurfaceVariant: Color(0xff43474c),
      outlineVariant: Color(0xffc4c7cc),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303031),
      inversePrimary: Color(0xff84d4d3),
      primaryFixed: Color(0xffa0f0f0),
      onPrimaryFixed: Color(0xff002020),
      primaryFixedDim: Color(0xff84d4d3),
      onPrimaryFixedVariant: Color(0xff004f50),
      secondaryFixed: Color(0xff9ff1ef),
      onSecondaryFixed: Color(0xff002020),
      secondaryFixedDim: Color(0xff83d4d3),
      onSecondaryFixedVariant: Color(0xff00504f),
      tertiaryFixed: Color(0xffa1f0f0),
      onTertiaryFixed: Color(0xff002020),
      tertiaryFixedDim: Color(0xff85d4d4),
      onTertiaryFixedVariant: Color(0xff004f50),
      surfaceDim: Color(0xffFCFAFC),
      surfaceBright: Color(0xfffbf9fa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3f4),
      surfaceContainer: Color(0xffefedee),
      surfaceContainerHigh: Color(0xffe9e8e9),
      surfaceContainerHighest: Color(0xffe4e2e3),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003d3d),
      surfaceTint: Color(0xff016a6a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0d6e6e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003d3d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff1d7978),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003d3e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff217979),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff73000a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffd61b25),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf9fa),
      onSurface: Color(0xff101112),
      onSurfaceVariant: Color(0xff33363b),
      outline: Color(0xff4f5358),
      outlineVariant: Color(0xff6a6d72),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303031),
      inversePrimary: Color(0xff84d4d3),
      primaryFixed: Color(0xff217979),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005f5f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff1d7978),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff005f5e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff217979),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005f60),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc7c6c7),
      surfaceBright: Color(0xfffbf9fa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5f3f4),
      surfaceContainer: Color(0xffe9e8e9),
      surfaceContainerHigh: Color(0xffdedcdd),
      surfaceContainerHighest: Color(0xffd3d1d2),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003232),
      surfaceTint: Color(0xff016a6a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005252),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003232),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff005252),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003232),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005253),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600007),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff980011),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffbf9fa),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292c31),
      outlineVariant: Color(0xff46494e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303031),
      inversePrimary: Color(0xff84d4d3),
      primaryFixed: Color(0xff005252),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003939),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff005252),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003939),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005253),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00393a),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbab8b9),
      surfaceBright: Color(0xfffbf9fa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f0f1),
      surfaceContainer: Color(0xffe4e2e3),
      surfaceContainerHigh: Color(0xffd5d4d5),
      surfaceContainerHighest: Color(0xffc7c6c7),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFF6600), // --primary-100
      surfaceTint: Color(0xFFFF6600), // --primary-100
      onPrimary: Color(0xFFFFFFFF), // --text-100
      primaryContainer: Color(0xFFff983f), // --primary-200
      onPrimaryContainer: Color(0xFFffffa1), // --primary-300
      secondary: Color(0xFFff983f), // --primary-200
      onSecondary: Color(0xFFFFFFFF), // --text-100
      secondaryContainer: Color(0xFF444648), // --bg-300
      onSecondaryContainer: Color(0xFFe0e0e0), // --text-200
      tertiary: Color(0xFFF5F5F5), // --accent-100
      onTertiary: Color(0xFF1D1F21), // --bg-100
      tertiaryContainer: Color(0xFF929292), // --accent-200
      onTertiaryContainer: Color(0xFFFFFFFF), // --text-100
      error: Color(0xffffb3ac), // Gardé la même
      onError: Color(0xff680008), // Gardé la même
      errorContainer: Color(0xffff544e), // Gardé la même
      onErrorContainer: Color(0xff4d0004), // Gardé la même
      surface: Color(0xFF2c2e30), // --bg-100
      onSurface: Color(0xFFFFFFFF), // --text-100
      onSurfaceVariant: Color(0xFFe0e0e0), // --text-200
      outline: Color(0xFF929292), // --accent-200
      outlineVariant: Color(0xFF444648), // --bg-300
      shadow: Color(0xff000000), // Gardé la même
      scrim: Color(0xff000000), // Gardé la même
      inverseSurface: Color(0xFFFFFFFF), // --text-100
      inversePrimary: Color(0xFFFF6600), // --primary-100
      surfaceDim: Color(0xFF1D1F21), // --bg-100
      surfaceBright: Color(0xFF444648), // --bg-300
      surfaceContainerLowest: Color(0xFF1D1F21), // --bg-100
      surfaceContainerLow: Color(0xFF2c2e30), // --bg-200
      surfaceContainer: Color(0xFF2c2e30), // --bg-200
      surfaceContainerHigh: Color(0xFF444648), // --bg-300
      surfaceContainerHighest: Color(0xFF444648), // --bg-300
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9aeae9),
      surfaceTint: Color(0xff84d4d3),
      onPrimary: Color(0xff002b2b),
      primaryContainer: Color(0xff4c9d9d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xff99eae9),
      onSecondary: Color(0xff002b2b),
      secondaryContainer: Color(0xff4a9d9c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff003737),
      tertiaryContainer: Color(0xffa1f0f0),
      onTertiaryContainer: Color(0xff005151),
      error: Color(0xffffd2cd),
      onError: Color(0xff540005),
      errorContainer: Color(0xffff544e),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131314),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdadce2),
      outline: Color(0xffafb2b7),
      outlineVariant: Color(0xff8d9096),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e2e3),
      inversePrimary: Color(0xff005151),
      primaryFixed: Color(0xffa0f0f0),
      onPrimaryFixed: Color(0xff001414),
      primaryFixedDim: Color(0xff84d4d3),
      onPrimaryFixedVariant: Color(0xff003d3d),
      secondaryFixed: Color(0xff9ff1ef),
      onSecondaryFixed: Color(0xff001414),
      secondaryFixedDim: Color(0xff83d4d3),
      onSecondaryFixedVariant: Color(0xff003d3d),
      tertiaryFixed: Color(0xffa1f0f0),
      onTertiaryFixed: Color(0xff001415),
      tertiaryFixedDim: Color(0xff85d4d4),
      onTertiaryFixedVariant: Color(0xff003d3e),
      surfaceDim: Color(0xff131314),
      surfaceBright: Color(0xff444446),
      surfaceContainerLowest: Color(0xff070708),
      surfaceContainerLow: Color(0xff1d1e1f),
      surfaceContainer: Color(0xff272829),
      surfaceContainerHigh: Color(0xff323234),
      surfaceContainerHighest: Color(0xff3d3e3f),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffaefefd),
      surfaceTint: Color(0xff84d4d3),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff80d0cf),
      onPrimaryContainer: Color(0xff000e0e),
      secondary: Color(0xffacfefd),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff7fd0cf),
      onSecondaryContainer: Color(0xff000e0e),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa1f0f0),
      onTertiaryContainer: Color(0xff003030),
      error: Color(0xffffecea),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea6),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff131314),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffedf0f6),
      outlineVariant: Color(0xffc0c3c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e2e3),
      inversePrimary: Color(0xff005151),
      primaryFixed: Color(0xffa0f0f0),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff84d4d3),
      onPrimaryFixedVariant: Color(0xff001414),
      secondaryFixed: Color(0xff9ff1ef),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff83d4d3),
      onSecondaryFixedVariant: Color(0xff001414),
      tertiaryFixed: Color(0xffa1f0f0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff85d4d4),
      onTertiaryFixedVariant: Color(0xff001415),
      surfaceDim: Color(0xff131314),
      surfaceBright: Color(0xff505051),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1f2021),
      surfaceContainer: Color(0xff303031),
      surfaceContainerHigh: Color(0xff3b3b3c),
      surfaceContainerHighest: Color(0xff464748),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          iconTheme: IconThemeData(color: colorScheme.onSurface),
          titleTextStyle: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.onSurfaceVariant,
        ),
        cardTheme: CardTheme(
          color: colorScheme.surfaceContainer,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: colorScheme.outline),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surfaceContainerLow,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
        ),
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
