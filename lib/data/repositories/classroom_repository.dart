import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ClassroomRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  // Teacher creates a classroom
  Future<Map<String, dynamic>> createClassroom({required int sessionId}) async {
    Logger.log("Creating classroom for session: $sessionId");
    final token = await storage.read(key: 'token');
    final response = await _api.post(
      ApiEndpoints.createClassroom,
      {'session_id': sessionId},
      Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    Logger.log("Classroom created: ${response.data}");
    return response.data;
  }

  // Student joins a classroom
  Future<Map<String, dynamic>> joinClassroom({
    required int studentId,
    required String classroomId,
  }) async {
    Logger.log("Joining classroom: $classroomId for student: $studentId");
    final token = await storage.read(key: 'token');
    final response = await _api.post(
      ApiEndpoints.joinClassroom,
      {'student_id': studentId, 'classroom_id': classroomId},
      Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    Logger.log("Joined classroom response: ${response.data}");
    return response.data;
  }
}
