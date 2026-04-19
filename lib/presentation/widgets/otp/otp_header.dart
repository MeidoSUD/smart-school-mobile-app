import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';

class OtpHeader extends StatelessWidget {
  final String phoneNumber;

  const OtpHeader({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.elasticOut,
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                padding: EdgeInsets.all(30.r),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withOpacity(0.2),
                      blurRadius: 30.r,
                      spreadRadius: 5.r,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 80.sp,
                  color: theme.primaryColor,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 40.h),
        Text(
          AppLocalizations.of(context)!.verificationHeader,
          style: theme.textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 24.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Column(
          children: [
            Text(
              AppLocalizations.of(context)!.codeSentToUser,
              style: TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
            ),
            SizedBox(height: 4.h),
            Text(
              phoneNumber,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
