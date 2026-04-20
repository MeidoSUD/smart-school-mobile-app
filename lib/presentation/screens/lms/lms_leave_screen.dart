import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsLeaveScreen extends ConsumerWidget {
  const LmsLeaveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaveAsync = ref.watch(lmsLeaveProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Leave'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: leaveAsync.when(
        data: (leaves) {
          if (leaves.isEmpty) {
            return const Center(child: Text('No leave applications'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: leaves.length,
            itemBuilder: (context, index) {
              final leave = leaves[index];
              return Card(
                child: ListTile(
                  title: Text('${leave.fromDate} - ${leave.toDate}'),
                  subtitle: Text(leave.reason ?? ''),
                  trailing: Chip(
                    label: Text(
                      leave.status,
                      style: TextStyle(
                        color: leave.status == 'Approved'
                            ? Colors.green
                            : leave.status == 'Rejected'
                                ? Colors.red
                                : Colors.orange,
                      ),
                    ),
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