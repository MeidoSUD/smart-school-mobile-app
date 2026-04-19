import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LessonJoinButton extends StatelessWidget {
  final bool isTimeAvailable;
  final bool isJoining;
  final bool isTeacher;
  final VoidCallback? onPressed;

  const LessonJoinButton({
    super.key,
    required this.isTimeAvailable,
    required this.isJoining,
    required this.isTeacher,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: (isTimeAvailable && !isJoining) ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isTimeAvailable
                  ? theme.primaryColor
                  : Colors.grey[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: isTimeAvailable ? 8 : 0,
              disabledBackgroundColor: Colors.grey[400],
            ),
            icon: isJoining
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Icon(
                    isTimeAvailable ? Icons.videocam : Icons.schedule,
                    size: 20,
                  ),
            label: Text(
              isJoining
                  ? (isTeacher
                        ? AppLocalizations.of(context)!.creatingRoom
                        : AppLocalizations.of(context)!.joiningRoom)
                  : (isTimeAvailable
                        ? (isTeacher
                              ? AppLocalizations.of(context)!.createAndJoin
                              : AppLocalizations.of(context)!.enterLesson)
                        : AppLocalizations.of(context)!.lessonComingSoon),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isJoining
              ? (isTeacher
                    ? AppLocalizations.of(context)!.pleaseWaitCreating
                    : AppLocalizations.of(context)!.pleaseWaitJoining)
              : (isTimeAvailable
                    ? (isTeacher
                          ? AppLocalizations.of(context)!.clickToCreateAndJoin
                          : AppLocalizations.of(context)!.clickToJoin)
                    : AppLocalizations.of(context)!.joinButtonAvailableLater),
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
