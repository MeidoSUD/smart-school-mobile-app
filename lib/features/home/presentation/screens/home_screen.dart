import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_keys.dart';
import '../../../../core/constants/assets_manager.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _HeaderSection(),
          Expanded(child: _FeatureGrid()),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 48.h, 20.w, 28.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.75),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28.r),
          bottomRight: Radius.circular(28.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: ClipOval(
                  child: Image.asset(
                    AssetsManager.logoWithName,
                    fit: BoxFit.cover,
                    width: 40.w,
                    height: 40.w,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr(LocaleKeys.home_welcome),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      'Ahmed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 26.sp,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 26.sp,
                ),
                onPressed: () => context.pushNamed(RouteKeys.settings),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              _QuickStat(
                icon: Icons.check_circle_outline,
                label: '85%',
                subtitle: context.tr(LocaleKeys.home_attendance),
              ),
              _QuickStat(
                icon: Icons.payment_outlined,
                label: '\$2.5k',
                subtitle: context.tr(LocaleKeys.home_fees),
              ),
              _QuickStat(
                icon: Icons.assignment_outlined,
                label: '3',
                subtitle: context.tr(LocaleKeys.home_exams),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;

  const _QuickStat({
    required this.icon,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 22.sp),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
            child: Text(
              context.tr(LocaleKeys.home_services),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 0.8,
              ),
              itemCount: _featureItems.length,
              itemBuilder: (context, index) {
                final item = _featureItems[index];
                return _FeatureCard(
                  imagePath: item.imagePath,
                  label: context.tr(item.labelKey),
                  onTap: () => context.pushNamed(item.route),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.r),
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.08),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.grey.shade100, width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: Image.asset(imagePath, fit: BoxFit.contain),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem {
  final String imagePath;
  final String labelKey;
  final String route;

  const _FeatureItem({
    required this.imagePath,
    required this.labelKey,
    required this.route,
  });
}

final List<_FeatureItem> _featureItems = [
  const _FeatureItem(
    imagePath: AssetsManager.marksIcon,
    labelKey: LocaleKeys.home_dashboard,
    route: RouteKeys.dashboard,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.feesIcon,
    labelKey: LocaleKeys.home_fees,
    route: RouteKeys.fees,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.attendanceIcon,
    labelKey: LocaleKeys.home_attendance,
    route: RouteKeys.attendance,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.homeworkIcon,
    labelKey: LocaleKeys.home_homework,
    route: RouteKeys.homework,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.timetableIcon,
    labelKey: LocaleKeys.home_timetable,
    route: RouteKeys.timetable,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.subjectsIcon,
    labelKey: LocaleKeys.home_subjects,
    route: RouteKeys.subjects,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.examsIcon,
    labelKey: LocaleKeys.home_exams,
    route: RouteKeys.exams,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.chatIcon,
    labelKey: LocaleKeys.home_chat,
    route: RouteKeys.chat,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.libraryIcon,
    labelKey: LocaleKeys.home_library,
    route: RouteKeys.library,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.transportIcon,
    labelKey: LocaleKeys.home_transport,
    route: RouteKeys.transport,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.syllabusIcon,
    labelKey: LocaleKeys.home_syllabus,
    route: RouteKeys.syllabus,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.teachersIcon,
    labelKey: LocaleKeys.home_teachers,
    route: RouteKeys.teachers,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.leaveIcon,
    labelKey: LocaleKeys.home_leave,
    route: RouteKeys.leave,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.visitorsIcon,
    labelKey: LocaleKeys.home_visitors,
    route: RouteKeys.visitors,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.hostelIcon,
    labelKey: LocaleKeys.home_hostel,
    route: RouteKeys.hostel,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.onlineExamIcon,
    labelKey: LocaleKeys.home_online_exam,
    route: RouteKeys.onlineExam,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.calendarIcon,
    labelKey: LocaleKeys.home_calendar,
    route: RouteKeys.calendar,
  ),
  const _FeatureItem(
    imagePath: AssetsManager.profileIcon,
    labelKey: LocaleKeys.home_profile,
    route: RouteKeys.profile,
  ),
];
