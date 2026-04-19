import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/session_model.dart';
import '../../../../presentation/state/auth_provider.dart';
import '../../../../presentation/widgets/session_review_widget.dart';
import '../../../core/utils/date_time_helper.dart';
import '../utils/session_action_helper.dart'; // Import Helper
import 'widgets/details/session_details_header.dart';
import 'widgets/details/session_info_section.dart';
import 'widgets/details/session_join_action.dart';
import 'widgets/details/session_user_section.dart';

class SessionDetailsScreen extends ConsumerStatefulWidget {
  final StudentSession session;

  const SessionDetailsScreen({super.key, required this.session});

  @override
  ConsumerState<SessionDetailsScreen> createState() =>
      _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends ConsumerState<SessionDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  // Use ValueNotifier for compatibility with helper and efficient rebuilds if needed
  final ValueNotifier<bool> _isJoiningNotifier = ValueNotifier(false);

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
    _isJoiningNotifier.dispose();
    super.dispose();
  }

  Future<void> _handleJoin() async {
    await SessionActionHelper.joinOrStartSession(
      context: context,
      ref: ref,
      session: widget.session,
      isLoadingNotifier: _isJoiningNotifier,
    );
    if (mounted) setState(() {});
  }

  Future<void> _handleEndSession() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.endSession),
        content: Text(AppLocalizations.of(context)!.endSessionConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.confirm),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await SessionActionHelper.endSession(
        context: context,
        ref: ref,
        session: widget.session,
        isLoadingNotifier: _isJoiningNotifier,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine isTeacher for UI purposes
    final authState = ref.watch(authProvider);
    final userRoleId = authState.user?.role_id ?? 4;
    final isTeacher = userRoleId == 3;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.sessionDetails,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SessionDetailsHeader(session: widget.session),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SessionInfoSection(session: widget.session),
                          // const SizedBox(height: 16),
                          // SessionTimeSection(session: widget.session),
                          const SizedBox(height: 16),
                          SessionUserSection(
                            session: widget.session,
                            isTeacherViewer: isTeacher,
                          ),
                          if (widget.session.status?.toLowerCase() ==
                              'completed') ...[
                            const SizedBox(height: 16),
                            SessionReviewWidget(
                              sessionId: widget.session.id ?? 0,
                              teacherId: widget.session.teacher?.id ?? 0,
                              teacherName: widget.session.teacher?.name ?? "",
                              onReviewAdded: () {
                                if (mounted) setState(() {});
                              },
                            ),
                          ],
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder<bool>(
          valueListenable: _isJoiningNotifier,
          builder: (context, isJoining, child) {
            return SessionJoinAction(
              sessionState: DateTimeHelper.getSessionStatus(
                widget.session.sessionDate,
                widget.session.startTime,
                widget.session.endTime,
              ),
              isJoining: isJoining,
              isTeacher: isTeacher,
              onPressed: _handleJoin,
              onEndPressed: _handleEndSession,
            );
          },
        ),
      ),
    );
  }
}
