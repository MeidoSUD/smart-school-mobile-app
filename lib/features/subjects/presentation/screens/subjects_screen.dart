import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/subjects_cubit.dart';
import '../../../../core/di/injection.dart';
import '../bloc/subjects_state.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<SubjectsCubit>()..loadSubjects(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.subjects_title)),
        ),
        body: BlocBuilder<SubjectsCubit, SubjectsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (subjects) {
                if (subjects.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final item = subjects[index];
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
                              child: Icon(Icons.book, color: theme.colorScheme.primary, size: 22.sp),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      if (item.code != null)
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius: BorderRadius.circular(6.r),
                                          ),
                                          child: Text(item.code!, style: TextStyle(fontSize: 11.sp, color: Colors.grey[700])),
                                        ),
                                      if (item.teacher != null) ...[
                                        SizedBox(width: 8.w),
                                        Icon(Icons.person, size: 14.sp, color: Colors.grey),
                                        SizedBox(width: 4.w),
                                        Text(item.teacher!, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
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
                      onPressed: () => context.read<SubjectsCubit>().loadSubjects(),
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
