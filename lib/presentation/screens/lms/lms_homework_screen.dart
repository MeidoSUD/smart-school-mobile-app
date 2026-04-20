import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsHomeworkScreen extends ConsumerWidget {
  const LmsHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeworkAsync = ref.watch(lmsHomeworkProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: homeworkAsync.when(
        data: (homework) {
          if (homework.isEmpty) {
            return const Center(child: Text('No homework'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: homework.length,
            itemBuilder: (context, index) {
              final hw = homework[index];
              return Card(
                child: ListTile(
                  title: Text(hw.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hw.subject ?? ''),
                      Text('Due: ${hw.dueDate ?? "Not set"}'),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: hw.status == 'Submitted'
                          ? Colors.green
                          : Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      hw.status ?? 'Pending',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
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