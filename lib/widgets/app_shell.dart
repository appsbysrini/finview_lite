import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/dashboard_screen.dart';
import '../screens/login_screen.dart';
import '../utils/app_themes.dart';
import '../widgets/app_loading_indicator.dart';
import '../widgets/portfolio_error_view.dart';

/// Bootstraps theme, auth, and routes to login or dashboard.
class AppShell extends ConsumerWidget {
  /// Creates the root app shell.
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeModeProvider);
    final authAsync = ref.watch(authProvider);

    return themeAsync.when(
      loading: () => _FinViewMaterialApp(
        home: const _BootstrapLoadingScreen(),
      ),
      error: (error, stackTrace) => _FinViewMaterialApp(
        home: PortfolioErrorView(
          title: 'Unable to start app',
          message: error.toString(),
        ),
      ),
      data: (themeMode) {
        return authAsync.when(
          loading: () => _FinViewMaterialApp(
            themeMode: themeMode,
            home: const _BootstrapLoadingScreen(),
          ),
          error: (error, stackTrace) => _FinViewMaterialApp(
            themeMode: themeMode,
            home: PortfolioErrorView(
              title: 'Unable to start app',
              message: error.toString(),
            ),
          ),
          data: (isLoggedIn) => _FinViewMaterialApp(
            themeMode: themeMode,
            home: isLoggedIn
                ? const DashboardScreen()
                : const LoginScreen(),
          ),
        );
      },
    );
  }
}

class _FinViewMaterialApp extends StatelessWidget {
  const _FinViewMaterialApp({
    required this.home,
    this.themeMode,
  });

  final Widget home;
  final ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinView Lite',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themeMode,
      home: home,
    );
  }
}

class _BootstrapLoadingScreen extends StatelessWidget {
  const _BootstrapLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLoadingIndicator(),
      ),
    );
  }
}
