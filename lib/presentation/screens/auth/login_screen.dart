import 'package:geniuses_school/core/constants/app_assets.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/widgets/auth/LoginRegisterButton.dart';
import 'package:geniuses_school/presentation/widgets/common/TextFieldWidget.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/dialog_utils.dart';
import '../../../core/utils/error_mapper.dart';
import '../../state/auth_provider.dart';
import '../../state/locale_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isTablet = 1.sw >= 600;
    final maxWidth = isTablet ? 800.0 : double.infinity;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (!mounted) return;

      if (previous?.status != AuthStatus.error &&
          next.status == AuthStatus.error) {
        final errorMessage = next.message ?? "An unknown error occurred";
        DialogUtils.showFriendlyErrorDialog(
          context,
          message: ErrorMapper.translate(context, errorMessage),
        );
      } else if (previous?.status != AuthStatus.authenticated &&
          next.status == AuthStatus.authenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      // Language Toggle moved to FAB to ensure it's on top and clickable
      floatingActionButton: Consumer(
        builder: (context, ref, _) {
          return IconButton(
            onPressed: () {
              ref.read(localeProvider.notifier).toggleLocale();
            },
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
              ),
              child: Text(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? 'EN'
                    : 'AR',
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation:
          Localizations.localeOf(context).languageCode == 'ar'
          ? FloatingActionButtonLocation.miniStartTop
          : FloatingActionButtonLocation.miniEndTop,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Balls
            BallsWidget(
              size: 100,
              alignment: const Alignment(1.5, -0.8),
              opacity: 0.1,
              color: theme.primaryColor,
            ),
            BallsWidget(
              size: 150,
              alignment: const Alignment(-1.5, 0.5),
              opacity: 0.1,
              color: theme.primaryColor,
            ),
            BallsWidget(
              size: 60,
              alignment: const Alignment(1.2, 0.9),
              opacity: 0.1,
              color: theme.primaryColor,
            ),

            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 24 : 24.w,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 40.h),

                            // Logo Section
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor.withOpacity(0.1),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                AppAssets.logoArabic,
                                height: 60.h,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Illustration
                            Hero(
                              tag: 'auth_illustration',
                              child: Image.asset(
                                AppAssets.onboarding8,
                                height: 200.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Welcome Text
                            Text(
                              AppLocalizations.of(context)!.welcomeBack,
                              style: TextStyle(
                                fontSize: isTablet ? 32.sp : 32.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppLocalizations.of(context)!.pleaseLogin,
                              style: TextStyle(
                                fontSize: isTablet ? 16.sp : 16.sp,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),

                            // Login Form Card
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 30,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24.r),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Email/Phone Field
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.emailOrPhone,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(height: 8),
                                      TextFieldWidget(
                                        label: AppLocalizations.of(
                                          context,
                                        )!.enterEmailOrPhone,
                                        controller: _loginController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        prefixIcon: Icons.person_outline,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return AppLocalizations.of(
                                              context,
                                            )!.requiredField;
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 24),

                                      // Password Field
                                      Text(
                                        AppLocalizations.of(context)!.password,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(height: 8),
                                      TextFieldWidget(
                                        label: AppLocalizations.of(
                                          context,
                                        )!.enterPassword,
                                        controller: _passwordController,
                                        keyboardType: TextInputType.text,
                                        prefixIcon: Icons.lock_outline,
                                        obscureText: _obscurePassword,
                                        suffixIcon: _obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        suffixIconPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                        validator: (value) =>
                                            value != null && value.length >= 6
                                            ? null
                                            : AppLocalizations.of(
                                                context,
                                              )!.passwordMinLength,
                                      ),
                                      const SizedBox(height: 16),

                                      // Forgot Password
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            ref
                                                .read(authProvider.notifier)
                                                .clearAuthState();
                                            Navigator.pushNamed(
                                              context,
                                              '/send-phone',
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: const Size(0, 0),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.forgotPassword,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: theme.primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Login Button
                            LoginRigisterButton(
                              text: authState.status == AuthStatus.loading
                                  ? AppLocalizations.of(context)!.loggingIn
                                  : AppLocalizations.of(context)!.login,
                              onPressed: authState.status == AuthStatus.loading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        final loginInput = _loginController.text
                                            .trim();
                                        final isEmail = loginInput.contains(
                                          '@',
                                        );

                                        ref
                                            .read(authProvider.notifier)
                                            .login(
                                              email: isEmail
                                                  ? loginInput
                                                  : null,
                                              phone: isEmail
                                                  ? null
                                                  : loginInput,
                                              password:
                                                  _passwordController.text,
                                            );
                                      }
                                    },
                            ),
                            const SizedBox(height: 24),

                            // Register Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/roles');
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.registerNow,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.dontHaveAccount,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // About App Link
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/about');
                              },
                              child: Text(
                                AppLocalizations.of(context)!.aboutApp,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).viewInsets.bottom > 0
                                  ? 32
                                  : 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
