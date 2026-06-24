import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/return_toggle_provider.dart';
import '../utils/app_design_tokens.dart';

/// Segmented control for switching between ₹ and % return display.
class ReturnToggle extends ConsumerWidget {
  /// Creates a toggle bound to [returnToggleProvider].
  const ReturnToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayMode = ref.watch(returnToggleProvider);
    final theme = Theme.of(context);
    final finView = theme.finView;

    return SegmentedButton<ReturnDisplayMode>(
      style: SegmentedButton.styleFrom(
        backgroundColor: theme.colorScheme.surface,
        selectedBackgroundColor: finView.surfaceMuted,
        foregroundColor: theme.colorScheme.onSurfaceVariant,
        selectedForegroundColor: theme.colorScheme.onSurface,
        side: BorderSide(color: finView.borderSubtle),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spaceMd,
          vertical: AppDesignTokens.spaceXs,
        ),
      ),
      segments: const [
        ButtonSegment(
          value: ReturnDisplayMode.amount,
          label: Text('₹'),
        ),
        ButtonSegment(
          value: ReturnDisplayMode.percent,
          label: Text('%'),
        ),
      ],
      selected: {displayMode},
      onSelectionChanged: (selection) {
        ref.read(returnToggleProvider.notifier).state = selection.first;
      },
    );
  }
}
