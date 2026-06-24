import 'package:flutter/material.dart';

import '../utils/app_design_tokens.dart';

/// Square avatar displaying a holding ticker symbol with a hashed accent color.
///
/// The background and text color are derived deterministically from the ticker
/// symbol using a hash against the active theme's [FinViewColors.chartPalette].
/// This ensures each symbol always renders the same color while visually
/// matching the allocation pie chart slices.
class TickerAvatar extends StatelessWidget {
  /// Creates a ticker avatar for [symbol].
  const TickerAvatar({
    super.key,
    required this.symbol,
    this.size = 36,
  });

  /// Ticker symbol shown inside the avatar.
  final String symbol;

  /// Diameter of the avatar in logical pixels.
  final double size;

  /// Builds the ticker initials avatar for [symbol] with a hashed accent color.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.finView.chartPalette;
    final accentColor = _colorForSymbol(symbol, palette);
    final initials = _initialsFor(symbol);

    return Semantics(
      label: '$symbol ticker',
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // 15% opacity tint of the accent gives a readable, low-contrast bg.
          color: accentColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusSm),
        ),
        child: Text(
          initials,
          style: theme.textTheme.labelMedium?.copyWith(
            color: accentColor,
            fontWeight: FontWeight.w700,
            fontSize: size * 0.3,
          ),
        ),
      ),
    );
  }

  /// Returns a deterministic color from [palette] based on [symbol]'s char sum.
  ///
  /// Summing code-unit values is fast, collision-resistant enough for a small
  /// palette, and stable across runs — same symbol always maps to the same slot.
  static Color _colorForSymbol(String symbol, List<Color> palette) {
    if (palette.isEmpty) {
      return const Color(0xFF6366F1);
    }
    final hash = symbol.codeUnits.fold(0, (sum, unit) => sum + unit);
    return palette[hash % palette.length];
  }

  /// Returns one or two uppercase characters derived from [symbol].
  String _initialsFor(String symbol) {
    final trimmed = symbol.trim().toUpperCase();
    if (trimmed.isEmpty) {
      return '?';
    }
    if (trimmed.length == 1) {
      return trimmed;
    }
    return trimmed.substring(0, 2);
  }
}
