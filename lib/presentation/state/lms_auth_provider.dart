import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/error_handler.dart';
import '../../core/utils/logger.dart';
import '../../data/models/lms_models.dart';
import '../../data/repositories/lms_repository.dart';

enum LmsAuthStatus {
  unauthenticated,
  authenticated,
  loading,
  error,
}

class LmsAuthState {
  final LmsUserModel? user;
  final LmsAuthStatus status;
  final String? message;

  LmsAuthState({
    this.user,
    this.status = LmsAuthStatus.unauthenticated,
    this.message,
  });

  LmsAuthState copyWith({
    LmsUserModel? user,
    LmsAuthStatus? status,
    String? message,
  }) {
    return LmsAuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

final lmsAuthProvider = StateNotifierProvider<LmsAuthNotifier, LmsAuthState>(
  (ref) => LmsAuthNotifier(LmsRepository()),
);

class LmsAuthNotifier extends StateNotifier<LmsAuthState> {
  final LmsRepository _repository;
  final storage = const FlutterSecureStorage();

  LmsAuthNotifier(this._repository) : super(LmsAuthState());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(status: LmsAuthStatus.loading);

    try {
      final response = await _repository.login(
        username: username,
        password: password,
      );

      if (response.user != null) {
        state = LmsAuthState(
          user: response.user,
          status: LmsAuthStatus.authenticated,
          message: 'Login successful',
        );
      } else {
        state = LmsAuthState(
          status: LmsAuthStatus.error,
          message: 'Invalid credentials',
        );
      }
    } catch (e) {
      Logger.log("Login error: $e");
      state = LmsAuthState(
        status: LmsAuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      state = state.copyWith(status: LmsAuthStatus.loading);
      await _repository.logout();
    } catch (e) {
      Logger.log("Logout error: $e");
    } finally {
      state = state.copyWith(user: null, status: LmsAuthStatus.unauthenticated);
      if (context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.lmsLogin,
          (route) => false,
        );
      }
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    state = state.copyWith(status: LmsAuthStatus.loading);

    try {
      await _repository.changePassword(
        currentPass: currentPassword,
        newPass: newPassword,
        confirmPass: confirmPassword,
      );
      state = state.copyWith(
        status: LmsAuthStatus.authenticated,
        message: 'Password changed successfully',
      );
    } catch (e) {
      state = LmsAuthState(
        status: LmsAuthStatus.error,
        message: ErrorHandler.getErrorMessage(e),
      );
    }
  }

  Future<void> checkAuth() async {
    final token = await storage.read(key: 'token');
    if (token != null && token.isNotEmpty) {
      try {
        final user = await _repository.getProfile();
        state = LmsAuthState(
          user: user,
          status: LmsAuthStatus.authenticated,
        );
      } catch (e) {
        state = LmsAuthState(status: LmsAuthStatus.unauthenticated);
      }
    } else {
      state = LmsAuthState(status: LmsAuthStatus.unauthenticated);
    }
  }
}

final lmsDashboardProvider = FutureProvider.autoDispose<DashboardModel>((ref) async {
  final repository = LmsRepository();
  return repository.getDashboard();
});

final lmsFeesProvider = FutureProvider.autoDispose<List<FeeModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getFees();
});

final lmsAttendanceProvider =
    FutureProvider.autoDispose.family<List<AttendanceModel>, Map<String, String?>>(
  (ref, params) async {
  final repository = LmsRepository();
  return repository.getAttendance(
    start: params['start'],
    end: params['end'],
  );
});

final lmsMarksProvider = FutureProvider.autoDispose<List<MarkModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getMarks();
});

final lmsHomeworkProvider = FutureProvider.autoDispose<List<HomeworkModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getHomework();
});

final lmsTimetableProvider = FutureProvider.autoDispose<List<TimetableModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getTimetable();
});

final lmsSubjectsProvider = FutureProvider.autoDispose<List<SubjectModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getSubjects();
});

final lmsSyllabusProvider = FutureProvider.autoDispose<List<SyllabusModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getSyllabus();
});

final lmsTeachersProvider = FutureProvider.autoDispose<List<TeacherModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getTeachers();
});

final lmsNotificationsProvider =
    FutureProvider.autoDispose<List<NotificationModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getNotifications();
});

final lmsChatUsersProvider = FutureProvider.autoDispose<List<ChatUserModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getChatUsers();
});

final lmsLeaveProvider = FutureProvider.autoDispose<List<LeaveModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getLeaveApplications();
});

final lmsBooksProvider = FutureProvider.autoDispose<List<BookModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getBooks();
});

final lmsTransportProvider = FutureProvider.autoDispose<TransportModel>((ref) async {
  final repository = LmsRepository();
  return repository.getTransport();
});

final lmsExamScheduleProvider = FutureProvider.autoDispose<List<ExamModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getExamSchedule();
});

final lmsExamResultsProvider =
    FutureProvider.autoDispose<List<ExamResultModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getExamResults();
});

final lmsVisitorsProvider = FutureProvider.autoDispose<List<VisitorModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getVisitors();
});

final lmsEventsProvider = FutureProvider.autoDispose<List<CalendarEventModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getEvents();
});

final lmsHostelProvider = FutureProvider.autoDispose<HostelModel>((ref) async {
  final repository = LmsRepository();
  return repository.getHostel();
});

final lmsOnlineExamsProvider =
    FutureProvider.autoDispose<List<OnlineExamModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getOnlineExams();
});

final lmsStudyMaterialsProvider =
    FutureProvider.autoDispose<List<ContentModel>>((ref) async {
  final repository = LmsRepository();
  return repository.getStudyMaterials();
});