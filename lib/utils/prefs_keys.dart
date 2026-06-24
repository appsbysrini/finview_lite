/// SharedPreferences keys used across the app.
abstract final class PrefsKeys {
  /// Whether the user completed mock login.
  static const isLoggedIn = 'is_logged_in';

  /// Whether dark theme is enabled.
  static const isDarkMode = 'is_dark_mode';
}

/// Mock login credentials for the bonus login flow.
abstract final class AuthConstants {
  /// Valid mock username.
  static const username = 'srini';

  /// Valid mock PIN.
  static const pin = '8898';
}

/// Timing constants for portfolio refresh simulation.
abstract final class RefreshConstants {
  /// Simulated network delay before prices update.
  static const simulatedDelay = Duration(milliseconds: 800);

  /// Maximum absolute price change per refresh as a decimal ratio.
  static const maxPriceDelta = 0.03;
}
