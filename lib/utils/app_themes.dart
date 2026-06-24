import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_design_tokens.dart';

/// Light and dark [ThemeData] definitions for the FinView Lite design system.
abstract final class AppThemes {
  /// Brand indigo used as the primary accent.
  static const seedColor = Color(0xFF4F46E5);

  /// Light theme with a clean startup fintech aesthetic.
  static final ThemeData light = _buildTheme(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF18181B),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFF4F4F5),
      onPrimaryContainer: Color(0xFF18181B),
      secondary: Color(0xFF4F46E5),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFEEF2FF),
      onSecondaryContainer: Color(0xFF3730A3),
      tertiary: Color(0xFF0EA5E9),
      onTertiary: Color(0xFFFFFFFF),
      error: Color(0xFFEF4444),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF18181B),
      onSurfaceVariant: Color(0xFF71717A),
      outline: Color(0xFFE4E4E7),
      outlineVariant: Color(0xFFE4E4E7),
      shadow: Color(0x0A000000),
      scrim: Color(0x66000000),
      inverseSurface: Color(0xFF18181B),
      onInverseSurface: Color(0xFFFAFAFA),
      inversePrimary: Color(0xFFA5B4FC),
      surfaceTint: Colors.transparent,
    ),
    scaffoldBackground: const Color(0xFFFAFAFA),
    finViewColors: FinViewColors.light,
  );

  /// Dark theme with intentional surface layering, not inverted light colors.
  static final ThemeData dark = _buildTheme(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFAFAFA),
      onPrimary: Color(0xFF09090B),
      primaryContainer: Color(0xFF1F1F23),
      onPrimaryContainer: Color(0xFFFAFAFA),
      secondary: Color(0xFF818CF8),
      onSecondary: Color(0xFF09090B),
      secondaryContainer: Color(0xFF1E1B4B),
      onSecondaryContainer: Color(0xFFC7D2FE),
      tertiary: Color(0xFF38BDF8),
      onTertiary: Color(0xFF09090B),
      error: Color(0xFFF87171),
      onError: Color(0xFF450A0A),
      surface: Color(0xFF141416),
      onSurface: Color(0xFFFAFAFA),
      onSurfaceVariant: Color(0xFFA1A1AA),
      outline: Color(0xFF2E2E33),
      outlineVariant: Color(0xFF2E2E33),
      shadow: Color(0x66000000),
      scrim: Color(0x99000000),
      inverseSurface: Color(0xFFFAFAFA),
      onInverseSurface: Color(0xFF18181B),
      inversePrimary: Color(0xFF4F46E5),
      surfaceTint: Colors.transparent,
    ),
    scaffoldBackground: const Color(0xFF09090B),
    finViewColors: FinViewColors.dark,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required Color scaffoldBackground,
    required FinViewColors finViewColors,
  }) {
    final baseTextTheme = brightness == Brightness.light
        ? ThemeData.light().textTheme
        : ThemeData.dark().textTheme;
    final textTheme = _buildTextTheme(baseTextTheme, colorScheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      textTheme: textTheme,
      extensions: [finViewColors],
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: scaffoldBackground,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
          side: BorderSide(color: finViewColors.borderSubtle),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spaceMd,
          vertical: AppDesignTokens.spaceMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
          borderSide: BorderSide(color: finViewColors.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
          borderSide: BorderSide(color: finViewColors.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
          borderSide: BorderSide(color: colorScheme.secondary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.onSurface,
          foregroundColor: colorScheme.surface,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spaceLg,
            vertical: AppDesignTokens.spaceMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: AppDesignTokens.spaceSm),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDesignTokens.radiusSm),
            ),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: finViewColors.borderSubtle,
        thickness: AppDesignTokens.borderWidth,
        space: AppDesignTokens.borderWidth,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.secondary,
        linearTrackColor: finViewColors.borderSubtle,
      ),
    );
  }

  static TextTheme _buildTextTheme(
    TextTheme base,
    ColorScheme colorScheme,
  ) {
    final inter = GoogleFonts.interTextTheme(base);

    return inter.copyWith(
      displayLarge: AppDesignTokens.tabularFigures(
        inter.displayLarge!.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          letterSpacing: -1,
          height: 1.1,
          color: colorScheme.onSurface,
        ),
      ),
      headlineMedium: AppDesignTokens.tabularFigures(
        inter.headlineMedium!.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.75,
          height: 1.15,
          color: colorScheme.onSurface,
        ),
      ),
      titleLarge: inter.titleLarge!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        color: colorScheme.onSurface,
      ),
      titleMedium: inter.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleSmall: AppDesignTokens.tabularFigures(
        inter.titleSmall!.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      bodyLarge: inter.bodyLarge!.copyWith(
        color: colorScheme.onSurface,
      ),
      bodyMedium: inter.bodyMedium!.copyWith(
        color: colorScheme.onSurface,
      ),
      bodySmall: inter.bodySmall!.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      labelLarge: inter.labelLarge!.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      labelMedium: inter.labelMedium!.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
        color: colorScheme.onSurfaceVariant,
      ),
      labelSmall: inter.labelSmall!.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}
