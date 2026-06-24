import 'package:flutter/material.dart';

import '../utils/app_design_tokens.dart';

/// Branded dashboard header with theme and sign-out actions.
class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  /// Creates the dashboard app bar.
  const DashboardHeader({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onSignOut,
    this.isRefreshing = false,
  });

  /// Whether dark mode is currently active.
  final bool isDarkMode;

  /// Called when the theme toggle is pressed.
  final VoidCallback onToggleTheme;

  /// Called when sign out is pressed.
  final VoidCallback onSignOut;

  /// Whether a portfolio refresh is in progress.
  final bool isRefreshing;

  /// Returns the fixed height required by [PreferredSizeWidget].
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// Builds the branded app bar with theme and sign-out actions.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finView = theme.finView;

    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: finView.brand,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.show_chart_rounded,
              size: 14,
              color: theme.colorScheme.surface,
            ),
          ),
          const SizedBox(width: AppDesignTokens.spaceSm),
          Text(
            'FinView',
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
      actions: [
        if (isRefreshing)
          const Padding(
            padding: EdgeInsets.only(right: AppDesignTokens.spaceSm),
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        IconButton(
          tooltip: isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
          onPressed: onToggleTheme,
          icon: Icon(
            isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          ),
        ),
        IconButton(
          tooltip: 'Sign out',
          onPressed: onSignOut,
          icon: const Icon(Icons.logout_rounded),
        ),
      ],
    );
  }
}
