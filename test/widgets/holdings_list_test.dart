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
          sortProvider.overrideWith(_SortByNameNotifier.new),
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
          returnToggleProvider.overrideWith(_PercentReturnToggleNotifier.new),
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

    testWidgets('re-sorts holdings when sort menu option is selected', (
      tester,
    ) async {
      // Arrange
      const holdings = [TestData.infy, TestData.tcs];
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: holdings),
      );
      await tester.pumpAndSettle();

      // Act
      await _selectSort(tester, 'Name');

      // Assert
      expect(
        _visibleSymbolOrder(tester, const ['INFY', 'TCS']),
        ['INFY', 'TCS'],
      );
    });

    testWidgets('switches from one sort option to another via menu', (
      tester,
    ) async {
      // Arrange
      const holdings = [TestData.lossHolding, TestData.infy, TestData.tcs];
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: holdings),
      );
      await tester.pumpAndSettle();
      await _selectSort(tester, 'Gains');

      // Act
      await _selectSort(tester, 'Value');

      // Assert
      expect(
        _visibleSymbolOrder(tester, const ['TCS', 'INFY', 'LOSS']),
        ['TCS', 'INFY', 'LOSS'],
      );
    });

    testWidgets('sorts holdings by sort provider override', (
      tester,
    ) async {
      // Arrange
      const holdings = [TestData.lossHolding, TestData.infy, TestData.tcs];

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingsList(holdings: holdings),
        overrides: [
          sortProvider.overrideWith(_SortByGainNotifier.new),
        ],
      );
      await tester.pumpAndSettle();

      // Assert
      expect(
        _visibleSymbolOrder(tester, const ['INFY', 'TCS', 'LOSS']),
        ['INFY', 'TCS', 'LOSS'],
      );
    });
  });
}

Future<void> _selectSort(WidgetTester tester, String label) async {
  await tester.tap(find.byIcon(Icons.sort_rounded));
  await tester.pumpAndSettle();
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

List<String> _visibleSymbolOrder(WidgetTester tester, List<String> symbols) {
  final positionedSymbols = symbols
      .where((symbol) => find.text(symbol).evaluate().isNotEmpty)
      .map(
        (symbol) => (
          symbol,
          tester.getTopLeft(find.text(symbol)).dy,
        ),
      )
      .toList()
    ..sort((a, b) => a.$2.compareTo(b.$2));

  return positionedSymbols.map((entry) => entry.$1).toList();
}

/// Test override that starts with name-based sorting.
class _SortByNameNotifier extends SortNotifier {
  @override
  HoldingSort build() => HoldingSort.byName;
}

/// Test override that starts with gain-based sorting.
class _SortByGainNotifier extends SortNotifier {
  @override
  HoldingSort build() => HoldingSort.byGain;
}

/// Test override that starts in percent return display mode.
class _PercentReturnToggleNotifier extends ReturnToggleNotifier {
  @override
  ReturnDisplayMode build() => ReturnDisplayMode.percent;
}
