import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/fees_cubit.dart';
import '../../../../core/di/injection.dart';
import '../bloc/fees_state.dart';

class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<FeesCubit>()..loadFees(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.fees_title)),
        ),
        body: BlocBuilder<FeesCubit, FeesState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (fees) {
                if (fees.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                final totalPending = fees.where((f) => f.status != 'paid').fold<double>(
                  0, (sum, f) => sum + f.amount,
                );
                return ListView(
                  padding: EdgeInsets.all(16.w),
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.8)],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr(LocaleKeys.fees_amount_due),
                            style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '\$${totalPending.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ...fees.map((fee) => Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: (fee.status == 'paid' ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                fee.status == 'paid' ? Icons.check_circle : Icons.pending,
                                color: fee.status == 'paid' ? Colors.green : Colors.orange,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(fee.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${context.tr(LocaleKeys.fees_due_date)}: ${fee.dueDate ?? 'N/A'}',
                                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${fee.amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: fee.status == 'paid' ? Colors.green : Colors.orange,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: (fee.status == 'paid' ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    fee.status?.toUpperCase() ?? context.tr(LocaleKeys.fees_pending).toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: fee.status == 'paid' ? Colors.green : Colors.orange,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                );
              },
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<FeesCubit>().loadFees(),
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
