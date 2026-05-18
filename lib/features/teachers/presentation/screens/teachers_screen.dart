import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../bloc/teachers_cubit.dart';
import '../bloc/teachers_state.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<TeachersCubit>()..loadTeachers(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.teachers_title)),
        ),
        body: BlocBuilder<TeachersCubit, TeachersState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (teachers) {
                if (teachers.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    final t = teachers[index];
                    final name = t.name;
                    final subject = t.subject ?? '';
                    final phone = t.phone ?? '';
                    final rating = t.rating;
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                              child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?',
                                  style: TextStyle(color: theme.colorScheme.primary, fontSize: 18.sp, fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                  SizedBox(height: 2.h),
                                  Text(subject, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                                  Text(phone, style: TextStyle(fontSize: 11.sp, color: Colors.grey[500])),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 18.sp),
                                SizedBox(width: 4.w),
                                Text(rating.toStringAsFixed(1), style: TextStyle(fontWeight: FontWeight.w600)),
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
