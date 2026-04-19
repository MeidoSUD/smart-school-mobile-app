import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectWidget extends StatelessWidget {
  final String subject;
  final VoidCallback? onTap;
  const SubjectWidget({super.key, required this.subject, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(4.0.r),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 120.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.primaryColorDark,
                theme.primaryColor,

                // theme.primaryColor.withOpacity(0.8), // lighter shade
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
              child: Text(
                subject,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
