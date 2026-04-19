import 'package:geniuses_school/core/utils/date_time_helper.dart';
import 'package:geniuses_school/data/models/session_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/screens/classroom/classroom_screen.dart';
import 'package:geniuses_school/presentation/state/classroom_provider.dart';
import 'package:geniuses_school/presentation/widgets/session_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/lesson_details/lesson_header.dart';
import '../../widgets/lesson_details/lesson_info_section.dart';
import '../../widgets/lesson_details/lesson_join_button.dart';
import '../../widgets/lesson_details/lesson_student_section.dart';
import '../../widgets/lesson_details/lesson_time_section.dart';

class LessonDetailsScreen extends ConsumerStatefulWidget {
  final StudentSession session;
  final bool? isTeacher;
  final int? userId;
  final String? classroomId;
  const LessonDetailsScreen({
    required this.session,
    this.isTeacher,
    this.userId,
    this.classroomId,
    super.key,
  });

  @override
  ConsumerState<LessonDetailsScreen> createState() =>
      _LessonDetailsScreenState();
}

class _LessonDetailsScreenState extends ConsumerState<LessonDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isJoining = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isLessonTime() {
    // Teachers can always enter/start the room, regardless of time
    if (widget.isTeacher == true) return true;

    if (widget.session.startTime == null) return false;
    try {
      final now = TimeOfDay.now();
      final parts = widget.session.startTime!.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      // extensive check slightly loosely
      if (now.hour > hour) return true;
      if (now.hour == hour && now.minute >= minute) return true;
      return false;
    } catch (e) {
      return false;
    }
  }

  bool _isSessionCompleted() {
    // Use DateTimeHelper to check if session is finished
    final sessionState = DateTimeHelper.getSessionStatus(
      widget.session.sessionDate,
      widget.session.startTime,
      widget.session.endTime,
    );
    return sessionState == SessionState.finished;
  }

  void _joinLesson() {
    if (!_isLessonTime()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.lessonNotStarted),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    _handleJoinLesson();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 14)),
        backgroundColor: isError ? Colors.red[700] : Colors.green[700],
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
  }

  Future<void> _handleJoinLesson() async {
    if (_isJoining) return;

    setState(() => _isJoining = true);

    try {
      final classroomNotifier = ref.read(classroomProvider.notifier);

      if (widget.isTeacher == true) {
        // Teacher creates the classroom
        await classroomNotifier.createClassroom(session_id: widget.session.id!);

        final classroomState = ref.read(classroomProvider);

        if (classroomState.error != null) {
          _showSnackBar(
            AppLocalizations.of(
              context,
            )!.roomCreationFailed(classroomState.error!),
            isError: true,
          );
          setState(() => _isJoining = false);
          return;
        }

        // Navigate to classroom
        if (mounted) {
          await Permission.camera.request();
          await Permission.microphone.request();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ClassroomScreen(userId: widget.userId!, isTeacher: true),
            ),
          ).then((_) {
            // Reset state when returning from classroom
            setState(() => _isJoining = false);
          });
        }
      } else {
        // Student joins the classroom
        await classroomNotifier.joinClassroom(
          studentId: widget.userId!,
          classroomId: widget.classroomId!,
        );

        final classroomState = ref.read(classroomProvider);

        if (classroomState.error != null) {
          // Check if error is about classroom not started
          // Note: This relies on specific backend error strings.
          if (classroomState.error!.contains('not found') ||
              classroomState.error!.contains('not started') ||
              classroomState.error!.contains('لم يبدأ')) {
            _showSnackBar(
              AppLocalizations.of(context)!.lessonNotStartedRetry,
              isError: true,
            );
          } else {
            _showSnackBar(
              AppLocalizations.of(context)!.joinFailed(classroomState.error!),
              isError: true,
            );
          }
          setState(() => _isJoining = false);
          return;
        }

        // Navigate to classroom
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ClassroomScreen(userId: widget.userId!, isTeacher: false),
            ),
          ).then((_) {
            // Reset state when returning from classroom
            setState(() => _isJoining = false);
          });
        }
      }
    } catch (e) {
      _showSnackBar(
        AppLocalizations.of(context)!.errorTitle(e.toString()),
        isError: true,
      );
      setState(() => _isJoining = false);
    }
  }

  Future<void> _launchZoom(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.cannotOpenLink)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTimeAvailable = _isLessonTime();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            LessonHeader(
              session: widget.session,
              isTimeAvailable: isTimeAvailable,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LessonInfoSection(session: widget.session),
                      const SizedBox(height: 24),
                      LessonTimeSection(
                        session: widget.session,
                        isTimeAvailable: isTimeAvailable,
                      ),
                      const SizedBox(height: 24),
                      LessonStudentSection(session: widget.session),
                      const SizedBox(height: 24),

                      // Show review widget only for students and completed sessions
                      if ((widget.isTeacher == null || widget.isTeacher == false) && _isSessionCompleted() && widget.session.teacher?.id != null && widget.session.teacher!.id! > 0)
                        SessionReviewWidget(
                          sessionId: widget.session.id!,
                          teacherId: widget.session.teacher!.id!,
                          teacherName: widget.session.teacher?.name ?? 'المعلم',
                          onReviewAdded: () {
                            // Optionally refresh session data
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('شكراً لتقييمك!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        ),
                      
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: LessonJoinButton(
          isTimeAvailable: isTimeAvailable,
          isJoining: _isJoining,
          isTeacher: widget.isTeacher ?? false,
          onPressed: _handleJoinLesson,
        ),
      ),
    );
  }
}
