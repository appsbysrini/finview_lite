import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../utils/layout_constants.dart';
import '../utils/prefs_keys.dart';

/// Horizontal padding around the login form.
const _formPadding = 24.0;

/// Vertical spacing between form fields.
const _fieldSpacing = 16.0;

/// Validation or credential error shown on the login form.
final loginErrorProvider = StateProvider<String?>(
  (ref) => null,
);

/// Whether a login attempt is currently in progress.
final loginSubmittingProvider = StateProvider<bool>(
  (ref) => false,
);

/// Mock login screen with persisted session support.
class LoginScreen extends ConsumerStatefulWidget {
  /// Creates the login screen.
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  /// Validates credentials and persists the login session on success.
  Future<void> _submitLogin() async {
    final isSubmitting = ref.read(loginSubmittingProvider);
    if (isSubmitting) {
      return;
    }

    ref.read(loginErrorProvider.notifier).state = null;

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ref.read(loginSubmittingProvider.notifier).state = true;

    final success = await ref.read(authProvider.notifier).login(
          username: _usernameController.text,
          pin: _pinController.text,
        );

    ref.read(loginSubmittingProvider.notifier).state = false;

    if (!success) {
      ref.read(loginErrorProvider.notifier).state =
          'Invalid username or PIN.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorMessage = ref.watch(loginErrorProvider);
    final isSubmitting = ref.watch(loginSubmittingProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(_formPadding),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: LayoutConstants.tabletBreakpoint,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'FinView Lite',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _fieldSpacing / 2),
                    Text(
                      'Sign in to view your portfolio',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _fieldSpacing * 2),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      enabled: !isSubmitting,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: _fieldSpacing),
                    TextFormField(
                      controller: _pinController,
                      decoration: const InputDecoration(
                        labelText: 'PIN',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      enabled: !isSubmitting,
                      onFieldSubmitted: (_) => _submitLogin(),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your PIN';
                        }
                        return null;
                      },
                    ),
                    if (errorMessage != null) ...[
                      const SizedBox(height: _fieldSpacing),
                      Text(
                        errorMessage,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: _fieldSpacing * 1.5),
                    FilledButton(
                      onPressed: isSubmitting ? null : _submitLogin,
                      child: isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Sign In'),
                    ),
                    const SizedBox(height: _fieldSpacing),
                    Text(
                      'Demo credentials: ${AuthConstants.username} / ${AuthConstants.pin}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
