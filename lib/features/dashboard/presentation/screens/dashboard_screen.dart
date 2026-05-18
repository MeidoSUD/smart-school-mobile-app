import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/dashboard_cubit.dart';
import '../../../../core/di/injection.dart';
import '../bloc/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<DashboardCubit>()..loadDashboard(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.home_dashboard)),
        ),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (dashboard) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.8)],
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(context.tr(LocaleKeys.dashboard_attendance_percentage),
                                style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
                            SizedBox(height: 4.h),
                            Text('${dashboard.attendancePercentage}%',
                                style: TextStyle(color: Colors.white, fontSize: 36.sp, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(context.tr(LocaleKeys.dashboard_recent_homework),
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.h),
                      if (dashboard.homeworkList.isEmpty)
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Text(context.tr(LocaleKeys.common_no_data), textAlign: TextAlign.center),
                          ),
                        )
                      else
                        ...dashboard.homeworkList.map((hw) => Card(
                          margin: EdgeInsets.only(bottom: 10.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 40.w, height: 40.w,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(Icons.assignment, color: theme.colorScheme.primary, size: 20.sp),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(hw['title']?.toString() ?? '', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                      Text(hw['subject']?.toString() ?? '', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                      SizedBox(height: 16.h),
                      Text(context.tr(LocaleKeys.dashboard_recent_notifications),
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12.h),
                      if (dashboard.notificationList.isEmpty)
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Text(context.tr(LocaleKeys.common_no_data), textAlign: TextAlign.center),
                          ),
                        )
                      else
                        ...dashboard.notificationList.map((n) => Card(
                          margin: EdgeInsets.only(bottom: 10.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                          child: ListTile(
                            leading: const Icon(Icons.notifications_active, color: Colors.orange),
                            title: Text(n['title']?.toString() ?? '', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                            subtitle: Text(n['message']?.toString() ?? '', style: TextStyle(fontSize: 12.sp)),
                          ),
                        )),
                    ],
                  ),
                );
              },
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<DashboardCubit>().loadDashboard(),
                      child: Text(context.tr(LocaleKeys.common_retry)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
