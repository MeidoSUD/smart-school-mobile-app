import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/subject_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SubjectsRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<void> updateSubject(subject) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.post(
        ApiEndpoints.updateSubject,
        {"subjects_id": subject},
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      Logger.log("Updating subjects: $subject");
      Logger.log("Updating subjects Response: ${response.data}");
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Update subject failed: $msg");
    }
  }

  Future<List<SubjectModel>> getSubjects() async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.get(
        ApiEndpoints.getSubjects,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data;
      Logger.log("Fetched subjects: $data");

      // Flatten outer list
      final List<dynamic> subjectsJson = data.first;

      return subjectsJson.map((e) => SubjectModel.fromJson(e)).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Fetch subjects failed: $msg");
    }
  }

  Future<List<SubjectModel>> getCommonSubjects() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getCommonSubjects,
        Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data;
      Logger.log("Fetched common subjects: $data");

      // Flatten outer list (matches wrapped format from backend)
      final List<dynamic> subjectsJson = data.first;

      return subjectsJson.map((e) => SubjectModel.fromJson(e)).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Fetch common subjects failed: $msg");
    }
  }
}
