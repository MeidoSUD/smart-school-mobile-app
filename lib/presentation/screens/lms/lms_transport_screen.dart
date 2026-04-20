import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsTransportScreen extends ConsumerWidget {
  const LmsTransportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transportAsync = ref.watch(lmsTransportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: transportAsync.when(
        data: (transport) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Route',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transport.route),
                      const SizedBox(height: 16),
                      _InfoRow('Driver', transport.driverName ?? '-'),
                      _InfoRow('Phone', transport.driverPhone ?? '-'),
                      _InfoRow('Bus Number', transport.busNumber ?? '-'),
                      _InfoRow('Pickup Time', transport.pickupTime ?? '-'),
                      _InfoRow('Pickup Point', transport.pickupPoint ?? '-'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}