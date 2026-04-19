import 'package:geniuses_school/core/routes/app_routes.dart';
import 'package:geniuses_school/data/models/course_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/courses_provider.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoursesManageScreen extends ConsumerStatefulWidget {
  const CoursesManageScreen({super.key});

  @override
  ConsumerState<CoursesManageScreen> createState() =>
      _CoursesManageScreenState();
}

class _CoursesManageScreenState extends ConsumerState<CoursesManageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(coursesProvider.notifier).loadMyCourses();
    });
  }

  Future<void> _onRefresh() async {
    await ref.read(coursesProvider.notifier).loadMyCourses();
  }

  void _addCourse() {
    Navigator.pushNamed(context, AppRoutes.addCourse);
  }

  void _onEdit(Course course) {
    Navigator.pushNamed(context, AppRoutes.editCourse, arguments: course);
  }

  void _onDelete(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirmDelete),
        content: Text(AppLocalizations.of(context)!.confirmDeleteCourse),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              AppLocalizations.of(context)!.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(coursesProvider.notifier).deleteCourse(id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.courseDeletedSuccess),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${AppLocalizations.of(context)!.errorPrefix}$e"),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coursesAsync = ref.watch(coursesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.manageCourses),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          const BallsWidget(
            size: 40,
            color: Color(0xFF5170ff),
            alignment: Alignment(1.1, -0.8),
            opacity: 0.9,
          ),
          const BallsWidget(
            size: 100,
            color: Color(0xFF5170ff),
            alignment: Alignment(-1.3, 1),
            opacity: 0.9,
          ),
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: coursesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${AppLocalizations.of(context)!.errorPrefix}$error"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _onRefresh,
                      child: Text(AppLocalizations.of(context)!.refresh),
                    ),
                  ],
                ),
              ),
              data: (courses) {
                if (courses.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.noCoursesAvailable,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    return CourseCard(
                      course: course,
                      onDelete: () => _onDelete(course.id),
                      onEdit: (updated) => _onEdit(course),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        onPressed: _addCourse,
        label: Text(AppLocalizations.of(context)!.addCourse),
      ),
    );
  }
}
