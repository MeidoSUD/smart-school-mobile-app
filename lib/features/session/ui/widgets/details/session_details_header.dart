import 'package:geniuses_school/core/utils/date_time_helper.dart';
import 'package:geniuses_school/data/models/session_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SessionDetailsHeader extends StatelessWidget {
  final StudentSession session;

  const SessionDetailsHeader({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final status = DateTimeHelper.getSessionStatus(
      session.sessionDate,
      session.startTime,
      session.endTime,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (session.sessionTitle != null &&
                              session.sessionTitle!.isNotEmpty)
                          ? session.sessionTitle!
                          : l10n.untitledSession,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      session.subject?.nameAr ??
                          session.subject?.nameEn ??
                          l10n.unspecifiedSubject,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildStatusBadge(context, status),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildDateBadge(
                Icons.calendar_today_outlined,
                DateTimeHelper.formatDate(context, session.sessionDate),
                theme.primaryColor,
              ),
              const SizedBox(width: 12),
              _buildDateBadge(
                Icons.access_time_outlined,
                DateTimeHelper.formatTime(
                  context,
                  session.startTime,
                  dateString: session.sessionDate,
                ),
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, SessionState status) {
    final l10n = AppLocalizations.of(context)!;
    String text;
    Color color;
    Color bgColor;
    Color borderColor;
    IconData icon;

    switch (status) {
      case SessionState.live:
        text = l10n.statusLiveNow;
        color = Colors.red;
        bgColor = Colors.red.withOpacity(0.1);
        borderColor = Colors.red.withOpacity(0.2);
        icon = Icons.videocam;
        break;
      case SessionState.finished:
        text = l10n.statusFinished;
        color = Colors.grey[600]!;
        bgColor = Colors.grey[200]!;
        borderColor = Colors.transparent;
        icon = Icons.check_circle_outline;
        break;
      case SessionState.upcoming:
        text = l10n.statusUpcoming;
        color = const Color(0xFFEF6C00);
        bgColor = const Color(0xFFFFF4E5);
        borderColor = const Color(0xFFFFCC80);
        icon = Icons.schedule;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20), // Keep rounded
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateBadge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
