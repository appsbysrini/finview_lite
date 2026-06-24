import 'package:finview_lite/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/widget_test_helpers.dart';

void main() {
  group('EmptyStateWidget', () {
    testWidgets('displays title and subtitle message', (tester) async {
      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const EmptyStateWidget(),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No holdings yet'), findsOneWidget);
      expect(
        find.text('Add investments to see them listed here.'),
        findsOneWidget,
      );
    });

    testWidgets('shows pie chart outline icon', (tester) async {
      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const EmptyStateWidget(),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byIcon(Icons.pie_chart_outline_rounded), findsOneWidget);
    });

    testWidgets('exposes no holdings semantics label', (tester) async {
      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const EmptyStateWidget(),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.bySemanticsLabel('No holdings yet'), findsWidgets);
    });
  });
}
