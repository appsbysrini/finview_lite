import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/dashboard_screen.dart';
import '../screens/login_screen.dart';
import '../utils/app_themes.dart';

/// Bootstraps theme, auth, and routes to login or dashboard.
class AppShell extends ConsumerWidget {
  /// Creates the root app shell.
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeModeProvider);
    final authAsync = ref.watch(authProvider);

    return themeAsync.when(
      loading: () => _buildBootstrapApp(
        home: const _BootstrapLoadingScreen(),
      ),
      error: (error, stackTrace) => _buildBootstrapApp(
        home: _BootstrapErrorScreen(message: error.toString()),
      ),
      data: (themeMode) {
        return authAsync.when(
          loading: () => _buildThemedApp(
            themeMode: themeMode,
            home: const _BootstrapLoadingScreen(),
          ),
          error: (error, stackTrace) => _buildThemedApp(
            themeMode: themeMode,
            home: _BootstrapErrorScreen(message: error.toString()),
          ),
          data: (isLoggedIn) => _buildThemedApp(
            themeMode: themeMode,
            home: isLoggedIn
                ? const DashboardScreen()
                : const LoginScreen(),
          ),
        );
      },
    );
  }

  Widget _buildBootstrapApp({required Widget home}) {
    return MaterialApp(
      title: 'FinView Lite',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      home: home,
    );
  }

  Widget _buildThemedApp({
    required ThemeMode themeMode,
    required Widget home,
  }) {
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
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _BootstrapErrorScreen extends StatelessWidget {
  const _BootstrapErrorScreen({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Unable to start app:\n$message',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
