import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/route_keys.dart';
import '../../../../core/constants/assets_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.goNamed(RouteKeys.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.7), theme.colorScheme.primary.withValues(alpha: 0.5)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 30, offset: const Offset(0, 10))],
              ),
              padding: EdgeInsets.all(20.w),
              child: Image.asset(AssetsManager.logoWithName, fit: BoxFit.contain),
            ),
            SizedBox(height: 20.h),
            Text(
              'Smart School',
              style: TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            ),
            SizedBox(height: 8.h),
            Text(
              context.tr(LocaleKeys.splash_loading),
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14.sp),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 48.h),
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
