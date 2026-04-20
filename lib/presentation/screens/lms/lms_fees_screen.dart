import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsFeesScreen extends ConsumerWidget {
  const LmsFeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feesAsync = ref.watch(lmsFeesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fees'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: feesAsync.when(
        data: (fees) {
          if (fees.isEmpty) {
            return const Center(child: Text('No fees records'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: fees.length,
            itemBuilder: (context, index) {
              final fee = fees[index];
              return Card(
                child: ListTile(
                  title: Text(fee.title),
                  subtitle: Text(fee.description ?? ''),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${fee.amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        fee.status ?? 'Pending',
                        style: TextStyle(
                          color: fee.status == 'Paid'
                              ? Colors.green
                              : Colors.orange,
                          fontSize: 12,
                        ),
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