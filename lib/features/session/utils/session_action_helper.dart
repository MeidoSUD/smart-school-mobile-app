import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/session_model.dart';
import '../../../presentation/state/auth_provider.dart';
import '../../meeting_room/controllers/meeting_room_controller.dart';
import '../../meeting_room/data/models/meeting_room_model.dart';
import '../../meeting_room/ui/pro_meeting_room_screen.dart';

class SessionActionHelper {
  static Future<void> joinOrStartSession({
    required BuildContext context,
    required WidgetRef ref,
    required StudentSession session,
    required ValueNotifier<bool> isLoadingNotifier,
  }) async {
    // 1. Debounce check
    if (isLoadingNotifier.value) return;

    final l10n = AppLocalizations.of(context)!;
    final sessionId = session.id;
    if (sessionId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.sessionIdNotAvailable)));
      return;
    }

    // 2. Set Loading
    isLoadingNotifier.value = true;

    try {
      // 3. Determine Role
      // We can check the global auth provider or maybe simpler:
      // check if it's creating (Teacher) or joining (Student).
      // But wait, the previous logic in details screen checked the role ID.
      // Cards logic was separated by widget type (TeacherCard vs StudentCard).
      // To make it truly generic, we should specificy the action OR check the role again.
      // Checking the role is safer and more generic.

      final authState = ref.read(authProvider);
      final userRoleId = authState.user?.role_id ?? 4;
      final isTeacher = userRoleId == 3;

      final notifier = ref.read(meetingRoomProvider.notifier);
      MeetingRoomResponse? response;

      // 4. API Call
      if (isTeacher) {
        response = await notifier.createSession(sessionId);
      } else {
        response = await notifier.joinSession(sessionId);
      }

      // 5. Build Context Check & Navigation
      if (context.mounted) {
        if (response != null &&
            response.success == true &&
            response.data != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProMeetingRoomScreen(data: response!.data!),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response?.message ?? l10n.joinSessionFailed),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${AppLocalizations.of(context)!.errorPrefix}$e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // 6. Reset Loading
      // Note: If we navigated away, we might not want to reset immediately if we dispose,
      // but ValueNotifier is safe enough usually correctly managed.
      // However, if we pop back, we want it to be false.
      isLoadingNotifier.value = false;
    }
  }

  static Future<void> endSession({
    required BuildContext context,
    required WidgetRef ref,
    required StudentSession session,
    required ValueNotifier<bool> isLoadingNotifier,
  }) async {
    if (isLoadingNotifier.value) return;

    final l10n = AppLocalizations.of(context)!;
    final sessionId = session.id;
    if (sessionId == null) return;

    isLoadingNotifier.value = true;

    try {
      final notifier = ref.read(meetingRoomProvider.notifier);
      final response = await notifier.endSession(sessionId);

      if (context.mounted) {
        if (response != null && response.success == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? l10n.sessionEndedMessage),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response?.message ?? l10n.errorPrefix),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${l10n.errorPrefix}$e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isLoadingNotifier.value = false;
    }
  }
}
