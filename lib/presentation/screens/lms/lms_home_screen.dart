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
      _MenuItem('Dashboard', AppConstants.logo, AppRoutes.lmsDashboard),
      _MenuItem('Profile', AppConstants.profileIcon, AppRoutes.lmsProfile),
      _MenuItem('Fees', AppConstants.feesIcon, AppRoutes.lmsFees),
      _MenuItem('Attendance', AppConstants.attendanceIcon, AppRoutes.lmsAttendance),
      _MenuItem('Marks', AppConstants.marksIcon, AppRoutes.lmsMarks),
      _MenuItem('Homework', AppConstants.homeworkIcon, AppRoutes.lmsHomework),
      _MenuItem('Timetable', AppConstants.timetableIcon, AppRoutes.lmsTimetable),
      _MenuItem('Subjects', AppConstants.subjectsIcon, AppRoutes.lmsSubjects),
      _MenuItem('Syllabus', AppConstants.syllabusIcon, AppRoutes.lmsSyllabus),
      _MenuItem('Teachers', AppConstants.teachersIcon, AppRoutes.lmsTeachers),
      _MenuItem('Chat', AppConstants.chatIcon, AppRoutes.lmsChat),
      _MenuItem('Library', AppConstants.libraryIcon, AppRoutes.lmsLibrary),
      _MenuItem('Transport', AppConstants.transportIcon, AppRoutes.lmsTransport),
      _MenuItem('Exams', AppConstants.examsIcon, AppRoutes.lmsExams),
      _MenuItem('Online Exam', AppConstants.onlineExamIcon, AppRoutes.lmsOnlineExam),
      _MenuItem('Calendar', AppConstants.calendarIcon, AppRoutes.lmsCalendar),
      _MenuItem('Hostel', AppConstants.hostelIcon, AppRoutes.lmsHostel),
      _MenuItem('Visitors', AppConstants.visitorsIcon, AppRoutes.lmsVisitors),
      _MenuItem('Apply Leave', AppConstants.leaveIcon, AppRoutes.lmsLeave),
    ];

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(authState.user?.fullName ?? "Student"),
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
          childAspectRatio: 0.85,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return _MenuCard(
            title: item.title,
            imagePath: item.imagePath,
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
  final String imagePath;
  final String route;

  _MenuItem(this.title, this.imagePath, this.route);
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppConstants.primaryColor.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.white.withValues(alpha: 0.9),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 30,
                      color: AppConstants.primaryColor,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppConstants.textColor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}