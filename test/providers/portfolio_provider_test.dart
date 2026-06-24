import 'package:finview_lite/models/user_portfolio.dart';
import 'package:finview_lite/providers/portfolio_provider.dart';
import 'package:finview_lite/providers/portfolio_refresh_provider.dart';
import 'package:finview_lite/utils/prefs_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('portfolioProvider', () {
    late ProviderContainer container;

    tearDown(() {
      container.dispose();
    });

    test('loads portfolio from bundled asset', () async {
      // Arrange
      container = ProviderContainer();

      // Act
      final portfolio = await container.read(portfolioProvider.future);

      // Assert
      expect(portfolio.user, 'Aarav Patel');
      expect(portfolio.portfolioValue, 109640);
      expect(portfolio.totalGain, 5800);
      expect(portfolio.holdings, isNotEmpty);
    });

    test('refresh updates portfolio values after simulated delay', () async {
      // Arrange
      container = ProviderContainer(
        overrides: [
          portfolioProvider.overrideWith(
            () => _FixedPortfolioNotifier(TestData.samplePortfolio),
          ),
        ],
      );
      await container.read(portfolioProvider.future);
      final before = container.read(portfolioProvider).value!;

      // Act
      final refreshFuture =
          container.read(portfolioProvider.notifier).refresh();
      await refreshFuture;
      await Future<void>.delayed(RefreshConstants.simulatedDelay);

      // Assert
      final after = container.read(portfolioProvider).value!;
      expect(after.user, before.user);
      expect(after.holdings, hasLength(before.holdings.length));
      expect(container.read(portfolioRefreshingProvider), isFalse);
    });

    test('reports error when initial load fails', () async {
      // Arrange
      container = ProviderContainer(
        overrides: [
          portfolioProvider.overrideWith(_ErrorPortfolioNotifier.new),
        ],
      );
      final subscription = container.listen(portfolioProvider, (_, _) {});

      // Act
      await Future<void>.delayed(Duration.zero);

      // Assert
      final state = container.read(portfolioProvider);
      expect(state.hasError, isTrue);
      expect(state.error, isA<FormatException>());

      subscription.close();
    });

    test('refresh reloads portfolio when current state has no data', () async {
      // Arrange
      container = ProviderContainer(
        overrides: [
          portfolioProvider.overrideWith(_ErrorPortfolioNotifier.new),
        ],
      );
      final subscription = container.listen(portfolioProvider, (_, _) {});
      await Future<void>.delayed(Duration.zero);
      expect(container.read(portfolioProvider).hasError, isTrue);

      // Act
      await container.read(portfolioProvider.notifier).refresh();

      // Assert
      final portfolio = container.read(portfolioProvider).value;
      expect(portfolio, isNotNull);
      expect(portfolio!.user, 'Aarav Patel');

      subscription.close();
    });

    test('refresh sets refreshing flag during simulation', () async {
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
      final refreshFuture =
          container.read(portfolioProvider.notifier).refresh();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      // Assert
      expect(container.read(portfolioRefreshingProvider), isTrue);

      await refreshFuture;
      await Future<void>.delayed(RefreshConstants.simulatedDelay);
      expect(container.read(portfolioRefreshingProvider), isFalse);
    });
  });
}

class _FixedPortfolioNotifier extends PortfolioNotifier {
  _FixedPortfolioNotifier(this._portfolio);

  final UserPortfolio _portfolio;

  @override
  Future<UserPortfolio> build() async => _portfolio;
}

class _ErrorPortfolioNotifier extends PortfolioNotifier {
  @override
  Future<UserPortfolio> build() async {
    throw const FormatException('Unable to load portfolio');
  }
}
