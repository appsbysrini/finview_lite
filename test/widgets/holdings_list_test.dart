import 'package:finview_lite/providers/return_toggle_provider.dart';
import 'package:finview_lite/providers/sort_provider.dart';
import 'package:finview_lite/widgets/empty_state.dart';
import 'package:finview_lite/widgets/holdings_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';
import '../helpers/widget_test_helpers.dart';

void main() {
  group('HoldingsList', () {
    testWidgets('renders holding cards for non-empty holdings', (tester) async {
      // Arrange
      const holdings = [TestData.tcs, TestData.infy];

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: holdings),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Holdings'), findsOneWidget);
      expect(find.text('TCS'), findsOneWidget);
      expect(find.text('INFY'), findsOneWidget);
      expect(find.text('Tata Consultancy'), findsOneWidget);
      expect(find.text('Infosys Ltd'), findsOneWidget);
    });

    testWidgets('shows empty state when holdings list is empty', (tester) async {
      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: []),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(EmptyStateWidget), findsOneWidget);
      expect(find.text('No holdings yet'), findsOneWidget);
    });

    testWidgets('sorts holdings by selected sort provider', (tester) async {
      // Arrange
      const holdings = [TestData.infy, TestData.tcs];

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: holdings),
        overrides: [
          sortProvider.overrideWith((ref) => HoldingSort.byName),
        ],
      );
      await tester.pumpAndSettle();

      // Assert
      final symbols = tester
          .widgetList<Text>(find.text('TCS'))
          .followedBy(tester.widgetList<Text>(find.text('INFY')));
      expect(symbols, isNotEmpty);
      expect(find.text('Infosys Ltd'), findsOneWidget);
      expect(find.text('Tata Consultancy'), findsOneWidget);
    });

    testWidgets('reflects return toggle percent mode in cards', (tester) async {
      // Arrange
      const holdings = [TestData.tcs];

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: holdings),
        overrides: [
          returnToggleProvider.overrideWith(
            (ref) => ReturnDisplayMode.percent,
          ),
        ],
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('+6.3%'), findsOneWidget);
    });

    testWidgets('stacks controls on narrow layouts', (tester) async {
      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: [TestData.tcs]),
        viewportSize: const Size(320, 800),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Holdings'), findsOneWidget);
      expect(find.text('₹'), findsOneWidget);
    });

    testWidgets('updates card return display when toggle is tapped', (
      tester,
    ) async {
      // Arrange
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: [TestData.tcs]),
      );
      await tester.pumpAndSettle();
      expect(find.text('+₹1,000'), findsOneWidget);

      // Act
      await tester.tap(find.text('%'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('+6.3%'), findsOneWidget);
    });

    testWidgets('re-sorts holdings when sort controls change', (tester) async {
      // Arrange
      const holdings = [TestData.infy, TestData.tcs];
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: holdings),
      );
      await tester.pumpAndSettle();

      // Act
      await tester.tap(find.text('Name'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Infosys Ltd'), findsOneWidget);
      expect(find.text('Tata Consultancy'), findsOneWidget);
    });
  });
}
