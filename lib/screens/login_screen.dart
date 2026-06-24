import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/login_provider.dart';
import '../utils/app_design_tokens.dart';
import '../utils/layout_constants.dart';
import '../utils/prefs_keys.dart';
import '../widgets/app_loading_indicator.dart';
import '../widgets/finview_card.dart';

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
    final finView = theme.finView;
    final errorMessage = ref.watch(loginErrorProvider);
    final isSubmitting = ref.watch(loginSubmittingProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDesignTokens.spaceLg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: LayoutConstants.tabletBreakpoint,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppDesignTokens.spaceXl),
                  _LoginBrandHeader(finView: finView, theme: theme),
                  const SizedBox(height: AppDesignTokens.spaceXl),
                  FinViewCard(
                    padding: const EdgeInsets.all(AppDesignTokens.spaceLg),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Sign in',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppDesignTokens.spaceXs),
                          Text(
                            'Access your portfolio dashboard',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: AppDesignTokens.spaceLg),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person_outline_rounded),
                            ),
                            autofillHints: const [AutofillHints.username],
                            textInputAction: TextInputAction.next,
                            enabled: !isSubmitting,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppDesignTokens.spaceMd),
                          TextFormField(
                            controller: _pinController,
                            decoration: const InputDecoration(
                              labelText: 'PIN',
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                            ),
                            autofillHints: const [AutofillHints.password],
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
                            const SizedBox(height: AppDesignTokens.spaceMd),
                            Semantics(
                              liveRegion: true,
                              child: Text(
                                errorMessage,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          const SizedBox(height: AppDesignTokens.spaceLg),
                          FilledButton(
                            onPressed: isSubmitting ? null : _submitLogin,
                            child: isSubmitting
                                ? const AppLoadingIndicator()
                                : const Text('Continue'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spaceMd),
                  Text(
                    'Demo: ${AuthConstants.username} / ${AuthConstants.pin}',
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginBrandHeader extends StatelessWidget {
  const _LoginBrandHeader({
    required this.finView,
    required this.theme,
  });

  final FinViewColors finView;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: finView.brand,
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
          ),
          child: Icon(
            Icons.show_chart_rounded,
            color: theme.colorScheme.surface,
            size: 24,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spaceMd),
        Text(
          'FinView',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDesignTokens.spaceSm),
        Text(
          'Modern portfolio tracking',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
