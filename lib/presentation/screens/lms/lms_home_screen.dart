import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/constants/app_constants.dart';
import 'package:geniuses_school/core/routes/app_routes.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsHomeScreen extends ConsumerWidget {
  const LmsHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(lmsAuthProvider);

    final menuItems = [
      _MenuItem('Dashboard', Icons.dashboard, AppRoutes.lmsDashboard),
      _MenuItem('Profile', Icons.person, AppRoutes.lmsProfile),
      _MenuItem('Fees', Icons.payment, AppRoutes.lmsFees),
      _MenuItem('Attendance', Icons.check_circle, AppRoutes.lmsAttendance),
      _MenuItem('Marks', Icons.grade, AppRoutes.lmsMarks),
      _MenuItem('Homework', Icons.assignment, AppRoutes.lmsHomework),
      _MenuItem('Timetable', Icons.schedule, AppRoutes.lmsTimetable),
      _MenuItem('Subjects', Icons.book, AppRoutes.lmsSubjects),
      _MenuItem('Syllabus', Icons.list_alt, AppRoutes.lmsSyllabus),
      _MenuItem('Teachers', Icons.school, AppRoutes.lmsTeachers),
      _MenuItem('Chat', Icons.chat, AppRoutes.lmsChat),
      _MenuItem('Library', Icons.library_books, AppRoutes.lmsLibrary),
      _MenuItem('Transport', Icons.directions_bus, AppRoutes.lmsTransport),
      _MenuItem('Exams', Icons.quiz, AppRoutes.lmsExams),
      _MenuItem('Online Exam', Icons.computer, AppRoutes.lmsOnlineExam),
      _MenuItem('Calendar', Icons.event, AppRoutes.lmsCalendar),
      _MenuItem('Hostel', Icons.hotel, AppRoutes.lmsHostel),
      _MenuItem('Visitors', Icons.people, AppRoutes.lmsVisitors),
      _MenuItem('Apply Leave', Icons.event_busy, AppRoutes.lmsLeave),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${authState.user?.fullName ?? "Student"}'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(lmsAuthProvider.notifier).logout(context);
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return _MenuCard(
            title: item.title,
            icon: item.icon,
            onTap: () {
              Navigator.pushNamed(context, item.route);
            },
          );
        },
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final String route;

  _MenuItem(this.title, this.icon, this.route);
}

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: AppConstants.primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}