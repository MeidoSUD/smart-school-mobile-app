import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/data/models/lms_models.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsDashboardScreen extends ConsumerWidget {
  const LmsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(lmsDashboardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: dashboardAsync.when(
        data: (dashboard) => _DashboardContent(dashboard: dashboard),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final DashboardModel dashboard;

  const _DashboardContent({required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: AppConstants.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Attendance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${dashboard.attendancePercentage}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Homework',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (dashboard.homeworkList.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No homework'),
              ),
            )
          else
            ...dashboard.homeworkList.map(
              (hw) => Card(
                child: ListTile(
                  title: Text(hw.title),
                  subtitle: Text(hw.subject ?? ''),
                  trailing: Text(hw.status ?? ''),
                ),
              ),
            ),
          const SizedBox(height: 24),
          const Text(
            'Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (dashboard.notificationList.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No notifications'),
              ),
            )
          else
            ...dashboard.notificationList.map(
              (n) => Card(
                child: ListTile(
                  title: Text(n.title),
                  subtitle: Text(n.message ?? ''),
                ),
              ),
            ),
          const SizedBox(height: 24),
          const Text(
            'Teachers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (dashboard.teacherList.isEmpty)
            const Text('No teachers')
          else
            ...dashboard.teacherList.map(
              (t) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(t.name),
                subtitle: Text(t.subject ?? ''),
              ),
            ),
        ],
      ),
    );
  }
}