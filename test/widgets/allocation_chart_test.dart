import 'package:finview_lite/models/holding.dart';
import 'package:finview_lite/models/user_portfolio.dart';
import 'package:finview_lite/widgets/allocation_chart.dart';
import 'package:finview_lite/widgets/chart_no_data_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';
import '../helpers/widget_test_helpers.dart';

void main() {
  group('AllocationChart', () {
    testWidgets('renders allocation title and chart for valued holdings',
        (tester) async {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const AllocationChart(),
        overrides: [portfolioOverride(portfolio)],
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Allocation'), findsOneWidget);
      expect(find.text('TCS'), findsWidgets);
      expect(find.text('INFY'), findsWidgets);
      expect(find.byType(ChartNoDataPlaceholder), findsNothing);
    });

    testWidgets('shows no data placeholder when holdings are empty',
        (tester) async {
      // Arrange
      const portfolio = TestData.emptyPortfolio;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const AllocationChart(),
        overrides: [portfolioOverride(portfolio)],
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Allocation'), findsOneWidget);
      expect(find.byType(ChartNoDataPlaceholder), findsOneWidget);
      expect(find.text('No data'), findsOneWidget);
    });

    testWidgets('shows no data placeholder when all holdings are zero value',
        (tester) async {
      // Arrange
      const zeroValueHolding = Holding(
        symbol: 'ZERO',
        name: 'Zero Value',
        units: 5,
        avgCost: 100,
        currentPrice: 0,
      );
      const portfolio = UserPortfolio(
        user: 'Zero User',
        portfolioValue: 0,
        totalGain: 0,
        holdings: [zeroValueHolding],
      );

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const AllocationChart(),
        overrides: [portfolioOverride(portfolio)],
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ChartNoDataPlaceholder), findsOneWidget);
    });

    testWidgets('uses side-by-side layout on wide screens', (tester) async {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const AllocationChart(),
        overrides: [portfolioOverride(portfolio)],
        viewportSize: const Size(900, 800),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Allocation'), findsOneWidget);
      expect(find.text('TCS'), findsWidgets);
      expect(find.text('INFY'), findsWidgets);
    });
  });
}
