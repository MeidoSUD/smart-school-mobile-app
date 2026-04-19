import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color; // Add color parameter
  const SettingItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.color, // Initialize color
  });

  @override
  Widget build(BuildContext context) {
    bool isTablet = 1.sw > 600;

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 : 20,
          vertical: isTablet ? 16 : 12,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (color ?? Colors.grey).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color ?? Colors.grey,
                size: isTablet ? 24.sp : 20.sp,
              ),
            ),
            SizedBox(width: isTablet ? 20.w : 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color ?? Colors.black87,
                  fontSize: isTablet ? 18.sp : 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: isTablet ? 18.sp : 14.sp,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
