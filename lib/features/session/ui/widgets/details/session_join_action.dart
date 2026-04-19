import 'package:geniuses_school/core/utils/date_time_helper.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SessionJoinAction extends StatelessWidget {
  final SessionState sessionState;
  final bool isJoining;
  final bool isTeacher;
  final VoidCallback? onPressed;
  final VoidCallback? onEndPressed;

  const SessionJoinAction({
    super.key,
    required this.sessionState,
    required this.isJoining,
    required this.isTeacher,
    required this.onPressed,
    this.onEndPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLive = sessionState == SessionState.live;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            // Enable only if live and not currently joining
            onPressed: (isLive && !isJoining) ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isLive ? theme.primaryColor : Colors.grey[300],
              foregroundColor: isLive ? Colors.white : Colors.grey[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: isLive ? 8 : 0,
              disabledBackgroundColor: Colors.grey[300],
              disabledForegroundColor: Colors.grey[600],
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
                : Icon(_getIcon(), size: 20),
            label: Text(
              _getButtonLabel(context),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        if (isTeacher && sessionState == SessionState.live) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton.icon(
              onPressed: !isJoining ? onEndPressed : null,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.stop_circle_outlined, size: 20),
              label: Text(
                AppLocalizations.of(context)!.endSession,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        Text(
          _getHelperText(context),
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  IconData _getIcon() {
    if (sessionState == SessionState.finished)
      return Icons.check_circle_outline;
    if (sessionState == SessionState.upcoming) return Icons.schedule;
    return isTeacher ? Icons.play_arrow : Icons.videocam;
  }

  String _getButtonLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (isJoining) {
      return isTeacher ? l10n.creatingRoom : l10n.joining;
    }
    switch (sessionState) {
      case SessionState.finished:
        return l10n.sessionEndedMessage;
      case SessionState.upcoming:
        return l10n.sessionUpcomingMessage;
      case SessionState.live:
        return isTeacher ? l10n.startSessionNow : l10n.joinSessionNow;
    }
  }

  String _getHelperText(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (isJoining) {
      return isTeacher ? l10n.waitSettingUp : l10n.waitJoining;
    }
    switch (sessionState) {
      case SessionState.finished:
        return l10n.sessionEndedDescription;
      case SessionState.upcoming:
        return l10n.sessionUpcomingDescription;
      case SessionState.live:
        return isTeacher
            ? l10n.createAndEnterDescription
            : l10n.enterDescription;
    }
  }
}
