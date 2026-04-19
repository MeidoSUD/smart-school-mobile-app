import 'dart:async';

import 'package:geniuses_school/core/utils/error_handler.dart';
import 'package:geniuses_school/core/utils/error_mapper.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/otp/otp_header.dart';
import '../../widgets/otp/otp_input_fields.dart';
import '../../widgets/otp/otp_timer_section.dart';

class OtpConfirmScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String type;

  const OtpConfirmScreen({
    super.key,
    required this.phoneNumber,
    required this.type,
  });

  @override
  ConsumerState<OtpConfirmScreen> createState() => _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends ConsumerState<OtpConfirmScreen>
    with TickerProviderStateMixin {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  int _remainingSeconds = 60;
  Timer? _timer;
  bool _canResend = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startTimer();
  }

  void _initializeAnimations() {
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

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _slideController.forward();
    _fadeController.forward();
  }

  void _startTimer() {
    _remainingSeconds = 60;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        setState(() => _canResend = true);
        timer.cancel();
      }
    });
  }

  Future<void> _resendCode() async {
    if (!_canResend) return;

    try {
      if (widget.type == 'reset') {
        await ref
            .read(authProvider.notifier)
            .initiatePasswordReset(phone: widget.phoneNumber);
      } else {
        final userId = ref.read(authProvider).user?.id;
        if (userId == null) throw Exception("User ID not found");
        await ref.read(authProvider.notifier).resendCode(userId);
      }

      if (!mounted) return;

      _startTimer();
      _showSnackBar(AppLocalizations.of(context)!.codeResent, isError: false);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(
        AppLocalizations.of(context)!.codeResendFailed,
        isError: true,
      );
    }
  }

  Future<void> _verifyOtp() async {
    // Prevent multiple calls
    if (_isNavigating) return;

    final otp = _controllers.map((c) => c.text).join();

    if (otp.length != 4) {
      _showErrorDialog(AppLocalizations.of(context)!.enterFullCode);
      return;
    }

    final authState = ref.watch(authProvider);

    final userId = authState.user?.id;

    if (userId == null) {
      _showErrorDialog(AppLocalizations.of(context)!.errorTryAgain);
      return;
    }

    try {
      if (widget.type == 'reset') {
        await ref.read(authProvider.notifier).verifyResetCode(userId, otp);
      } else {
        await ref.read(authProvider.notifier).verify(otp, userId);
      }

      if (!mounted || _isNavigating) return;

      // Check verification result
      final updatedState = ref.read(authProvider);
      final isVerified =
          updatedState.status == AuthStatus.authenticated ||
          updatedState.status == AuthStatus.verified;

      if (isVerified) {
        _isNavigating = true;
        if (widget.type == 'reset') {
          Navigator.pushNamed(
            context,
            '/edit-password',
            arguments: {'userId': userId, 'code': otp},
          );
        } else {
          _navigateToHome();
        }
      } else {
        _showErrorDialog(AppLocalizations.of(context)!.invalidVerificationCode);
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog(_getErrorMessage(e));
    }
  }

  String _getErrorMessage(dynamic error) {
    return ErrorMapper.translate(context, ErrorHandler.getErrorMessage(error));
  }

  void _showSnackBar(String message, {required bool isError}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Theme.of(context).primaryColor,
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        action: isError
            ? SnackBarAction(
                label: AppLocalizations.of(context)!.close,
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              )
            : null,
      ),
    );
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade700, size: 28),
            const SizedBox(width: 10),
            Text(
              AppLocalizations.of(context)!.error,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppLocalizations.of(context)!.ok,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToHome() {
    _isNavigating = true;

    if (widget.type == 'reset') {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/edit-phone', (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _slideController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = 1.sw >= 600;
    final maxWidth = isTablet ? 800.0 : double.infinity;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (!mounted || _isNavigating) return;

      if (next.status == AuthStatus.error) {
        _showSnackBar(
          ErrorMapper.translate(context, next.message ?? ""),
          isError: true,
        );
      }

      if (next.status == AuthStatus.authenticated && next.user != null) {
        // Maybe navigate or update UI
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackgroundCircles(theme),
            Column(
              children: [
                // Back button
                _buildBackButton(),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              children: [
                                SizedBox(height: 20.h),
                                OtpHeader(phoneNumber: widget.phoneNumber),
                                SizedBox(height: 50.h),
                                OtpInputFields(
                                  controllers: _controllers,
                                  focusNodes: _focusNodes,
                                  onCompleted: _verifyOtp,
                                ),
                                SizedBox(height: 40.h),
                                OtpTimerSection(
                                  remainingSeconds: _remainingSeconds,
                                  canResend: _canResend,
                                  onResend: _resendCode,
                                ),
                                SizedBox(height: 40.h),
                                _buildVerifyButton(theme),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ),
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

  Widget _buildBackgroundCircles(ThemeData theme) {
    return Stack(
      children: [
        Positioned(
          top: -50,
          right: -50,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  width: 200 + (_pulseController.value * 20),
                  height: 200 + (_pulseController.value * 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.primaryColor.withOpacity(0.1),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: -80,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  width: 250 + (_pulseController.value * 25),
                  height: 250 + (_pulseController.value * 25),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.primaryColor.withOpacity(0.08),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyButton(ThemeData theme) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;
    final isVerified = authState.status == AuthStatus.authenticated;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: (isLoading || isVerified) ? null : _verifyOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          disabledBackgroundColor: theme.primaryColor.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: theme.primaryColor.withOpacity(0.4),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                AppLocalizations.of(context)!.verify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
