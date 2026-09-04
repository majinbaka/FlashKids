import 'package:flutter/material.dart';

const _flashKidsRed = Color(0xFFDF301C);
const _flashKidsOrange = Color(0xFFFF9100);
const _flashKidsCream = Color(0xFFFFF1D1);
const _flashKidsCyan = Color(0xFF00B7CD);
const _flashKidsKidZoneBackground = Color(0xFFFFF1D1);
const _flashKidsRedContainer = Color(0xFFFFDBD5);
const _flashKidsOrangeContainer = Color(0xFFFFE0B2);
const _flashKidsCyanContainer = Color(0xFFB7F2F8);
const _flashKidsOnRedContainer = Color(0xFF4A0A04);
const _flashKidsOnOrangeContainer = Color(0xFF3B1D00);
const _flashKidsOnCyanContainer = Color(0xFF00363D);
const _flashKidsOnPrimary = Color(0xFFFFFFFF);
const _flashKidsOnSurface = Color(0xFF251A13);
const _flashKidsOnSurfaceVariant = Color(0xFF53433A);
const _flashKidsOutline = Color(0xFF85736A);

ThemeData flashKidsTheme() {
  final baseTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _flashKidsRed,
      primary: _flashKidsRed,
      onPrimary: _flashKidsOnPrimary,
      secondary: _flashKidsOrange,
      onSecondary: _flashKidsOnOrangeContainer,
      tertiary: _flashKidsCyan,
      onTertiary: _flashKidsOnCyanContainer,
      surface: _flashKidsCream,
      primaryContainer: _flashKidsRedContainer,
      onPrimaryContainer: _flashKidsOnRedContainer,
      secondaryContainer: _flashKidsOrangeContainer,
      onSecondaryContainer: _flashKidsOnOrangeContainer,
      tertiaryContainer: _flashKidsCyanContainer,
      onTertiaryContainer: _flashKidsOnCyanContainer,
      onSurface: _flashKidsOnSurface,
      onSurfaceVariant: _flashKidsOnSurfaceVariant,
      outline: _flashKidsOutline,
      inverseSurface: _flashKidsKidZoneBackground,
      onInverseSurface: _flashKidsOnOrangeContainer,
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFFFF8E6),
      surfaceContainer: const Color(0xFFF9EAD0),
      surfaceContainerHigh: const Color(0xFFF3E3C9),
      surfaceContainerHighest: const Color(0xFFEDDCC1),
    ),
    useMaterial3: true,
  );

  return baseTheme.copyWith(
    scaffoldBackgroundColor: _flashKidsKidZoneBackground,
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: _flashKidsOutline, width: 3),
      ),
    ),
    textTheme: _boldTextTheme(baseTheme.textTheme),
  );
}

TextTheme _boldTextTheme(TextTheme textTheme) {
  TextStyle? style(TextStyle? value) => value?.copyWith(
    fontFamily: 'Baloo2',
    fontSize: value.fontSize == null ? null : value.fontSize! * 1.15,
    fontWeight: FontWeight.bold,
  );

  return textTheme.copyWith(
    displayLarge: style(textTheme.displayLarge),
    displayMedium: style(textTheme.displayMedium),
    displaySmall: style(textTheme.displaySmall),
    headlineLarge: style(textTheme.headlineLarge),
    headlineMedium: style(textTheme.headlineMedium),
    headlineSmall: style(textTheme.headlineSmall),
    titleLarge: style(textTheme.titleLarge),
    titleMedium: style(textTheme.titleMedium),
    titleSmall: style(textTheme.titleSmall),
    bodyLarge: style(textTheme.bodyLarge),
    bodyMedium: style(textTheme.bodyMedium),
    bodySmall: style(textTheme.bodySmall),
    labelLarge: style(textTheme.labelLarge),
    labelMedium: style(textTheme.labelMedium),
    labelSmall: style(textTheme.labelSmall),
  );
}
