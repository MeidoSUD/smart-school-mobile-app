import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsProfileScreen extends ConsumerWidget {
  const LmsProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(lmsAuthProvider);
    final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: user?.photo != null
                  ? NetworkImage(user!.photo!)
                  : null,
              child: user?.photo == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              user?.fullName ?? 'Student',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(user?.role ?? ''),
            const SizedBox(height: 24),
            _ProfileItem('Email', user?.email ?? '-'),
            _ProfileItem('Phone', user?.phone ?? '-'),
            _ProfileItem('Gender', user?.gender ?? '-'),
            _ProfileItem('Nationality', user?.nationality ?? '-'),
            _ProfileItem('Student ID', user?.studentId ?? '-'),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String label;
  final String value;

  const _ProfileItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}