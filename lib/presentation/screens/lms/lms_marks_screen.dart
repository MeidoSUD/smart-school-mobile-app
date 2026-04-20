import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsMarksScreen extends ConsumerWidget {
  const LmsMarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marksAsync = ref.watch(lmsMarksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marks & Grades'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: marksAsync.when(
        data: (marks) {
          if (marks.isEmpty) {
            return const Center(child: Text('No marks records'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: marks.length,
            itemBuilder: (context, index) {
              final mark = marks[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mark.subject,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Marks: ${mark.marks ?? 0}/${mark.totalMarks ?? 100}'),
                          Text('Grade: ${mark.grade ?? "-"}'),
                        ],
                      ),
                    ],
                  ),
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