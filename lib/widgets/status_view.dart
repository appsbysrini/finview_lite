import 'package:flutter/material.dart';

import '../utils/app_design_tokens.dart';
import 'finview_card.dart';

/// Shared layout for empty, loading, and error status screens.
class StatusView extends StatelessWidget {
  /// Creates a centered status message with an icon.
  const StatusView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.iconColor,
    this.action,
    this.embedded = false,
  });

  /// Icon shown above the title.
  final IconData icon;

  /// Primary status title.
  final String title;

  /// Supporting status message.
  final String message;

  /// Optional icon color override.
  final Color? iconColor;

  /// Optional action widget such as a retry button.
  final Widget? action;

  /// When true, renders inline content without an outer card shell.
  final bool embedded;

  /// Builds the centered status card or embedded content.
  @override
  Widget build(BuildContext context) {
    final content = _StatusContent(
      icon: icon,
      title: title,
      message: message,
      iconColor: iconColor,
      action: action,
    );

    if (embedded) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDesignTokens.spaceMd),
        child: content,
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spaceLg),
        child: FinViewCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spaceLg,
            vertical: AppDesignTokens.spaceXl,
          ),
          child: content,
        ),
      ),
    );
  }
}

/// Icon, title, message, and optional action for [StatusView].
class _StatusContent extends StatelessWidget {
  /// Creates the inner content for a status view.
  const _StatusContent({
    required this.icon,
    required this.title,
    required this.message,
    this.iconColor,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color? iconColor;
  final Widget? action;

  /// Builds the icon well, text, and optional action column.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finView = theme.finView;
    final resolvedIconColor = iconColor ?? finView.iconMuted;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: finView.surfaceMuted,
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
          ),
          child: Icon(
            icon,
            color: resolvedIconColor,
            size: 24,
            semanticLabel: title,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spaceMd),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDesignTokens.spaceSm),
        Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        if (action != null) ...[
          const SizedBox(height: AppDesignTokens.spaceLg),
          action!,
        ],
      ],
    );
  }
}
