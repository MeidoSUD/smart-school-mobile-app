import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/level_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LevelRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<List<LevelModel>> getLevels() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getLevels,
        Options(
          headers: {
            'Accept': 'application/json',
            // 'Authorization': 'Bearer $token',
          },
        ),
      );
      final respnseData = response.data['education_levels'] as List; // from api
      final data = respnseData;
      Logger.log("Fetched levels: $data");
      return data.map((e) => LevelModel.fromJson(e)).toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Fetch levels failed: $msg");
    }
  }
}
