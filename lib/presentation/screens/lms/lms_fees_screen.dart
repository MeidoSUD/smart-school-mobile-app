import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/theme/app_theme.dart';
import 'package:geniuses_school/presentation/widgets/common_widgets.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsBaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const LmsBaseScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

class LmsFeesScreen extends ConsumerWidget {
  const LmsFeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feesAsync = ref.watch(lmsFeesProvider);

    return LmsBaseScaffold(
      title: 'Fees',
      body: feesAsync.when(
        data: (fees) {
          if (fees.isEmpty) {
            return const AppEmpty(message: 'No fees records');
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: fees.length,
            itemBuilder: (context, index) {
              final fee = fees[index];
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fee.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${fee.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: fee.status == 'Paid'
                                ? AppColors.success.withValues(alpha: 0.1)
                                : AppColors.warning.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            fee.status ?? 'Pending',
                            style: TextStyle(
                              color: fee.status == 'Paid'
                                  ? AppColors.success
                                  : AppColors.warning,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: AppLoading()),
        error: (error, stack) => AppError(
          message: error.toString(),
          onRetry: () => ref.invalidate(lmsFeesProvider),
        ),
      ),
    );
  }
}

class LmsAttendanceScreen extends ConsumerWidget {
  const LmsAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(
      lmsAttendanceProvider({'start': null, 'end': null}),
    );

    return LmsBaseScaffold(
      title: 'Attendance',
      body: attendanceAsync.when(
        data: (attendance) {
          if (attendance.isEmpty) {
            return const AppEmpty(message: 'No attendance records');
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: attendance.length,
            itemBuilder: (context, index) {
              final record = attendance[index];
              final isPresent = record.status == 'Present';
              return AppCard(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isPresent
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isPresent ? Icons.check : Icons.close,
                        color: isPresent
                            ? AppColors.success
                            : AppColors.error,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            record.date,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (record.remark != null)
                            Text(
                              record.remark!,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      record.status,
                      style: TextStyle(
                        color: isPresent
                            ? AppColors.success
                            : AppColors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: AppLoading()),
        error: (error, stack) => AppError(
          message: error.toString(),
          onRetry: () => ref.invalidate(
            lmsAttendanceProvider({'start': null, 'end': null}),
          ),
        ),
      ),
    );
  }
}

class LmsMarksScreen extends ConsumerWidget {
  const LmsMarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marksAsync = ref.watch(lmsMarksProvider);

    return LmsBaseScaffold(
      title: 'Marks & Grades',
      body: marksAsync.when(
        data: (marks) {
          if (marks.isEmpty) {
            return const AppEmpty(message: 'No marks records');
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: marks.length,
            itemBuilder: (context, index) {
              final mark = marks[index];
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mark.subject,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Marks'),
                        Text(
                          '${mark.marks ?? 0}/${mark.totalMarks ?? 100}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        if (mark.grade != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              mark.grade!,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: AppLoading()),
        error: (error, stack) => AppError(
          message: error.toString(),
          onRetry: () => ref.invalidate(lmsMarksProvider),
        ),
      ),
    );
  }
}