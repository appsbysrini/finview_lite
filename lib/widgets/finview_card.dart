import 'package:flutter/material.dart';

import '../utils/app_design_tokens.dart';

/// Reusable bordered card surface with consistent fintech styling.
class FinViewCard extends StatelessWidget {
  /// Creates a styled card wrapping [child].
  const FinViewCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius = AppDesignTokens.radiusLg,
  });

  /// Card content.
  final Widget child;

  /// Inner padding; defaults to medium spacing on all sides.
  final EdgeInsetsGeometry? padding;

  /// Optional outer margin.
  final EdgeInsetsGeometry? margin;

  /// Optional border color override.
  final Color? borderColor;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Corner radius applied to the card.
  final double borderRadius;

  /// Builds the bordered card surface wrapping [child].
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finView = theme.finView;
    final resolvedPadding =
        padding ?? const EdgeInsets.all(AppDesignTokens.spaceMd);
    final resolvedBackground =
        backgroundColor ?? theme.colorScheme.surface;
    final resolvedBorder = borderColor ?? finView.borderSubtle;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: resolvedBackground,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: resolvedBorder,
          width: AppDesignTokens.borderWidth,
        ),
      ),
      child: Padding(
        padding: resolvedPadding,
        child: child,
      ),
    );
  }
}
