import 'package:geniuses_school/data/models/session_model.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';

class SessionUserSection extends StatelessWidget {
  final StudentSession session;
  final bool
  isTeacherViewer; // If true, viewer is teacher, so show Student. Else show Teacher.

  const SessionUserSection({
    super.key,
    required this.session,
    required this.isTeacherViewer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userToShow = isTeacherViewer ? session.student : session.teacher;
    final title = isTeacherViewer
        ? AppLocalizations.of(context)!.studentInfoLabel
        : AppLocalizations.of(context)!.teacherInfoLabel;
    final iconData = isTeacherViewer ? Icons.school : Icons.person_pin;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          userToShow != null
              ? Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50], // Match card style
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.primaryColor.withOpacity(0.2),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            iconData,
                            color: theme.primaryColor,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userToShow.name ??
                                  AppLocalizations.of(context)!.unknown,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            if (userToShow.email != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                userToShow.email!,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Text(AppLocalizations.of(context)!.noData),
        ],
      ),
    );
  }
}
