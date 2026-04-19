import 'package:geniuses_school/core/utils/date_time_helper.dart';
import 'package:geniuses_school/data/models/session_model.dart';
import 'package:geniuses_school/features/session/controllers/session_provider.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SessionInfoSection extends StatelessWidget {
  final StudentSession session;

  const SessionInfoSection({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final status = SessionStatus.fromString(session.status);
    final duration = DateTimeHelper.getDuration(
      context,
      session.startTime,
      session.endTime,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            l10n.sessionDetailsTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                icon: Icons.info_outline_rounded,
                title: l10n.sessionStatusLabel,
                value: status.localizedLabel(context),
                color: status.color,
                theme: theme,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildInfoCard(
                icon: Icons.timer_outlined,
                title: l10n.sessionDurationLabel,
                value: duration.isNotEmpty ? duration : l10n.minutesPlaceholder,
                color: theme.primaryColor,
                theme: theme,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                icon: Icons.category_rounded,
                title: l10n.bookingTypeLabel,
                value: session.booking?.type ?? l10n.unspecified,
                color: Colors.orange,
                theme: theme,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildInfoCard(
                icon: Icons.pie_chart_rounded,
                title: l10n.completedLabel,
                color: Colors.purple,
                value: "",
                theme: theme,
                valueWidget: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    "${session.booking?.completedSessions ?? 0} / ${session.booking?.totalSessions ?? 0}",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                icon: Icons.confirmation_number_rounded,
                title: l10n.referenceNumberLabel,
                value: "#${session.booking?.reference ?? '-'}",
                color: Colors.teal,
                theme: theme,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required ThemeData theme,
    Widget? valueWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                valueWidget ??
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
