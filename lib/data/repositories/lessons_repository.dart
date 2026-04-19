import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/api_endpoints.dart';
import '../models/session_model.dart';
import '../services/api_service.dart';

class LessonsRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<SessionsResponse> getLessons({required int roleId}) async {
    try {
      final token = await storage.read(key: 'token');
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
      throw Exception("Lessons getting failed: $msg");
    }
  }
}
