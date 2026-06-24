import 'package:finview_lite/models/user_portfolio.dart';
import 'package:finview_lite/providers/allocation_provider.dart';
import 'package:finview_lite/providers/portfolio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';

void main() {
  group('allocationSlicesProvider', () {
    late ProviderContainer container;

    tearDown(() {
      container.dispose();
    });

    test('returns empty slices while portfolio is loading', () {
      // Arrange
      container = ProviderContainer();

      // Act
      final slices = container.read(allocationSlicesProvider);

      // Assert
      expect(slices, isEmpty);
    });

    test('derives slices from loaded portfolio holdings', () async {
      // Arrange
      container = ProviderContainer(
        overrides: [
          portfolioProvider.overrideWith(
            () => _FixedPortfolioNotifier(TestData.samplePortfolio),
          ),
        ],
      );
      await container.read(portfolioProvider.future);

      // Act
      final slices = container.read(allocationSlicesProvider);
      final hasData = container.read(allocationHasDataProvider);

      // Assert
      expect(slices, hasLength(2));
      expect(hasData, isTrue);
    });

    test('reports no data for empty portfolio holdings', () async {
      // Arrange
      container = ProviderContainer(
        overrides: [
          portfolioProvider.overrideWith(
            () => _FixedPortfolioNotifier(TestData.emptyPortfolio),
          ),
        ],
      );
      await container.read(portfolioProvider.future);

      // Act
      final hasData = container.read(allocationHasDataProvider);

      // Assert
      expect(container.read(allocationSlicesProvider), isEmpty);
      expect(hasData, isFalse);
    });
  });
}

class _FixedPortfolioNotifier extends PortfolioNotifier {
  _FixedPortfolioNotifier(this._portfolio);

  final UserPortfolio _portfolio;

  @override
  Future<UserPortfolio> build() async => _portfolio;
}
