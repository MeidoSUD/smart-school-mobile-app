import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import 'password_strength_indicator.dart';

class SetNewPasswordForm extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;
  final AuthStatus status;
  final double passwordStrength;
  final String passwordStrengthText;
  final Color passwordStrengthColor;

  const SetNewPasswordForm({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.onSubmit,
    required this.status,
    required this.passwordStrength,
    required this.passwordStrengthText,
    required this.passwordStrengthColor,
  });

  @override
  State<SetNewPasswordForm> createState() => _SetNewPasswordFormState();
}

class _SetNewPasswordFormState extends State<SetNewPasswordForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Password field
          TextFormField(
            controller: widget.passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.newPassword,
              hintText: AppLocalizations.of(context)!.enterPassword,
              prefixIcon: Icon(Icons.lock_outline, color: theme.primaryColor),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.primaryColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.passwordRequired;
              }
              if (value.length < 8) {
                return AppLocalizations.of(context)!.passwordMinLength;
              }
              return null;
            },
          ),

          // Password strength indicator
          if (widget.passwordController.text.isNotEmpty) ...[
            const SizedBox(height: 12),
            PasswordStrengthIndicator(
              strength: widget.passwordStrength,
              strengthText: widget.passwordStrengthText,
              strengthColor: widget.passwordStrengthColor,
            ),
          ],

          const SizedBox(height: 24),

          // Confirm password field
          TextFormField(
            controller: widget.confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.confirmPassword,
              hintText: AppLocalizations.of(context)!.reEnterPassword,
              prefixIcon: Icon(Icons.lock_outline, color: theme.primaryColor),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.primaryColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.confirmPasswordRequired;
              }
              if (value != widget.passwordController.text) {
                return AppLocalizations.of(context)!.passwordMismatch;
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          // Submit button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: widget.status == AuthStatus.loading
                  ? null
                  : widget.onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                disabledBackgroundColor: theme.primaryColor.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: widget.status == AuthStatus.loading ? 0 : 4,
                shadowColor: theme.primaryColor.withOpacity(0.4),
              ),
              child: widget.status == AuthStatus.loading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      AppLocalizations.of(context)!.setPassword,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
