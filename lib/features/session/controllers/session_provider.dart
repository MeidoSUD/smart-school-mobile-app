import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/logger.dart';
import '../../../../data/models/session_model.dart';
import '../../../../presentation/state/auth_provider.dart';
import '../data/session_repository.dart';

// 1. Define the State class to hold data and filter parameters
class SessionState {
  final AsyncValue<SessionsResponse> sessions;
  final DateTime? selectedDate;
  final SessionStatus? selectedStatus;
  final bool isAscending;

  SessionState({
    this.sessions = const AsyncValue.loading(),
    this.selectedDate,
    this.selectedStatus,
    this.isAscending = true, // Default sort order: Closest First
  });

  SessionState copyWith({
    AsyncValue<SessionsResponse>? sessions,
    DateTime? selectedDate,
    SessionStatus? selectedStatus,
    bool? isAscending,
  }) {
    return SessionState(
      sessions: sessions ?? this.sessions,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isAscending: isAscending ?? this.isAscending,
    );
  }

  // 2. Logic to filter and sort sessions
  List<StudentSession> get filteredSessions {
    final sessionData = sessions.value?.data?.data;
    if (sessionData == null) return [];

    // Filter by Date
    var filtered = sessionData;
    if (selectedDate != null) {
      filtered = filtered.where((session) {
        if (session.sessionDate == null) return false;
        try {
          final sessionDt = DateTime.parse(session.sessionDate!);
          return sessionDt.year == selectedDate!.year &&
              sessionDt.month == selectedDate!.month &&
              sessionDt.day == selectedDate!.day;
        } catch (_) {
          return false;
        }
      }).toList();
    }

    // Filter by Status
    // Only filter if selectedStatus is NOT null AND NOT unknown AND NOT all
    if (selectedStatus != null &&
        selectedStatus != SessionStatus.unknown &&
        selectedStatus != SessionStatus.all) {
      filtered = filtered.where((session) {
        final status = SessionStatus.fromString(session.status);
        return status == selectedStatus;
      }).toList();
    }

    // Sort by Date and Time
    filtered.sort((a, b) {
      if (a.sessionDate == null || b.sessionDate == null) return 0;

      // Parse dates
      var dtA = DateTime.tryParse(a.sessionDate!) ?? DateTime(0);
      var dtB = DateTime.tryParse(b.sessionDate!) ?? DateTime(0);

      // Add start time if available to refine sort
      if (a.startTime != null && a.startTime!.contains(':')) {
        try {
          final parts = a.startTime!.split(':');
          dtA = dtA.add(
            Duration(hours: int.parse(parts[0]), minutes: int.parse(parts[1])),
          );
        } catch (_) {}
      }

      if (b.startTime != null && b.startTime!.contains(':')) {
        try {
          final parts = b.startTime!.split(':');
          dtB = dtB.add(
            Duration(hours: int.parse(parts[0]), minutes: int.parse(parts[1])),
          );
        } catch (_) {}
      }

      return isAscending ? dtA.compareTo(dtB) : dtB.compareTo(dtA);
    });

    return filtered;
  }
}

class SessionNotifier extends StateNotifier<SessionState> {
  final SessionRepository _repository;
  final int roleId;

  SessionNotifier(this._repository, this.roleId) : super(SessionState()) {
    loadSessions();
  }

  Future<void> loadSessions() async {
    state = state.copyWith(sessions: const AsyncValue.loading());
    try {
      final sessions = await _repository.getSessions(roleId: roleId);
      Logger.log("Sessions loaded: ${sessions.data?.data?.length}");
      state = state.copyWith(sessions: AsyncValue.data(sessions));
    } catch (error, stackTrace) {
      Logger.log("Error loading sessions: $error");
      state = state.copyWith(sessions: AsyncValue.error(error, stackTrace));
    }
  }

  // Set the date filter
  void setDateFilter(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  // Clear the date filter
  void clearDateFilter() {
    state = SessionState(
      sessions: state.sessions,
      selectedDate: null, // Explicitly set to null
      selectedStatus: state.selectedStatus,
      isAscending: state.isAscending,
    );
  }

  // Set the status filter
  void setStatusFilter(SessionStatus? status) {
    state = SessionState(
      sessions: state.sessions,
      selectedDate: state.selectedDate,
      selectedStatus: status, // Explicitly set to null or value
      isAscending: state.isAscending,
    );
  }

  // Clear all filters
  void clearAllFilters() {
    state = SessionState(
      sessions: state.sessions,
      selectedDate: null,
      selectedStatus: SessionStatus.all,
      isAscending: state.isAscending,
    );
  }

  // Toggle sort order
  void toggleSort() {
    state = state.copyWith(isAscending: !state.isAscending);
  }
}

final sessionRepositoryProvider = Provider((ref) => SessionRepository());

final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((
  ref,
) {
  final repository = ref.watch(sessionRepositoryProvider);
  final authState = ref.watch(authProvider);
  // Default to student (4) if role is not available
  final roleId = authState.user?.role_id ?? 4;
  return SessionNotifier(repository, roleId);
});

enum SessionStatus {
  all, // Added for "Show All" filter
  live,
  ended,
  cancelled,
  scheduled,
  waitForTeacher,
  completed,
  unknown;

  static SessionStatus fromString(String? status) {
    if (status == null) return SessionStatus.unknown;
    switch (status.toLowerCase()) {
      case 'live':
        return SessionStatus.live;
      case 'ended':
        return SessionStatus.ended;
      case 'cancelled':
        return SessionStatus.cancelled;
      case 'scheduled':
        return SessionStatus.scheduled;
      case 'wait_for_teacher':
        return SessionStatus.waitForTeacher;
      case 'completed':
        return SessionStatus.completed;
      default:
        return SessionStatus.unknown;
    }
  }

  // Removed hardcoded label getter in favor of localized extension method
  String getLabel(BuildContext context) {
    // This method can be used if we import AppLocalizations,
    // or we can use an extension in the UI layer.
    // To keep the model clean, we'll return a key or implement this via extension elsewhere.
    // However, given the context, let's implement a rudimentary mapping here relying on the caller
    // to handle actual localization if we want to keep this pure,
    // BUT since we are Localizing, let's inject a helper or just rely on the UI.
    // Use an extension or helper classes in the UI widgets instead.
    return '';
  }

  Color get color {
    switch (this) {
      case SessionStatus.all:
        return Colors.grey;
      case SessionStatus.live:
        return Colors.green;
      case SessionStatus.ended:
        return Colors.grey;
      case SessionStatus.cancelled:
        return Colors.red;
      case SessionStatus.scheduled:
        return Colors.blue;
      case SessionStatus.waitForTeacher:
        return Colors.orange;
      case SessionStatus.completed:
        return Colors.blue;
      case SessionStatus.unknown:
        return Colors.grey;
    }
  }
}

// Add extension for localization
extension SessionStatusExtension on SessionStatus {
  String localizedLabel(BuildContext context) {
    if (this == SessionStatus.unknown) return "";
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case SessionStatus.all:
        return l10n.sessionStatusAll;
      case SessionStatus.live:
        return l10n.sessionStatusLive;
      case SessionStatus.ended:
        return l10n.sessionStatusEnded;
      case SessionStatus.cancelled:
        return l10n.sessionStatusCancelled;
      case SessionStatus.scheduled:
        return l10n.sessionStatusScheduled;
      case SessionStatus.waitForTeacher:
        return l10n.sessionStatusWaitForTeacher;
      case SessionStatus.completed:
        return l10n.statusCompleted;
      default:
        return "";
    }
  }
}
