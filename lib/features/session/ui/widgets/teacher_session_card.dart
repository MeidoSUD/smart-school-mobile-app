import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_time_helper.dart';
import '../../../../data/models/session_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../controllers/session_provider.dart' hide SessionState;
import '../../utils/session_action_helper.dart';
import '../session_details_screen.dart';

class TeacherSessionCard extends ConsumerStatefulWidget {
  final StudentSession session;

  const TeacherSessionCard({super.key, required this.session});

  @override
  ConsumerState<TeacherSessionCard> createState() => _TeacherSessionCardState();
}

class _TeacherSessionCardState extends ConsumerState<TeacherSessionCard> {
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  Future<void> _handleStart() async {
    await SessionActionHelper.joinOrStartSession(
      context: context,
      ref: ref,
      session: widget.session,
      isLoadingNotifier: _isLoadingNotifier,
    );
    // Ensure UI update if needed, though button uses listener
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Use Helper for Formatting
    final date = DateTimeHelper.formatDate(context, session.sessionDate);
    final startTime = DateTimeHelper.formatTime(context, session.startTime);
    final endTime = DateTimeHelper.formatTime(context, session.endTime);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SessionDetailsScreen(session: session),
              ),
            );
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ProMeetingRoomScreen(
            //       data: MeetingRoomData.fromJson({
            //         "agora": {
            //           "channel": "session_15",
            //           "token":
            //               "007eJxTYJhytkp8wozjB0ouf0h6yPTTqmpm4TM+/6eBx12rBbVf2lxQYDBPM7NINLFMsTA2NTZJNje1NEwzMk42sUgzsTA0TTUyzcz3y2wIZGQQ8v7OxMgAgSA+F0NxanFxZn5evKEpAwMAaxghwQ==",
            //           "uid": "teacher_5",
            //           "role": "host",
            //           "expires_in": 3600,
            //         },
            //         "session_status": "live",
            //       }),
            //     ),
            //   ),
            // );
          },
          child: Column(
            children: [
              // Time Header with Gradient
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primaryColor,
                      theme.primaryColor.withOpacity(0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Force LTR for text direction to ensure 3:00 PM - 4:00 PM reads correctly
                    Text(
                      "$startTime - $endTime",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 13,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subject Name
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            session.subject?.nameAr ??
                                session.subject?.nameEn ??
                                session.sessionTitle ??
                                l10n.session,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        // Duration
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.access_time_filled,
                                size: 14,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                DateTimeHelper.getDuration(
                                  context,
                                  session.startTime,
                                  session.endTime,
                                ),
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: SessionStatus.fromString(
                              session.status,
                            ).color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            SessionStatus.fromString(
                              session.status,
                            ).localizedLabel(context),
                            style: TextStyle(
                              color: SessionStatus.fromString(
                                session.status,
                              ).color,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Student Info & Actions
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.blue.withOpacity(0.1),
                            child: Icon(
                              Icons.school,
                              size: 20,
                              color: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.student,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  session.student?.name ?? l10n.unknown,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          // Compact Status/Action
                          Builder(
                            builder: (context) {
                              final status = DateTimeHelper.getSessionStatus(
                                session.sessionDate,
                                session.startTime,
                                session.endTime,
                                startBufferMinutes: 15,
                              );

                              if (status == SessionState.finished) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 14,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        l10n.finished,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (status == SessionState.upcoming) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF4E5),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFFFFCC80),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.schedule,
                                        size: 14,
                                        color: Color(0xFFEF6C00),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        l10n.upcoming,
                                        style: TextStyle(
                                          color: Color(0xFFEF6C00),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // SessionState.live
                                return ValueListenableBuilder<bool>(
                                  valueListenable: _isLoadingNotifier,
                                  builder: (context, isLoading, child) {
                                    return ElevatedButton(
                                      onPressed: isLoading
                                          ? null
                                          : _handleStart,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 0,
                                        ),
                                        minimumSize: const Size(0, 32),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.start,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
