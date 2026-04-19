import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/state/lessons_provider.dart';
import 'package:geniuses_school/presentation/widgets/lessons/lesson_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Reusable Lesson Card Widget
class LessonCard extends StatelessWidget {
  final String time;
  final String subject;
  final String level;
  final String subjectClass;
  final String lessonType;
  final int studentCount;
  final double progress;
  final String price;
  final String studentName;
  final VoidCallback? onTap;
  final bool showActions;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;
  final double? width;

  const LessonCard({
    super.key,
    required this.time,
    required this.subject,
    required this.level,
    required this.subjectClass,
    required this.lessonType,
    required this.studentCount,
    required this.progress,
    required this.price,
    required this.studentName,
    this.onTap,
    this.showActions = false,
    this.onEdit,
    this.onCancel,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildTimeHeader(context, theme),
            _buildLessonContent(context, theme),
            if (showActions) _buildActionButtons(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeHeader(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.8)],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  lessonType == AppLocalizations.of(context)!.online
                      ? Icons.videocam
                      : Icons.location_on,
                  color: Colors.white,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  lessonType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonContent(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$level - $subjectClass",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "$price ${AppLocalizations.of(context)!.sar}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text(
                studentName,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.group, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text(
                "$studentCount ${AppLocalizations.of(context)!.student}",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.progress,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress > 0.7
                            ? Colors.green
                            : progress > 0.4
                            ? Colors.orange
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, size: 16),
              label: Text(AppLocalizations.of(context)!.edit),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.primaryColor,
                side: BorderSide(color: theme.primaryColor.withOpacity(0.5)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onCancel,
              icon: const Icon(Icons.cancel, size: 16),
              label: Text(AppLocalizations.of(context)!.cancel),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red.withOpacity(0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example Home Screen with Today's Lessons
class MyLessonsScreen extends ConsumerWidget {
  const MyLessonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.myLessons,
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          user!.role_id == 4
              ? Container()
              : _buildWelcomeHeader(context, theme),
          user.role_id == 4 ? Container() : _buildTodayStats(theme),
          _buildLessonsSection(context, theme),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.yMMMMEEEEd(
              AppLocalizations.of(context)!.localeName,
            ).format(DateTime.now()),
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayStats(ThemeData theme) {
    return Consumer(
      builder: (context, ref, _) {
        final lessonsState = ref.watch(lessonsProvider);

        return lessonsState.when(
          data: (response) {
            final lessons = response.data?.data ?? [];
            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    icon: Icons.schedule,
                    label: AppLocalizations.of(context)!.todaysLessons,
                    value: lessons.length.toString(),
                    color: theme.primaryColor,
                  ),
                  Container(width: 1, height: 40, color: Colors.grey[300]),
                  _buildStatItem(
                    icon: Icons.group,
                    label: AppLocalizations.of(context)!.students,
                    value: lessons
                        .where((s) => s.student != null)
                        .length
                        .toString(),
                    color: Colors.orange,
                  ),
                  Container(width: 1, height: 40, color: Colors.grey[300]),
                  _buildStatItem(
                    icon: Icons.attach_money,
                    label: AppLocalizations.of(context)!.expectedIncome,
                    value:
                        "0 ${AppLocalizations.of(context)!.sar}", // Price not available in StudentSession
                    color: Colors.green,
                  ),
                ],
              ),
            );
          },
          error: (err, stack) =>
              Text(AppLocalizations.of(context)!.errorLabel(err.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildLessonsSection(BuildContext context, ThemeData theme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final lessonsState = ref.watch(lessonsProvider);
                final authState = ref.watch(authProvider);

                return lessonsState.when(
                  data: (response) {
                    final lessons = response.data?.data ?? [];

                    if (lessons.isEmpty) {
                      return _buildEmptyState(context);
                    }

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: LessonCardWidget(
                            session: lessons[index],
                            isTeacher: authState.user!.role_id == 3,
                            userId: authState.user!.id,
                            width: MediaQuery.of(context).size.width * 0.9,
                          ),
                        );
                      },
                    );
                  },
                  error: (err, stack) => Center(
                    child: Text(
                      AppLocalizations.of(context)!.errorLabel(err.toString()),
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.event_available,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.noLessonsToday,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.enjoyYourDay,
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}
