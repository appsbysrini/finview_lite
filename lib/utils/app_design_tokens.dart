import 'package:flutter/material.dart';

/// Centralized spacing, radii, and semantic color tokens for FinView Lite.
abstract final class AppDesignTokens {
  /// Extra-small spacing (4 logical pixels).
  static const spaceXs = 4.0;

  /// Small spacing (8 logical pixels).
  static const spaceSm = 8.0;

  /// Medium spacing (16 logical pixels).
  static const spaceMd = 16.0;

  /// Large spacing (24 logical pixels).
  static const spaceLg = 24.0;

  /// Extra-large spacing (32 logical pixels).
  static const spaceXl = 32.0;

  /// Section gap between major dashboard blocks.
  static const spaceSection = 24.0;

  /// Small corner radius for compact elements.
  static const radiusSm = 8.0;

  /// Medium corner radius for cards and inputs.
  static const radiusMd = 12.0;

  /// Large corner radius for section cards.
  static const radiusLg = 16.0;

  /// Fully rounded pill shape.
  static const radiusPill = 100.0;

  /// Hairline border width for cards and dividers.
  static const borderWidth = 1.0;

  /// Applies tabular figures for aligned financial numerals.
  static TextStyle tabularFigures(TextStyle style) {
    return style.copyWith(
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}

/// FinView-specific semantic colors exposed through [ThemeData.extensions].
class FinViewColors extends ThemeExtension<FinViewColors> {
  /// Creates semantic fintech colors for the active brightness.
  const FinViewColors({
    required this.profit,
    required this.onProfit,
    required this.profitContainer,
    required this.loss,
    required this.onLoss,
    required this.lossContainer,
    required this.chartPalette,
    required this.brand,
    required this.surfaceMuted,
    required this.iconMuted,
    required this.borderSubtle,
  });

  /// Emerald tone for gains and positive movement.
  final Color profit;

  /// Text and icons placed on [profit] surfaces.
  final Color onProfit;

  /// Subtle background for positive gain pills.
  final Color profitContainer;

  /// Soft red tone for losses.
  final Color loss;

  /// Text and icons placed on [loss] surfaces.
  final Color onLoss;

  /// Subtle background for negative gain pills.
  final Color lossContainer;

  /// Ordered palette for allocation chart slices.
  final List<Color> chartPalette;

  /// Brand accent used for logos and key highlights.
  final Color brand;

  /// Muted surface for avatars, icon wells, and stat tiles.
  final Color surfaceMuted;

  /// Muted icon color for empty and status states.
  final Color iconMuted;

  /// Subtle divider and card border color.
  final Color borderSubtle;

  /// Light-mode semantic palette.
  static const light = FinViewColors(
    profit: Color(0xFF10B981),
    onProfit: Color(0xFF047857),
    profitContainer: Color(0xFFECFDF5),
    loss: Color(0xFFEF4444),
    onLoss: Color(0xFFB91C1C),
    lossContainer: Color(0xFFFEF2F2),
    chartPalette: [
      Color(0xFF4F46E5),
      Color(0xFF0EA5E9),
      Color(0xFF8B5CF6),
      Color(0xFF14B8A6),
      Color(0xFF6366F1),
      Color(0xFF06B6D4),
    ],
    brand: Color(0xFF4F46E5),
    surfaceMuted: Color(0xFFF4F4F5),
    iconMuted: Color(0xFFA1A1AA),
    borderSubtle: Color(0xFFE4E4E7),
  );

  /// Dark-mode semantic palette tuned for startup fintech dashboards.
  static const dark = FinViewColors(
    profit: Color(0xFF34D399),
    onProfit: Color(0xFF064E3B),
    profitContainer: Color(0xFF142F28),
    loss: Color(0xFFF87171),
    onLoss: Color(0xFF450A0A),
    lossContainer: Color(0xFF2D1515),
    chartPalette: [
      Color(0xFF818CF8),
      Color(0xFF38BDF8),
      Color(0xFFA78BFA),
      Color(0xFF2DD4BF),
      Color(0xFF6366F1),
      Color(0xFF22D3EE),
    ],
    brand: Color(0xFF818CF8),
    surfaceMuted: Color(0xFF1F1F23),
    iconMuted: Color(0xFF71717A),
    borderSubtle: Color(0xFF2E2E33),
  );

  /// Returns a copy with selectively replaced color fields.
  @override
  FinViewColors copyWith({
    Color? profit,
    Color? onProfit,
    Color? profitContainer,
    Color? loss,
    Color? onLoss,
    Color? lossContainer,
    List<Color>? chartPalette,
    Color? brand,
    Color? surfaceMuted,
    Color? iconMuted,
    Color? borderSubtle,
  }) {
    return FinViewColors(
      profit: profit ?? this.profit,
      onProfit: onProfit ?? this.onProfit,
      profitContainer: profitContainer ?? this.profitContainer,
      loss: loss ?? this.loss,
      onLoss: onLoss ?? this.onLoss,
      lossContainer: lossContainer ?? this.lossContainer,
      chartPalette: chartPalette ?? this.chartPalette,
      brand: brand ?? this.brand,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      iconMuted: iconMuted ?? this.iconMuted,
      borderSubtle: borderSubtle ?? this.borderSubtle,
    );
  }

  /// Linearly interpolates between this palette and [other].
  @override
  FinViewColors lerp(ThemeExtension<FinViewColors>? other, double t) {
    if (other is! FinViewColors) {
      return this;
    }

    return FinViewColors(
      profit: Color.lerp(profit, other.profit, t)!,
      onProfit: Color.lerp(onProfit, other.onProfit, t)!,
      profitContainer: Color.lerp(profitContainer, other.profitContainer, t)!,
      loss: Color.lerp(loss, other.loss, t)!,
      onLoss: Color.lerp(onLoss, other.onLoss, t)!,
      lossContainer: Color.lerp(lossContainer, other.lossContainer, t)!,
      chartPalette: List<Color>.generate(
        chartPalette.length,
        (index) => Color.lerp(
          chartPalette[index],
          other.chartPalette[index],
          t,
        )!,
      ),
      brand: Color.lerp(brand, other.brand, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
    );
  }
}

/// Convenience accessors for FinView theme extensions.
extension FinViewThemeX on ThemeData {
  /// Returns the FinView semantic color extension for this theme.
  FinViewColors get finView => extension<FinViewColors>()!;
}

/// Convenience accessors for FinView theme extensions from [BuildContext].
extension FinViewContextX on BuildContext {
  /// Returns the FinView semantic color extension for the active theme.
  FinViewColors get finViewColors => Theme.of(this).finView;
}
