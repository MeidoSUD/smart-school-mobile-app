import 'package:dio/dio.dart';

import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../services/api_service.dart';

class ReviewService {
  final String? token;
  final ApiService _api = ApiService();

  ReviewService({this.token});

  Options get _options => Options(
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token!.isNotEmpty) 'Authorization': 'Bearer $token',
    },
  );

  /// Add review for a teacher after a completed session
  Future<Map<String, dynamic>> addTeacherReview({
    required int teacherId,
    required int sessionId,
    required int rating,
    String? comment,
  }) async {
    final url = ApiEndpoints.addTeacherReview(teacherId);
    Logger.log("POST Review: $url");
    try {
      final response = await _api.post(url, {
        'session_id': sessionId,
        'rating': rating,
        if (comment != null && comment.isNotEmpty) 'comment': comment,
      }, _options);

      final data = response.data;
      Logger.log("POST Review Response: ${response.statusCode}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          'success': true,
          'data': data['data'],
          'message': data['message'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add review',
        };
      }
    } on DioException catch (e) {
      Logger.log(
        "POST Review DIO Error: ${e.response?.statusCode} - ${e.message}",
      );
      return {
        'success': false,
        'message':
            e.response?.data?['message'] ?? e.message ?? 'Error adding review',
      };
    } catch (e) {
      Logger.log("POST Review Error: $e");
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Get review for a specific session
  Future<Map<String, dynamic>> getSessionReview(int sessionId) async {
    final url = ApiEndpoints.getSessionReview(sessionId);
    Logger.log("GET Session Review: $url");
    try {
      final response = await _api.get(url, _options);

      final data = response.data;
      Logger.log("GET Session Review Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        return {
          'success': true,
          'review': data['data'],
          'can_review': data['can_review'] ?? false,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to get review',
        };
      }
    } on DioException catch (e) {
      Logger.log(
        "GET Session Review DIO Error: ${e.response?.statusCode} - ${e.message}",
      );
      return {
        'success': false,
        'message':
            e.response?.data?['message'] ?? e.message ?? 'Error loading review',
      };
    } catch (e) {
      Logger.log("GET Session Review Error: $e");
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Get all session reviews for the authenticated user
  Future<Map<String, dynamic>> getMySessionReviews() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getMySessionReviews,
        _options,
      );

      final data = response.data;

      if (response.statusCode == 200) {
        return {'success': true, 'data': data['data'] ?? []};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to get reviews',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message':
            e.response?.data?['message'] ??
            e.message ??
            'Error loading reviews',
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }

  /// Get all reviews for a teacher
  Future<Map<String, dynamic>> getTeacherReviews(int teacherId) async {
    try {
      final response = await _api.get(
        ApiEndpoints.getTeacherReviews(teacherId),
        _options,
      );

      final data = response.data;

      if (response.statusCode == 200) {
        return {'success': true, 'data': data['data'] ?? []};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to get reviews',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message':
            e.response?.data?['message'] ??
            e.message ??
            'Error loading teacher reviews',
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }
}
