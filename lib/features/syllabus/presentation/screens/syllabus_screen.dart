import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../bloc/syllabus_cubit.dart';
import '../bloc/syllabus_state.dart';

class SyllabusScreen extends StatelessWidget {
  const SyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<SyllabusCubit>()..loadSyllabus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.syllabus_title)),
        ),
        body: BlocBuilder<SyllabusCubit, SyllabusState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (syllabus) {
                if (syllabus.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: syllabus.length,
                  itemBuilder: (context, index) {
                    final s = syllabus[index];
                    final subject = s.subject;
                    final topic = s.topic ?? '';
                    final status = s.status ?? '';
                    final isCompleted = status == 'completed';
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Container(
                              width: 4.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: isCompleted ? Colors.green : Colors.orange,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(subject, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                  SizedBox(height: 4.h),
                                  Text(topic, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: (isCompleted ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                isCompleted ? context.tr(LocaleKeys.syllabus_completed) : context.tr(LocaleKeys.syllabus_pending),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: isCompleted ? Colors.green : Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
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
