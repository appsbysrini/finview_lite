import 'package:flutter/material.dart';

import '../utils/app_design_tokens.dart';

/// Minimal section title with an optional trailing control.
class SectionHeader extends StatelessWidget {
  /// Creates a section header with [title] and optional [trailing] widget.
  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
  });

  /// Section title text.
  final String title;

  /// Optional trailing widget such as a toggle.
  final Widget? trailing;

  /// Builds the title row with optional trailing control.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge,
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: AppDesignTokens.spaceSm),
          trailing!,
        ],
      ],
    );
  }
}
