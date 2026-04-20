import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsExamsScreen extends ConsumerWidget {
  const LmsExamsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examScheduleAsync = ref.watch(lmsExamScheduleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Schedule'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: examScheduleAsync.when(
        data: (exams) {
          if (exams.isEmpty) {
            return const Center(child: Text('No upcoming exams'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              return Card(
                child: ListTile(
                  title: Text(exam.subject),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${exam.date ?? "-"}'),
                      Text('Time: ${exam.time ?? "-"}'),
                      Text('Room: ${exam.room ?? "-"}'),
                    ],
                  ),
                  isThreeLine: true,
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