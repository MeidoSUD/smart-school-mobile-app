import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/api_endpoints.dart';
import '../models/lms_models.dart';
import '../services/api_service.dart';

class LmsRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<String> _getToken() async {
    final token = await storage.read(key: 'token');
    return token ?? '';
  }

  Options _authOptions() {
    return Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Future<Options> _authHeaders() async {
    final token = await _getToken();
    return Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final response = await _api.post(
      ApiEndpoints.lmsLogin,
      {'username': username, 'password': password},
      _authOptions(),
    );

    if (response.data is! Map<String, dynamic>) {
      return LoginResponse(status: 'error', message: 'Unexpected response format from server');
    }

    final loginResponse = LoginResponse.fromJson(response.data as Map<String, dynamic>);
    if (loginResponse.token != null) {
      await storage.write(key: 'token', value: loginResponse.token);
    }
    return loginResponse;
  }

  Future<void> logout() async {
    final token = await _getToken();
    await storage.delete(key: 'token');
    try {
      await _api.post(
        ApiEndpoints.lmsLogout,
        {},
        Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
    } catch (_) {}
  }

  Future<void> changePassword({
    required String currentPass,
    required String newPass,
    required String confirmPass,
  }) async {
    final headers = await _authHeaders();
    await _api.post(
      ApiEndpoints.lmsChangePassword,
      {
        'current_pass': currentPass,
        'new_pass': newPass,
        'confirm_pass': confirmPass,
      },
      headers,
    );
  }

  Future<DashboardModel> getDashboard() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsDashboard,
      headers,
    );
    return DashboardModel.fromJson(response.data);
  }

  Future<LmsUserModel> getProfile() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsProfile,
      headers,
    );
    return LmsUserModel.fromJson(response.data['data'] ?? {});
  }

  Future<List<FeeModel>> getFees() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsGetFees,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final dueFees = data['student_due_fee'] as List? ?? [];
    return dueFees.map((e) => FeeModel.fromJson(e)).toList();
  }

  Future<List<AttendanceModel>> getAttendance({String? start, String? end}) async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsGetAttendance(start: start, end: end),
      headers,
    );
    final data = response.data['data'] as List? ?? [];
    return data.map((e) => AttendanceModel.fromJson(e)).toList();
  }

  Future<List<MarkModel>> getMarks() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsMarks,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final examSchedule = data['examSchedule'] as List? ?? [];
    return examSchedule.map((e) => MarkModel.fromJson(e)).toList();
  }

  Future<List<HomeworkModel>> getHomework() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsHomework,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['homeworklist'] as List? ?? [];
    return list.map((e) => HomeworkModel.fromJson(e)).toList();
  }

  Future<HomeworkModel> getHomeworkDetail(int id, int status) async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsHomeworkDetail(id, status),
      headers,
    );
    return HomeworkModel.fromJson(response.data['data'] ?? {});
  }

  Future<void> uploadHomework({
    required int homeworkId,
    String? message,
    String? filePath,
  }) async {
    final headers = await _authHeaders();
    await _api.post(
      ApiEndpoints.lmsHomeworkUpload,
      {
        'homework_id': homeworkId,
        if (message != null) 'message': message,
        if (filePath != null) 'file': filePath,
      },
      headers,
    );
  }

  Future<List<TimetableModel>> getTimetable() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsTimetable,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['timetable'] as List? ?? [];
    return list.map((e) => TimetableModel.fromJson(e)).toList();
  }

  Future<List<SubjectModel>> getSubjects() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsSubjects,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['subjects'] as List? ?? [];
    return list.map((e) => SubjectModel.fromJson(e)).toList();
  }

  Future<List<SyllabusModel>> getSyllabus() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsSyllabus,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['subjects_data'] as List? ?? [];
    return list.map((e) => SyllabusModel.fromJson(e)).toList();
  }

  Future<List<TeacherModel>> getTeachers() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsTeachers,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['teacherlist'] as List? ?? [];
    return list.map((e) => TeacherModel.fromJson(e)).toList();
  }

  Future<void> rateTeacher({
    required int staffId,
    required int userId,
    required String role,
    String? comment,
    required int rate,
  }) async {
    final headers = await _authHeaders();
    await _api.post(
      ApiEndpoints.lmsTeacherRating,
      {
        'staff_id': staffId,
        'user_id': userId,
        'role': role,
        if (comment != null) 'comment': comment,
        'rate': rate,
      },
      headers,
    );
  }

  Future<List<NotificationModel>> getNotifications() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsNotifications,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['notificationlist'] as List? ?? [];
    return list.map((e) => NotificationModel.fromJson(e)).toList();
  }

  Future<void> markNotificationAsRead(int notificationId) async {
    final headers = await _authHeaders();
    await _api.post(
      ApiEndpoints.lmsNotificationStatus,
      {'notification_id': notificationId},
      headers,
    );
  }

  Future<List<ChatUserModel>> getChatUsers() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsChatMyUser,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['userList'] as List? ?? [];
    return list.map((e) => ChatUserModel.fromJson(e)).toList();
  }

  Future<List<ChatMessageModel>> getChatRecord(int connectionId) async {
    final headers = await _authHeaders();
    final response = await _api.post(
      ApiEndpoints.lmsChatRecord,
      {'chat_connection_id': connectionId},
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['chatList'] as List? ?? [];
    return list.map((e) => ChatMessageModel.fromJson(e)).toList();
  }

  Future<void> sendMessage({
    required int connectionId,
    required int toUserId,
    required String message,
    required String time,
  }) async {
    final headers = await _authHeaders();
    await _api.post(
      ApiEndpoints.lmsNewMessage,
      {
        'chat_connection_id': connectionId,
        'chat_to_user': toUserId,
        'message': message,
        'time': time,
      },
      headers,
    );
  }

  Future<List<LeaveModel>> getLeaveApplications() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsApplyLeave,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['results'] as List? ?? [];
    return list.map((e) => LeaveModel.fromJson(e)).toList();
  }

  Future<void> applyLeave({
    required String applyDate,
    required String fromDate,
    required String toDate,
    String? message,
  }) async {
    final headers = await _authHeaders();
    await _api.post(
      ApiEndpoints.lmsAddLeave,
      {
        'apply_date': applyDate,
        'from_date': fromDate,
        'to_date': toDate,
        if (message != null) 'message': message,
      },
      headers,
    );
  }

  Future<List<BookModel>> getBooks() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsBooks,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['listbook'] as List? ?? [];
    return list.map((e) => BookModel.fromJson(e)).toList();
  }

  Future<List<BookModel>> getIssuedBooks() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsBookIssue,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['bookList'] as List? ?? [];
    return list.map((e) => BookModel.fromJson(e)).toList();
  }

  Future<TransportModel> getTransport() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsRoute,
      headers,
    );
    return TransportModel.fromJson(response.data['data'] ?? {});
  }

  Future<List<ContentModel>> getStudyMaterials() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsContentStudyMaterial,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['list'] as List? ?? [];
    return list.map((e) => ContentModel.fromJson(e)).toList();
  }

  Future<List<ExamModel>> getExamSchedule() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsExamSchedule,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['examSchedule'] as List? ?? [];
    return list.map((e) => ExamModel.fromJson(e)).toList();
  }

  Future<List<ExamResultModel>> getExamResults() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsExamResult,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['exam_result'] as List? ?? [];
    return list.map((e) => ExamResultModel.fromJson(e)).toList();
  }

  Future<List<VisitorModel>> getVisitors() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsVisitors,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['visitor_list'] as List? ?? [];
    return list.map((e) => VisitorModel.fromJson(e)).toList();
  }

  Future<List<CalendarEventModel>> getEvents() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsCalendarEvents,
      headers,
    );
    final data = response.data['data'] as List? ?? [];
    return data.map((e) => CalendarEventModel.fromJson(e)).toList();
  }

  Future<HostelModel> getHostel() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsHostel,
      headers,
    );
    return HostelModel.fromJson(response.data['data'] ?? {});
  }

  Future<List<OnlineExamModel>> getOnlineExams() async {
    final headers = await _authHeaders();
    final response = await _api.get(
      ApiEndpoints.lmsOnlineExam,
      headers,
    );
    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    final list = data['examList'] as List? ?? [];
    return list.map((e) => OnlineExamModel.fromJson(e)).toList();
  }

  Future<void> submitOnlineExam({
    required int examId,
    required Map<String, dynamic> answers,
  }) async {
    final headers = await _authHeaders();
    await _api.post(
      ApiEndpoints.lmsOnlineExamSubmit,
      {'exam_id': examId, 'answers': answers},
      headers,
    );
  }
}