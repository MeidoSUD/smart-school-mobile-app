import 'package:dio/dio.dart';

import '../../core/constants/api_endpoints.dart';
import '../services/api_service.dart';

class FiltersRepository {
  final ApiService _api = ApiService();

  Future<List<Map<String, dynamic>>> getEducationLevels() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getEducationLevels,
        Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data["education_levels"] as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to load education levels: $msg");
    }
  }

  Future<List<Map<String, dynamic>>> getClassesByLevel(int levelId) async {
    try {
      final response = await _api.get(
        ApiEndpoints.getClassesByLevel(levelId),
        Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data["classes"] as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to load classes: $msg");
    }
  }

  Future<List<Map<String, dynamic>>> getSubjectsByClass(int classId) async {
    try {
      final response = await _api.get(
        ApiEndpoints.getSubjectsByClass(classId),
        Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data["subject"] as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to load subjects: $msg");
    }
  }

  Future<List<Map<String, dynamic>>> getServices() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getServices,
        Options(headers: {'Accept': 'application/json'}),
      );

      final List data = response.data as List;
      return data.map((e) => e as Map<String, dynamic>).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to load services: $msg");
    }
  }
}
