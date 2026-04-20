import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsVisitorsScreen extends ConsumerWidget {
  const LmsVisitorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitorsAsync = ref.watch(lmsVisitorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitors'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: visitorsAsync.when(
        data: (visitors) {
          if (visitors.isEmpty) {
            return const Center(child: Text('No visitors'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: visitors.length,
            itemBuilder: (context, index) {
              final visitor = visitors[index];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(visitor.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(visitor.reason ?? ''),
                      Text('Date: ${visitor.visitDate ?? "-"}'),
                    ],
                  ),
                  trailing: Text(visitor.phone ?? ''),
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