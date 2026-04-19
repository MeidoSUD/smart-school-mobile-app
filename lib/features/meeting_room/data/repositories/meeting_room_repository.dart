import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../data/services/api_service.dart';
import '../models/meeting_room_model.dart';

class MeetingRoomRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<MeetingRoomResponse> createSession(int sessionId) async {
    try {
      final token = await storage.read(key: 'token');
      // Replace "{id}" with actual sessionId
      final url = ApiEndpoints.createSession.replaceAll('{id}', '$sessionId');

      final response = await _api.post(
        url,
        {}, // Empty body as typically these are query/path param based
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data != null
          ? MeetingRoomResponse.fromJson(response.data)
          : MeetingRoomResponse(success: false, message: "Empty response");
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? e.message;
      throw Exception(msg);
    } catch (e) {
      throw Exception("Unexpected error starting session: $e");
    }
  }

  Future<MeetingRoomResponse> joinSession(int sessionId) async {
    try {
      final token = await storage.read(key: 'token');
      // Replace "{id}" with actual sessionId
      final url = ApiEndpoints.joinSession.replaceAll('{id}', '$sessionId');

      final response = await _api.post(
        url,
        {},
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data != null
          ? MeetingRoomResponse.fromJson(response.data)
          : MeetingRoomResponse(success: false, message: "Empty response");
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? e.message;
      throw Exception(msg);
    } catch (e) {
      throw Exception("Unexpected error joining session: $e");
    }
  }

  Future<MeetingRoomResponse> endSession(int sessionId) async {
    try {
      final token = await storage.read(key: 'token');
      final url = ApiEndpoints.endSession.replaceAll('{id}', '$sessionId');

      final response = await _api.post(
        url,
        {},
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data != null
          ? MeetingRoomResponse.fromJson(response.data)
          : MeetingRoomResponse(success: false, message: "Empty response");
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? e.message;
      throw Exception(msg);
    } catch (e) {
      throw Exception("Unexpected error ending session: $e");
    }
  }
}
