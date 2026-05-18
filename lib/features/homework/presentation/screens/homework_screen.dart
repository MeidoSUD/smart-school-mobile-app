import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/homework_cubit.dart';
import '../../../../core/di/injection.dart';
import '../bloc/homework_state.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<HomeworkCubit>()..loadHomework(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.homework_title)),
        ),
        body: BlocBuilder<HomeworkCubit, HomeworkState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (homework) {
                if (homework.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: homework.length,
                  itemBuilder: (context, index) {
                    final item = homework[index];
                    final isCompleted = item.status == 'completed';
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
                                color: (isCompleted ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                isCompleted ? Icons.check_circle : Icons.pending,
                                color: isCompleted ? Colors.green : Colors.orange,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      if (item.subject != null) ...[
                                        Icon(Icons.book, size: 14.sp, color: Colors.grey),
                                        SizedBox(width: 4.w),
                                        Text(item.subject!, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                        SizedBox(width: 12.w),
                                      ],
                                      if (item.dueDate != null) ...[
                                        Icon(Icons.date_range, size: 14.sp, color: Colors.grey),
                                        SizedBox(width: 4.w),
                                        Text(item.dueDate!, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: (isCompleted ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                context.tr(isCompleted ? LocaleKeys.homework_completed : LocaleKeys.homework_pending),
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isCompleted ? Colors.green : Colors.orange,
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
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<HomeworkCubit>().loadHomework(),
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
