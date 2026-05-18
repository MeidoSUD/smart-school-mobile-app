import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../bloc/calendar_cubit.dart';
import '../bloc/calendar_state.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<CalendarCubit>()..loadEvents(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.calendar_title)),
        ),
        body: BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (events) {
                if (events.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final e = events[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    e.date.split('-').last,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  Text(
                                    e.date.split('-')[1],
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                  if (e.description != null && e.description!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.h),
                                      child: Text(e.description!, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                    ),
                                  if (e.time != null && e.time!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.h),
                                      child: Row(
                                        children: [
                                          Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                                          SizedBox(width: 4.w),
                                          Text(e.time!, style: TextStyle(fontSize: 11.sp, color: Colors.grey[500])),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              error: (message) => Center(child: Text(message)),
            );
          },
        ),
      ),
    );
  }
}
