import 'package:finview_lite/widgets/portfolio_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';
import '../helpers/widget_test_helpers.dart';

void main() {
  group('PortfolioHeader', () {
    testWidgets('displays user name and formatted portfolio value', (
      tester,
    ) async {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const PortfolioHeader(portfolio: portfolio),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Portfolio'), findsOneWidget);
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('₹100,000'), findsOneWidget);
      expect(find.text('Total return'), findsOneWidget);
    });

    testWidgets('shows positive gain with trending up icon', (tester) async {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const PortfolioHeader(portfolio: portfolio),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.textContaining('+₹5,000'), findsOneWidget);
      expect(find.byIcon(Icons.trending_up), findsOneWidget);
    });

    testWidgets('shows negative gain with trending down icon', (tester) async {
      // Arrange
      const portfolio = TestData.lossPortfolio;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const PortfolioHeader(portfolio: portfolio),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.textContaining('-₹400'), findsOneWidget);
      expect(find.byIcon(Icons.trending_down), findsOneWidget);
    });

    testWidgets('exposes portfolio summary semantics label', (tester) async {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const PortfolioHeader(portfolio: portfolio),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.bySemanticsLabel('Portfolio summary for Test User'),
        findsOneWidget,
      );
    });

    testWidgets('shows neutral gain formatting for zero total gain', (
      tester,
    ) async {
      // Arrange
      const portfolio = TestData.emptyPortfolio;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const PortfolioHeader(portfolio: portfolio),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('₹0'), findsOneWidget);
      expect(find.textContaining('0.0%'), findsOneWidget);
    });
  });
}
