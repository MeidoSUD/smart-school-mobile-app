import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../bloc/admission_cubit.dart';
import '../bloc/admission_state.dart';

class AdmissionScreen extends StatelessWidget {
  const AdmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<AdmissionCubit>()..loadStatus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.admission_title)),
        ),
        body: BlocBuilder<AdmissionCubit, AdmissionState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (status) {
                final appStatus = status['status'] as String? ?? '';
                final message = status['message'] as String? ?? '';
                final submittedDate = status['submittedDate'] as String? ?? '';
                return Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 32.h),
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: appStatus == 'approved' ? Colors.green.withValues(alpha: 0.1)
                              : appStatus == 'rejected' ? Colors.red.withValues(alpha: 0.1)
                              : Colors.orange.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          appStatus == 'approved' ? Icons.check_circle
                              : appStatus == 'rejected' ? Icons.cancel
                              : Icons.hourglass_empty,
                          size: 40.sp,
                          color: appStatus == 'approved' ? Colors.green
                              : appStatus == 'rejected' ? Colors.red
                              : Colors.orange,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        appStatus.toUpperCase(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: appStatus == 'approved' ? Colors.green
                              : appStatus == 'rejected' ? Colors.red
                              : Colors.orange,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
                      SizedBox(height: 24.h),
                      if (submittedDate.isNotEmpty)
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                          child: ListTile(
                            leading: Icon(Icons.date_range, color: theme.colorScheme.primary),
                            title: Text(context.tr(LocaleKeys.common_date)),
                            subtitle: Text(submittedDate),
                          ),
                        ),
                    ],
                  ),
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
