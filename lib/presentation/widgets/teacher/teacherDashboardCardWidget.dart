import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';

class TeacherDashboardCardWidget extends StatelessWidget {
  final double todayEarnings;
  final double monthEarnings;
  final double totalEarnings;
  final int totalLessons;
  final double currentBalance;
  final int ongoingLessons;
  final String? currency;

  const TeacherDashboardCardWidget({
    super.key,
    required this.todayEarnings,
    required this.monthEarnings,
    required this.totalEarnings,
    required this.totalLessons,
    required this.ongoingLessons,
    required this.currentBalance,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayCurrency = currency ?? AppLocalizations.of(context)!.currency;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.4),
            blurRadius: 6.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.teacherDashboard,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.h),

          // Earnings row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItem(
                AppLocalizations.of(context)!.today,
                todayEarnings,
                displayCurrency,
              ),
              _buildItem(
                AppLocalizations.of(context)!.thisMonth,
                monthEarnings,
                displayCurrency,
              ),
              _buildItem(
                AppLocalizations.of(context)!.total,
                totalEarnings,
                displayCurrency,
              ),
              _buildItem(
                AppLocalizations.of(context)!.currentBalance,
                currentBalance,
                displayCurrency,
              ),
            ],
          ),

          SizedBox(height: 20.h),
          const Divider(color: Colors.white54),

          // Lessons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                Icons.menu_book,
                AppLocalizations.of(context)!.totalLessons,
                totalLessons.toString(),
              ),
              _buildStatItem(
                Icons.play_circle_fill,
                AppLocalizations.of(context)!.ongoingLessons,
                ongoingLessons.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String label, double amount, String currency) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: amount),
      duration: const Duration(seconds: 2),
      builder: (context, value, _) => Column(
        children: [
          Text(
            "${value.toStringAsFixed(0)} $currency",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28.sp),
        SizedBox(height: 6.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 13.sp),
        ),
      ],
    );
  }
}
