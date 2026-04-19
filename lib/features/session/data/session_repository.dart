import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/models/session_model.dart';
import '../../../../data/services/api_service.dart';

class SessionRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<SessionsResponse> getSessions({required int roleId}) async {
    try {
      final token = await storage.read(key: 'token');
      // 3 is usually Teacher, 4 is Student. 
      // Adjust logic if needed based on actual role IDs in the system.
      // Based on LessonsRepository: roleId == 3 ? Teacher : Student
      final endpoint = roleId == 3
          ? ApiEndpoints.getTeacherSessions
          : ApiEndpoints.getStudentSessions;

      final response = await _api.get(
        endpoint,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data != null
          ? SessionsResponse.fromJson(response.data)
          : SessionsResponse();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Sessions fetching failed: $msg");
    } catch (e) {
       throw Exception("Unexpected error fetching sessions: $e");
    }
  }
}
