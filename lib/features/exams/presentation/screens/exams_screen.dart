import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/exams_cubit.dart';
import '../../../../core/di/injection.dart';
import '../bloc/exams_state.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<ExamsCubit>()..loadExams(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.exams_title)),
        ),
        body: BlocBuilder<ExamsCubit, ExamsState>(
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
                    final item = exams[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Container(
                              width: 44.w, height: 44.w,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(Icons.assignment, color: theme.colorScheme.primary, size: 22.sp),
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
                                      Icon(Icons.date_range, size: 14.sp, color: Colors.grey),
                                      SizedBox(width: 4.w),
                                      Text(item.date ?? '', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                      SizedBox(width: 12.w),
                                      Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                                      SizedBox(width: 4.w),
                                      Text(item.time ?? '', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (item.room != null)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(item.room!, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
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
                      onPressed: () => context.read<ExamsCubit>().loadExams(),
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
