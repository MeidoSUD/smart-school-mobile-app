import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/theme/app_theme.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/core/routes/app_routes.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';
import 'package:geniuses_school/presentation/widgets/common_widgets.dart';

class LmsLoginScreen extends ConsumerStatefulWidget {
  const LmsLoginScreen({super.key});

  @override
  ConsumerState<LmsLoginScreen> createState() => _LmsLoginScreenState();
}

class _LmsLoginScreenState extends ConsumerState<LmsLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(lmsAuthProvider.notifier).login(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(lmsAuthProvider);

    ref.listen<LmsAuthState>(lmsAuthProvider, (previous, next) {
      if (next.status == LmsAuthStatus.authenticated) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.lmsHome);
      } else if (next.status == LmsAuthStatus.error && next.message != null) {
        AppErrorSnackbar.show(context, next.message!);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Logo
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      AppConstants.logo,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.school,
                          size: 60,
                          color: AppColors.primary,
                        );
                      },
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // App Name
                const Text(
                  'Smart School',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'Login to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 48),
                
                // Username Field
                AppTextField(
                  controller: _usernameController,
                  label: 'Username',
                  hint: 'Enter your username',
                  prefixIcon: const Icon(Icons.person_outline),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Password Field
                AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Login Button
                AppButton(
                  text: 'Login',
                  onPressed: authState.status == LmsAuthStatus.loading ? null : _login,
                  isLoading: authState.status == LmsAuthStatus.loading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}