import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsAttendanceScreen extends ConsumerWidget {
  const LmsAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(
      lmsAttendanceProvider({'start': null, 'end': null}),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: attendanceAsync.when(
        data: (attendance) {
          if (attendance.isEmpty) {
            return const Center(child: Text('No attendance records'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: attendance.length,
            itemBuilder: (context, index) {
              final record = attendance[index];
              return Card(
                child: ListTile(
                  leading: Icon(
                    record.status == 'Present'
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: record.status == 'Present'
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text(record.date),
                  subtitle: Text(record.remark ?? ''),
                  trailing: Text(record.status),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}