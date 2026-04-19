import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';

class LessonManageWidget extends StatelessWidget {
  final String subject; // ex رياضيات

  final String level; // ex المرحلة الابتدائية
  final String subjectClass; // ex الصف الخامس
  final String lessonType; // ex single or group
  final int studentCount; // ex 2

  final DateTime time; // ex 4pm , 7am ...
  final double progress; // 20%
  final double price; // 20 SAR

  const LessonManageWidget({
    super.key,

    required this.subject,
    required this.level,
    required this.subjectClass,
    required this.lessonType,

    required this.time,
    required this.studentCount,
    required this.price,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final normalizedProgress = progress.round();
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,

      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: progress < 0.50
              ? theme.primaryColor
              : progress < 0.75
              ? const Color.fromARGB(255, 216, 122, 14)
              : Colors.green,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorDark,
                  fontSize: 20,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: progress > 0 ? Colors.orange[100] : Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  progress > 0
                      ? AppLocalizations.of(context)!.statusInProgress
                      : AppLocalizations.of(context)!.statusNew,
                  style: TextStyle(
                    color: progress > 0 ? Colors.orange : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Teacher & Level

          // Class & Lesson type
          Row(
            children: [
              Icon(Icons.class_, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(subjectClass, style: TextStyle(color: Colors.grey[700])),
              const SizedBox(width: 12),
              Icon(
                lessonType.toLowerCase() == "group"
                    ? Icons.group
                    : Icons.person,
                size: 16,
                color: theme.primaryColorDark,
              ),
              const SizedBox(width: 4),
              Text(
                lessonType.toLowerCase() == "group"
                    ? AppLocalizations.of(context)!.groupLessons
                    : AppLocalizations.of(context)!.individualLessons,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Days & Times
          Text(
            "${AppLocalizations.of(context)!.timeLabel}${DateFormat('HH:mm').format(time)}",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 6),

          // Students & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$studentCount ${AppLocalizations.of(context)!.studentCountLabel}",
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
              Text(
                "${price.toStringAsFixed(0)} ${AppLocalizations.of(context)!.perHourLabel}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Progress Bar
          Row(
            children: [
              // Progress Bar
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(6),
                    value: progress, // convert to 0.0–1.0
                    color: progress < 0.50
                        ? theme.primaryColor
                        : progress < 0.75
                        ? const Color.fromARGB(255, 216, 122, 14)
                        : Colors.green,
                    backgroundColor: Colors.grey[200],
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Percentage Text
              Text(
                "${(progress * 100).toStringAsFixed(0)}%", // show 55 -> 55%
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
