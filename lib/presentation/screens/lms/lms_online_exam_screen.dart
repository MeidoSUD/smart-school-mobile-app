import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsOnlineExamScreen extends ConsumerWidget {
  const LmsOnlineExamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(lmsOnlineExamsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Exams'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: examsAsync.when(
        data: (exams) {
          if (exams.isEmpty) {
            return const Center(child: Text('No online exams'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              return Card(
                child: ListTile(
                  title: Text(exam.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Subject: ${exam.subject ?? "-"}'),
                      Text('Duration: ${exam.duration ?? 0} min'),
                      Text('Questions: ${exam.totalQuestions ?? 0}'),
                    ],
                  ),
                  trailing: Chip(label: Text(exam.status ?? '')),
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