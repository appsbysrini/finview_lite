import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/prefs_keys.dart';

/// Manages mock login state with SharedPreferences persistence.
class AuthNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    return _readLoginState();
  }

  /// Attempts mock login and persists the session when credentials match.
  Future<bool> login({
    required String username,
    required String pin,
  }) async {
    final isValid = username.trim() == AuthConstants.username &&
        pin.trim() == AuthConstants.pin;

    if (!isValid) {
      return false;
    }

    await _saveLoginState(isLoggedIn: true);
    state = const AsyncData(true);
    return true;
  }

  /// Clears the persisted login session.
  Future<void> logout() async {
    await _saveLoginState(isLoggedIn: false);
    state = const AsyncData(false);
  }

  Future<bool> _readLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefsKeys.isLoggedIn) ?? false;
  }

  Future<void> _saveLoginState({required bool isLoggedIn}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.isLoggedIn, isLoggedIn);
  }
}

/// Provider exposing whether the user is logged in.
final authProvider = AsyncNotifierProvider<AuthNotifier, bool>(
  AuthNotifier.new,
);
