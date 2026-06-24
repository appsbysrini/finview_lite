import 'package:flutter/material.dart';

/// Light and dark [ThemeData] definitions for FinView Lite.
abstract final class AppThemes {
  /// Shared seed color for both themes.
  static const seedColor = Colors.deepPurple;

  /// Light Material 3 theme.
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
    useMaterial3: true,
  );

  /// Dark Material 3 theme.
  static final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
