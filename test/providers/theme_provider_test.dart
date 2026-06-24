import 'package:finview_lite/providers/theme_provider.dart';
import 'package:finview_lite/utils/prefs_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('themeModeProvider', () {
    late ProviderContainer container;

    tearDown(() {
      container.dispose();
    });

    test('loads light theme when preference is absent', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();

      // Act
      final mode = await container.read(themeModeProvider.future);

      // Assert
      expect(mode, ThemeMode.light);
    });

    test('loads dark theme when preference is true', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({PrefsKeys.isDarkMode: true});
      container = ProviderContainer();

      // Act
      final mode = await container.read(themeModeProvider.future);

      // Assert
      expect(mode, ThemeMode.dark);
    });

    test('toggle switches theme and persists preference', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
      await container.read(themeModeProvider.future);

      // Act
      await container.read(themeModeProvider.notifier).toggle();
      final prefs = await SharedPreferences.getInstance();

      // Assert
      expect(container.read(themeModeProvider).value, ThemeMode.dark);
      expect(prefs.getBool(PrefsKeys.isDarkMode), isTrue);
    });

    test('toggle from dark returns to light', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({PrefsKeys.isDarkMode: true});
      container = ProviderContainer();
      await container.read(themeModeProvider.future);

      // Act
      await container.read(themeModeProvider.notifier).toggle();
      final prefs = await SharedPreferences.getInstance();

      // Assert
      expect(container.read(themeModeProvider).value, ThemeMode.light);
      expect(prefs.getBool(PrefsKeys.isDarkMode), isFalse);
    });
  });

  group('isDarkModeProvider', () {
    test('returns false while theme is loading', () {
      // Arrange
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Act
      final isDark = container.read(isDarkModeProvider);

      // Assert
      expect(isDark, isFalse);
    });

    test('returns true when dark theme is active', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({PrefsKeys.isDarkMode: true});
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(themeModeProvider.future);

      // Act
      final isDark = container.read(isDarkModeProvider);

      // Assert
      expect(isDark, isTrue);
    });
  });
}
