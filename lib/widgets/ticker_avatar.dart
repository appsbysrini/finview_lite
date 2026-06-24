import 'package:flutter/material.dart';

import '../utils/app_design_tokens.dart';

/// Square avatar displaying a holding ticker symbol.
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finView = theme.finView;
    final initials = _initialsFor(symbol);

    return Semantics(
      label: '$symbol ticker',
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: finView.surfaceMuted,
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusSm),
        ),
        child: Text(
          initials,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
            fontSize: size * 0.3,
          ),
        ),
      ),
    );
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
