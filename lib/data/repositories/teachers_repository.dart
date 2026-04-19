import 'package:dio/dio.dart';
import 'package:geniuses_school/data/models/teacher_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/api_endpoints.dart';
import '../services/api_service.dart';

class TeachersRepository {
  final ApiService _api = ApiService();
  final storage = FlutterSecureStorage();

  Future<List<TeacherModel>> getTeachers() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getTeachers,
        Options(headers: {'Accept': 'application/json'}),
      );

      final List data = response.data["data"] as List;
      return data.map((e) => TeacherModel.fromJson(e)).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to load teachers: $msg");
    }
  }

  Future<Map<String, dynamic>> getTeacherById(int teacherId) async {
    try {
      final response = await _api.get(
        "${ApiEndpoints.getTeachers}/$teacherId",
        Options(headers: {'Accept': 'application/json'}),
      );

      // Parse to TeacherModel to ensure consistent structure (flattened profile data)
      // then convert back to Map
      final teacher = TeacherModel.fromJson(
        response.data["data"] as Map<String, dynamic>,
      );
      return teacher.toJson();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to load teacher: $msg");
    }
  }

  Future<List<TeacherModel>> getTeachersWithFilters({
    int? subjectId,
    int? educationLevelId,
    int? classId,
    int? serviceId,
    double? maxPrice,
    double? minRating,
    String? searchQuery,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};

      if (subjectId != null) {
        queryParams['subject_id'] = subjectId;
      }
      if (educationLevelId != null) {
        queryParams['education_level_id'] = educationLevelId;
      }
      if (classId != null) {
        queryParams['class_id'] = classId;
      }
      if (serviceId != null) {
        queryParams['service_id'] = serviceId;
      }
      if (maxPrice != null) {
        queryParams['max_price'] = maxPrice;
      }
      if (minRating != null) {
        queryParams['min_rating'] = minRating;
      }
      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['search'] = searchQuery;
      }

      final response = await _api.get(
        ApiEndpoints.getTeachers,
        Options(headers: {'Accept': 'application/json'}),
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final List data = response.data["data"] as List;
      return data.map((e) => TeacherModel.fromJson(e)).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to load teachers: $msg");
    }
  }
}
