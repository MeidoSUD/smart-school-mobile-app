import 'package:dio/dio.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/available_times.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/api_endpoints.dart';
import '../services/api_service.dart';

class AvailableTimesRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<List<AvailableTimes>> getAvailableTimes() async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.get(
        ApiEndpoints.getAvailableTimes,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data['data'] as List;
      Logger.log('Available times ==> $data');
      Logger.log("Fetched subjects: $data");

      final availableTimes = data
          .map((e) => AvailableTimes.fromJson(e))
          .toList();
      return availableTimes;
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("get available times failed: $msg");
    }
  }

  Future<void> updateAvailableTimes(requestBody) async {
    try {
      final token = await storage.read(key: 'token');
      await _api.post(
        ApiEndpoints.updateAvailableTimes,
        requestBody,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      Logger.log("Updated Available Times: $requestBody");
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Update available times failed: $msg");
    }
  }

  Future<void> deleteAvailableTimesBatch(List<int> ids) async {
    try {
      final token = await storage.read(key: 'token');
      // Use query parameters instead of body for DELETE request
      final url = '${ApiEndpoints.deleteAvailableTimesBatch}?ids=${ids.join(',')}';
      await _api.delete(
        url,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      Logger.log("Deleted Available Times IDs: $ids");
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Delete available times batch failed: $msg");
    }
  }
}
