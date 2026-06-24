import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/prefs_keys.dart';

/// Loads and persists the active Material [ThemeMode].
class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  /// Loads the persisted theme mode when the provider is first watched.
  @override
  Future<ThemeMode> build() async {
    return _readThemeMode();
  }

  /// Toggles between light and dark themes and persists the choice.
  Future<void> toggle() async {
    final current = state.requireValue;
    final next =
        current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _saveThemeMode(next);
    state = AsyncData(next);
  }

  /// Returns the saved theme mode from SharedPreferences.
  Future<ThemeMode> _readThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(PrefsKeys.isDarkMode) ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  /// Persists [mode] to SharedPreferences.
  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.isDarkMode, mode == ThemeMode.dark);
  }
}

/// Provider for the persisted app theme mode.
final themeModeProvider =
    AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// Whether dark mode is currently active.
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  return themeMode.maybeWhen(
    data: (mode) => mode == ThemeMode.dark,
    orElse: () => false,
  );
});
