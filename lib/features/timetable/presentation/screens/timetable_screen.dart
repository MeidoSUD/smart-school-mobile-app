import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/timetable_cubit.dart';
import '../../../../core/di/injection.dart';
import '../bloc/timetable_state.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<TimetableCubit>()..loadTimetable(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.timetable_title)),
        ),
        body: BlocBuilder<TimetableCubit, TimetableState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (timetable) {
                if (timetable.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: timetable.length,
                  itemBuilder: (context, index) {
                    final item = timetable[index];
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
                                color: _getDayColor(item.day, theme).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item.day.substring(0, 3).toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: _getDayColor(item.day, theme),
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
                                  Text(item.subject, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                                      SizedBox(width: 4.w),
                                      Text(item.time, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                      if (item.room != null) ...[
                                        SizedBox(width: 12.w),
                                        Icon(Icons.meeting_room, size: 14.sp, color: Colors.grey),
                                        SizedBox(width: 4.w),
                                        Text(item.room!, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                      ],
                                    ],
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
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<TimetableCubit>().loadTimetable(),
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

  Color _getDayColor(String day, ThemeData theme) {
    switch (day.toLowerCase()) {
      case 'monday': return Colors.blue;
      case 'tuesday': return Colors.green;
      case 'wednesday': return Colors.orange;
      case 'thursday': return Colors.purple;
      case 'friday': return Colors.teal;
      case 'saturday': return Colors.brown;
      case 'sunday': return Colors.red;
      default: return theme.colorScheme.primary;
    }
  }
}
