import 'package:geniuses_school/core/constants/app_assets.dart';
import 'package:geniuses_school/core/services/appsflyer_service.dart';
import 'package:geniuses_school/core/services/att_service.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/notification_service.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/state/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../otp/otp_confirm_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  final storage = const FlutterSecureStorage();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _checkAppState();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward().then((_) {
      if (mounted) {
        _controller.repeat(min: 0.5, reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkAppState() async {
    try {
      // Show splash animation
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      // Check if onboarding done
      final onboardingDone = await storage.read(key: 'onboarding_done');
      Logger.log("Splash: onboarding_done = $onboardingDone");
      if (onboardingDone != 'true') {
        _navigateToOnboarding();
        return;
      }

      // Check token
      final token = await storage.read(key: 'token');
      Logger.log("Splash: token exists = ${token != null && token.isNotEmpty}");

      if (token != null && token.isNotEmpty) {
        await _authenticateWithToken(token);
      } else {
        // Check for pending registration
        await ref.read(authProvider.notifier).checkPendingRegistration();
        if (!mounted) return;

        final authState = ref.read(authProvider);
        if (authState.status == AuthStatus.registered &&
            authState.message == 'Resumed pending registration') {
          // Navigate to OTP screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => OtpConfirmScreen(
                phoneNumber: authState.user?.phone_number ?? '',
                type: 'register',
              ),
            ),
          );
          return;
        }

        _navigateToHome();
      }
    } catch (e) {
      Logger.log("Splash check failed: $e. Navigating to login.");
      _navigateToLogin();
    }
  }

  Future<void> _initAnalytics() async {
    try {
      // Request App Tracking Transparency authorization
      await ATTService.requestTrackingAuthorization();
      
      // Initialize AppsFlyer after ATT
      await AppsflyerService().init();
      Logger.log("Analytics initialized successfully");
    } catch (e) {
      Logger.log("Analytics initialization error: $e");
    }
  }

  Future<void> _authenticateWithToken(String token) async {
    try {
      // Get user data
      await ref.read(authProvider.notifier).getUser(token);

      if (!mounted) return;

      // Check if user data loaded successfully
      final authState = ref.read(authProvider);

      if (authState.status == AuthStatus.unauthenticated) {
        _navigateToLogin();
        return;
      }

      final user = authState.user;
      if (user != null) {
        try {
          await NotificationService.initialize(
            userId: authState.user!.id,
            userToken: token,
            ref: ref,
          );

          final notificationState = ref.read(notificationProvider);
          if (notificationState.notifications.isEmpty) {
            ref.read(notificationProvider.notifier).fetchNotifications();
          }
        } catch (e) {
          Logger.log(
            "Notification initialization failed: $e. Proceeding to home.",
          );
        }
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    } catch (e) {
      Logger.log("Authentication failed: $e. Navigating to login.");
      await storage.delete(key: 'token');
      _navigateToLogin();
    }
  }

  void _navigateToOnboarding() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/onboarding');
  }

  void _navigateToLogin() async {
    if (!mounted) return;
    await _initAnalytics();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _navigateToHome() async {
    if (!mounted) return;
    await _initAnalytics();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Center(child: _buildSplashView())),
    );
  }

  Widget _buildSplashView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: _animation,
          child: Image.asset(AppAssets.logoArabic, height: 200),
        ),
      ],
    );
  }
}
