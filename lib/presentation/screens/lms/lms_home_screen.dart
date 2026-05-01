import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geniuses_school/core/theme/app_theme.dart';
import 'package:geniuses_school/core/routes/app_routes.dart';
import 'package:geniuses_school/presentation/state/lms_auth_provider.dart';

class LmsHomeScreen extends ConsumerWidget {
  const LmsHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(lmsAuthProvider);

    final menuItems = [
      _MenuItem('Dashboard', AppRoutes.lmsDashboard),
      _MenuItem('Profile', AppRoutes.lmsProfile),
      _MenuItem('Fees', AppRoutes.lmsFees),
      _MenuItem('Attendance', AppRoutes.lmsAttendance),
      _MenuItem('Marks', AppRoutes.lmsMarks),
      _MenuItem('Homework', AppRoutes.lmsHomework),
      _MenuItem('Timetable', AppRoutes.lmsTimetable),
      _MenuItem('Subjects', AppRoutes.lmsSubjects),
      _MenuItem('Syllabus', AppRoutes.lmsSyllabus),
      _MenuItem('Teachers', AppRoutes.lmsTeachers),
      _MenuItem('Chat', AppRoutes.lmsChat),
      _MenuItem('Library', AppRoutes.lmsLibrary),
      _MenuItem('Transport', AppRoutes.lmsTransport),
      _MenuItem('Exams', AppRoutes.lmsExams),
      _MenuItem('Online Exam', AppRoutes.lmsOnlineExam),
      _MenuItem('Calendar', AppRoutes.lmsCalendar),
      _MenuItem('Hostel', AppRoutes.lmsHostel),
      _MenuItem('Visitors', AppRoutes.lmsVisitors),
      _MenuItem('Apply Leave', AppRoutes.lmsLeave),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(authState.user?.fullName ?? 'Student'),
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
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return _MenuCard(
            title: item.title,
            index: index,
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
  final String route;

  _MenuItem(this.title, this.route);
}

class _MenuCard extends StatefulWidget {
  final String title;
  final int index;
  final VoidCallback onTap;

  const _MenuCard({
    required this.title,
    required this.index,
    required this.onTap,
  });

  @override
  State<_MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<_MenuCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getIcon() {
    final icons = [
      Icons.dashboard,
      Icons.person,
      Icons.payment,
      Icons.check_circle,
      Icons.grade,
      Icons.assignment,
      Icons.schedule,
      Icons.book,
      Icons.list_alt,
      Icons.school,
      Icons.chat,
      Icons.library_books,
      Icons.directions_bus,
      Icons.quiz,
      Icons.computer,
      Icons.event,
      Icons.hotel,
      Icons.people,
      Icons.event_busy,
    ];
    return icons[widget.index % icons.length];
  }

  Color _getColor() {
    final colors = [
      AppColors.primary,
      AppColors.accent,
      AppColors.success,
      AppColors.primary,
      AppColors.accent,
      AppColors.success,
      AppColors.primary,
      AppColors.accent,
      AppColors.success,
      AppColors.primary,
      AppColors.accent,
      AppColors.success,
      AppColors.primary,
      AppColors.accent,
      AppColors.success,
      AppColors.primary,
      AppColors.accent,
      AppColors.success,
    ];
    return colors[widget.index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Card(
          elevation: 2,
          shadowColor: _getColor().withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white.withValues(alpha: 0.95),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: _getColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIcon(),
                    size: 28,
                    color: _getColor(),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
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
      ),
    );
  }
}