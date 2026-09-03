import 'package:flutter/material.dart';

ThemeData flashKidsTheme() {
  final baseTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  return baseTheme.copyWith(textTheme: _boldTextTheme(baseTheme.textTheme));
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
