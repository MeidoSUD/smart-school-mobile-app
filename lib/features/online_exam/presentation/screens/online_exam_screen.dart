import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../bloc/online_exam_cubit.dart';
import '../bloc/online_exam_state.dart';

class OnlineExamScreen extends StatelessWidget {
  const OnlineExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<OnlineExamCubit>()..loadExam(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.online_exam_title)),
        ),
        body: BlocBuilder<OnlineExamCubit, OnlineExamState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (exams) {
                if (exams.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: exams.length,
                  itemBuilder: (context, index) {
                    final exam = exams[index];
                    final statusColor = exam.status == 'available'
                        ? Colors.green
                        : exam.status == 'upcoming' ? Colors.blue : Colors.grey;
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(exam.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    exam.status?.toUpperCase() ?? '',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                if (exam.subject != null) ...[
                                  Icon(Icons.book, size: 14.sp, color: Colors.grey),
                                  SizedBox(width: 4.w),
                                  Text(exam.subject!, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                  SizedBox(width: 16.w),
                                ],
                                Icon(Icons.timer_outlined, size: 14.sp, color: Colors.grey),
                                SizedBox(width: 4.w),
                                Text('${exam.duration ?? 0} min', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                SizedBox(width: 16.w),
                                Icon(Icons.quiz_outlined, size: 14.sp, color: Colors.grey),
                                SizedBox(width: 4.w),
                                Text('${exam.totalQuestions ?? 0} Q', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                              ],
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
