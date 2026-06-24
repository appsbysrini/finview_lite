import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/portfolio_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FinViewLiteApp(),
    ),
  );
}

/// Root application widget for FinView Lite.
class FinViewLiteApp extends ConsumerWidget {
  /// Creates the app shell with Riverpod scope already applied upstream.
  const FinViewLiteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'FinView Lite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PortfolioBootstrapScreen(),
    );
  }
}

/// Temporary Phase 1 screen that verifies portfolio loading works.
class PortfolioBootstrapScreen extends ConsumerWidget {
  /// Creates a screen that surfaces portfolio [AsyncValue] states.
  const PortfolioBootstrapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioAsync = ref.watch(portfolioProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinView Lite'),
      ),
      body: portfolioAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Failed to load portfolio:\n$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (portfolio) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  portfolio.user,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text('Holdings loaded: ${portfolio.holdings.length}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
