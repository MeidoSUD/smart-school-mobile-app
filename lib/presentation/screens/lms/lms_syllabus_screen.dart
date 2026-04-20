import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsSyllabusScreen extends ConsumerWidget {
  const LmsSyllabusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syllabusAsync = ref.watch(lmsSyllabusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syllabus'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: syllabusAsync.when(
        data: (syllabus) {
          if (syllabus.isEmpty) {
            return const Center(child: Text('No syllabus'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: syllabus.length,
            itemBuilder: (context, index) {
              final s = syllabus[index];
              return Card(
                child: ListTile(
                  title: Text(s.subject),
                  subtitle: Text(s.topic ?? ''),
                  trailing: Chip(label: Text(s.status ?? '')),
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