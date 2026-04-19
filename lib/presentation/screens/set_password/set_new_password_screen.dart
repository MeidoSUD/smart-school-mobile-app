import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/set_password/password_success_dialog.dart';
import '../../widgets/set_password/set_new_password_form.dart';

class SetNewPasswordScreen extends ConsumerStatefulWidget {
  final String? token; // Optional token from forgot password flow

  const SetNewPasswordScreen({super.key, this.token});

  @override
  ConsumerState<SetNewPasswordScreen> createState() =>
      _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends ConsumerState<SetNewPasswordScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Password strength indicator
  double _passwordStrength = 0.0;
  String _passwordStrengthText = '';
  Color _passwordStrengthColor = Colors.red;

  @override
  void initState() {
    super.initState();

    // Animations
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _slideController.forward();
    _fadeController.forward();

    // Listen to password changes for strength indicator
    _passwordController.addListener(_updatePasswordStrength);
  }

  void _updatePasswordStrength() {
    final l10n = AppLocalizations.of(context)!;
    final password = _passwordController.text;
    double strength = 0.0;

    if (password.isEmpty) {
      strength = 0.0;
    } else {
      if (password.length >= 8) strength += 0.25;
      if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
      if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))
        strength += 0.25;
    }

    setState(() {
      _passwordStrength = strength;
      if (strength == 0) {
        _passwordStrengthText = '';
        _passwordStrengthColor = Colors.red;
      } else if (strength <= 0.25) {
        _passwordStrengthText = l10n.passwordStrengthVeryWeak;
        _passwordStrengthColor = Colors.red;
      } else if (strength <= 0.5) {
        _passwordStrengthText = l10n.passwordStrengthWeak;
        _passwordStrengthColor = Colors.orange;
      } else if (strength <= 0.75) {
        _passwordStrengthText = l10n.passwordStrengthMedium;
        _passwordStrengthColor = Colors.yellow.shade700;
      } else {
        _passwordStrengthText = l10n.passwordStrengthStrong;
        _passwordStrengthColor = Colors.green;
      }
    });
  }

  Future<void> _handleSetPassword() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final userId = args?['userId'] as int?;
    final code = args?['code'] as String?;

    FocusScope.of(context).unfocus();

    if (userId == null || code == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.verificationDataMissing)));
      return;
    }

    await ref
        .read(authProvider.notifier)
        .confirmResetPassword(
          userId: userId,
          code: code,
          newPassword: _passwordController.text,
          newPasswordConfirmation: _confirmPasswordController.text,
        );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const PasswordSuccessDialog(),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final passwordState = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context)!;

    // Listen to state changes
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (!mounted) return;

      if (previous?.status == AuthStatus.loading &&
          next.status == AuthStatus.error) {
        final errorMessage = next.message ?? "An unknown error occurred";
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
      } else if (previous?.status == AuthStatus.loading &&
          (next.status == AuthStatus.unauthenticated ||
              next.status == AuthStatus.authenticated)) {
        // Show success dialog
        _showSuccessDialog();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration

            // Main content
            Column(
              children: [
                // Back button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            // Icon
                            Center(
                              child: TweenAnimationBuilder(
                                tween: Tween<double>(begin: 0, end: 1),
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.elasticOut,
                                builder: (context, double value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor.withOpacity(
                                          0.1,
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: theme.primaryColor
                                                .withOpacity(0.2),
                                            blurRadius: 30,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.lock_reset,
                                        size: 80,
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Title
                            Text(
                              l10n.setNewPasswordTitle,
                              style: theme.textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Subtitle
                            Text(
                              l10n.setNewPasswordSubtitle,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 40),

                            SetNewPasswordForm(
                              passwordController: _passwordController,
                              confirmPasswordController:
                                  _confirmPasswordController,
                              formKey: _formKey,
                              onSubmit: _handleSetPassword,
                              status: passwordState.status,
                              passwordStrength: _passwordStrength,
                              passwordStrengthText: _passwordStrengthText,
                              passwordStrengthColor: _passwordStrengthColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
