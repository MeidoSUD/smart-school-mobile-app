import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsTimetableScreen extends ConsumerWidget {
  const LmsTimetableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timetableAsync = ref.watch(lmsTimetableProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: timetableAsync.when(
        data: (timetable) {
          if (timetable.isEmpty) {
            return const Center(child: Text('No timetable'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: timetable.length,
            itemBuilder: (context, index) {
              final t = timetable[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.schedule),
                  title: Text(t.subject),
                  subtitle: Text('${t.day} - ${t.time}'),
                  trailing: Text(t.room ?? ''),
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