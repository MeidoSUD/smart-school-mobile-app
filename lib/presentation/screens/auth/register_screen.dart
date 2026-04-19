import 'package:geniuses_school/core/constants/app_assets.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/widgets/auth/GenderFieldWidget.dart';
import 'package:geniuses_school/presentation/widgets/auth/LoginRegisterButton.dart';
import 'package:geniuses_school/presentation/widgets/auth/NationalityFieldWidget.dart';
import 'package:geniuses_school/presentation/widgets/auth/PhoneNumberFieldWidget.dart';
import 'package:geniuses_school/presentation/widgets/common/TextFieldWidget.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/dialog_utils.dart';
import '../../../core/utils/error_mapper.dart';
import '../../../data/models/auth/student_registration_request.dart';
import '../../state/auth_provider.dart';
import '../otp/otp_confirm_screen.dart';
import 'teacher_additional_info_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  bool _obscurePassword = true;
  bool _agreedToTnC = false;

  String _selectedCode = '966';
  String? _selectedNationality;
  String? _selectedGender;
  int _selectedRoleId = 4;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final authState = ref.read(authProvider);
      if (args != null && args is Map<String, dynamic>) {
        setState(() {
          _selectedRoleId =
              args['roleId'] ??
              authState.user?.role_id ??
              AppConstants.roleStudent;
        });
      } else if (authState.user?.role_id != null &&
          authState.user!.role_id != 0) {
        setState(() {
          _selectedRoleId = authState.user!.role_id;
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.launchUrlError(urlString),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isTablet = 1.sw >= 600;
    final maxWidth = isTablet ? 800.0 : double.infinity;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (!mounted) return;

      if (previous?.status != AuthStatus.registered &&
          next.status == AuthStatus.registered) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpConfirmScreen(
              phoneNumber: _phoneController.text,
              type: 'register',
            ),
          ),
        );
      }

      if (previous?.status != AuthStatus.error &&
          next.status == AuthStatus.error) {
        final errorMessage = next.message ?? "An unknown error occurred";

        // Handle specific error codes
        if (errorMessage == "ALREADY_REGISTERED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.accountExists),
              content: Text(AppLocalizations.of(context)!.accountExistsMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(AppLocalizations.of(context)!.login),
                ),
              ],
            ),
          );
        } else if (errorMessage == "UNVERIFIED_USER") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.verificationRequired),
              content: Text(
                AppLocalizations.of(context)!.continueVerificationMessage,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate to OTP
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OtpConfirmScreen(
                          phoneNumber: _phoneController
                              .text, // Might be empty if retrying? Ideally prefill from state if available?
                          // Actually for unverified error, we might need to resend OTP first?
                          // But let's assume we go to OTP screen which handles resend or input.
                          // It requires phone number. If error comes from register attempt, _phoneController has it.
                          type: 'register',
                        ),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.verify),
                ),
              ],
            ),
          );
        } else if (errorMessage.startsWith("VALIDATION_ERROR:")) {
          final displayMsg = errorMessage.substring("VALIDATION_ERROR:".length);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.validationError),
              content: Text(displayMsg), // Or translate if needed
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.ok),
                ),
              ],
            ),
          );
        } else if (errorMessage.startsWith("BACKEND_ERROR:")) {
          final parts = errorMessage
              .substring("BACKEND_ERROR:".length)
              .split("|");
          final enMessage = parts.isNotEmpty ? parts[0] : "";
          final arMessage = parts.length > 1 ? parts[1] : enMessage;

          final isArabic = Localizations.localeOf(context).languageCode == 'ar';
          final displayMessage = isArabic ? arMessage : enMessage;

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.validationError),
              content: Text(displayMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppLocalizations.of(context)!.ok),
                ),
              ],
            ),
          );
        } else {
          // General error
          DialogUtils.showFriendlyErrorDialog(
            context,
            message: ErrorMapper.translate(context, errorMessage),
          );
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
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
                    // App Bar (Custom Header)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 24 : 24.w,
                          vertical: isTablet ? 24 : 16.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Logo
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.primaryColor.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                AppAssets.logoArabic,
                                height: 40,
                              ),
                            ),
                            // Back to Login
                            TextButton.icon(
                              onPressed: () => Navigator.pushReplacementNamed(
                                context,
                                '/login',
                              ),
                              icon: const Icon(Icons.arrow_forward),
                              label: Text(AppLocalizations.of(context)!.login),
                              style: TextButton.styleFrom(
                                foregroundColor: theme.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Content
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 24 : 24.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 16.h),

                            // Title Section
                            Text(
                              AppLocalizations.of(context)!.createAccount,
                              style: TextStyle(
                                fontSize: isTablet ? 32.sp : 32.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.2,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppLocalizations.of(context)!.joinCommunity,
                              style: TextStyle(
                                fontSize: isTablet ? 16.sp : 16.sp,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 32),

                            // Form Card
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
                                      // Name Fields
                                      Text(
                                        AppLocalizations.of(context)!.fullName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFieldWidget(
                                              label: AppLocalizations.of(
                                                context,
                                              )!.lastName,
                                              controller: _lastNameController,
                                              prefixIcon: Icons.person_outline,
                                              validator: (v) => v!.isEmpty
                                                  ? AppLocalizations.of(
                                                      context,
                                                    )!.required
                                                  : null,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextFieldWidget(
                                              label: AppLocalizations.of(
                                                context,
                                              )!.firstName,
                                              controller: _firstNameController,
                                              prefixIcon: Icons.person_outline,
                                              validator: (v) => v!.isEmpty
                                                  ? AppLocalizations.of(
                                                      context,
                                                    )!.required
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),

                                      // Email - Only for Teacher
                                      if (_selectedRoleId == 3) ...[
                                        Text(
                                          AppLocalizations.of(context)!.email,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade700,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        const SizedBox(height: 8),
                                        TextFieldWidget(
                                          label: "example@email.com",
                                          controller: _emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          prefixIcon: Icons.email_outlined,
                                          validator: (v) =>
                                              (v != null && v.contains("@"))
                                              ? null
                                              : AppLocalizations.of(
                                                  context,
                                                )!.invalidEmail,
                                        ),
                                        const SizedBox(height: 24),
                                      ],

                                      // Phone Number
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.phoneNumber,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      const SizedBox(height: 8),
                                      PhoneNumberFieldWidget(
                                        controller: _phoneController,
                                        selectedCode: _selectedCode,
                                        validator: (v) =>
                                            (v == null || v.isEmpty)
                                            ? AppLocalizations.of(
                                                context,
                                              )!.required
                                            : (v.length != 9
                                                  ? AppLocalizations.of(
                                                      context,
                                                    )!.invalidPhoneNumberError
                                                  : null),
                                        onCodeChanged: (c) =>
                                            setState(() => _selectedCode = c),
                                      ),
                                      const SizedBox(height: 24),

                                      // Nationality - Only for Teacher
                                      if (_selectedRoleId == 3) ...[
                                        Text(
                                          "${AppLocalizations.of(context)!.nationality} ${AppLocalizations.of(context)!.optional}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade700,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        const SizedBox(height: 8),
                                        NationalityFieldWidget(
                                          selectedNationality:
                                              _selectedNationality,
                                          onChanged: (n) => setState(
                                            () => _selectedNationality = n,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                      ],

                                      // Gender - Only for Teacher
                                      if (_selectedRoleId == 3) ...[
                                        Text(
                                          "${AppLocalizations.of(context)!.gender} ${AppLocalizations.of(context)!.optional}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade700,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                        const SizedBox(height: 8),
                                        GenderFieldWidget(
                                          selectedGender: _selectedGender,
                                          onChanged: (g) => setState(
                                            () => _selectedGender = g,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                      ],

                                      // Password
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
                                        )!.strongPassword,
                                        controller: _passwordController,
                                        obscureText: _obscurePassword,
                                        prefixIcon: Icons.lock_outline,
                                        suffixIcon: _obscurePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        suffixIconPressed: () => setState(
                                          () => _obscurePassword =
                                              !_obscurePassword,
                                        ),
                                        validator: (v) =>
                                            (v != null && v.length >= 8)
                                            ? null
                                            : AppLocalizations.of(
                                                context,
                                              )!.passwordMinLength,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Terms & Conditions
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _agreedToTnC
                                      ? theme.primaryColor.withOpacity(0.3)
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => setState(
                                    () => _agreedToTnC = !_agreedToTnC,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: _agreedToTnC
                                                ? theme.primaryColor
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                              color: _agreedToTnC
                                                  ? theme.primaryColor
                                                  : Colors.grey.shade400,
                                              width: 2,
                                            ),
                                          ),
                                          child: _agreedToTnC
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 16,
                                                  color: Colors.white,
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Wrap(
                                            alignment: WrapAlignment.end,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.agreeTo,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => _launchURL(
                                                  'https://ewan-geniuses.com/privacy-policy/',
                                                ),
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.termsConditions,
                                                  style: TextStyle(
                                                    color: theme.primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.and,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => _launchURL(
                                                  'https://ewan-geniuses.com/privacy-policy/',
                                                ),
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.privacyPolicy,
                                                  style: TextStyle(
                                                    color: theme.primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Register Button
                            LoginRigisterButton(
                              text: authState.status == AuthStatus.loading
                                  ? AppLocalizations.of(context)!.registering
                                  : _selectedRoleId == AppConstants.roleTeacher
                                  ? AppLocalizations.of(context)!.continueBtn
                                  : AppLocalizations.of(
                                      context,
                                    )!.registerButton,
                              onPressed: authState.status == AuthStatus.loading
                                  ? null
                                  : () {
                                      if (!_agreedToTnC) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.acceptTermsError,
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor:
                                                Colors.orange.shade600,
                                          ),
                                        );
                                        return;
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        if (_selectedRoleId ==
                                            AppConstants.roleTeacher) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  TeacherAdditionalInfoScreen(
                                                    basicInfo: {
                                                      'firstName':
                                                          _firstNameController
                                                              .text,
                                                      'lastName':
                                                          _lastNameController
                                                              .text,
                                                      'email':
                                                          _emailController.text,
                                                      'phoneNumber':
                                                          "$_selectedCode${_phoneController.text}",
                                                      'password':
                                                          _passwordController
                                                              .text,
                                                      'gender': _selectedGender,
                                                      'nationality':
                                                          _selectedNationality,
                                                    },
                                                  ),
                                            ),
                                          );
                                        } else {
                                          ref
                                              .read(authProvider.notifier)
                                              .registerStudent(
                                                StudentRegistrationRequest(
                                                  firstName:
                                                      _firstNameController.text,
                                                  lastName:
                                                      _lastNameController.text,
                                                  email: _emailController.text,
                                                  phoneNumber:
                                                      "$_selectedCode${_phoneController.text}",
                                                  password:
                                                      _passwordController.text,
                                                  gender: _selectedGender,
                                                  nationality:
                                                      _selectedNationality,
                                                ),
                                              );
                                        }
                                      }
                                    },
                            ),

                            SizedBox(
                              height:
                                  MediaQuery.of(context).viewInsets.bottom > 0
                                  ? 32
                                  : 64,
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
