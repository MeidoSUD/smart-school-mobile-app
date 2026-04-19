import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/class_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ClassesRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<List<ClassModel>> getClasses({int? levelId}) async {
    try {
      final response = await _api.get(
        ApiEndpoints.getClasses,
        Options(
          headers: {
            'Accept': 'application/json',
            // 'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data['data'] as List;
      Logger.log("Fetched classes: $data");
      return data.map((e) => ClassModel.fromJson(e)).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Fetch classes failed: $msg");
    }
  }
}
