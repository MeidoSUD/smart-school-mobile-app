import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/language_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<List<Language>> getTeacherLanguages(int teacherId) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.get(
        ApiEndpoints.getTeacherLanguages(teacherId),
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data;
      Logger.log("Teacher languages response: $data");

      if (data['success'] == true && data['data'] != null) {
        final languagesData = data['data']['languages'] as List? ?? [];
        return languagesData
            .map((json) => Language.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("استجابة غير صحيحة من الخادم");
      }
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Failed to load teacher languages: $msg");
      throw Exception("فشل تحميل اللغات: ${e.response?.data?['message'] ?? e.message}");
    } catch (e) {
      Logger.log("Failed to load teacher languages: $e");
      throw Exception("فشل تحميل اللغات: $e");
    }
  }

  Future<List<Language>> addTeacherLanguages(List<int> languageIds) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.post(
        ApiEndpoints.addTeacherLanguages,
        {
          'language_ids': languageIds,
        },
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data;
      Logger.log("Add teacher languages response: $data");

      if (data['success'] == true && data['data'] != null) {
        final languagesData = data['data']['languages'] as List? ?? [];
        return languagesData
            .map((json) => Language.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("استجابة غير صحيحة من الخادم");
      }
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Failed to add teacher languages: $msg");
      throw Exception("فشل إضافة اللغات: ${e.response?.data?['message'] ?? e.message}");
    } catch (e) {
      Logger.log("Failed to add teacher languages: $e");
      throw Exception("فشل إضافة اللغات: $e");
    }
  }

  Future<List<Language>> updateTeacherLanguages(List<int> languageIds) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.put(
        ApiEndpoints.updateTeacherLanguages,
        {
          'language_ids': languageIds,
        },
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data;
      Logger.log("Update teacher languages response: $data");

      if (data['success'] == true && data['data'] != null) {
        final languagesData = data['data']['languages'] as List? ?? [];
        return languagesData
            .map((json) => Language.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("استجابة غير صحيحة من الخادم");
      }
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Failed to update teacher languages: $msg");
      throw Exception("فشل تحديث اللغات: ${e.response?.data?['message'] ?? e.message}");
    } catch (e) {
      Logger.log("Failed to update teacher languages: $e");
      throw Exception("فشل تحديث اللغات: $e");
    }
  }

  Future<void> deleteTeacherLanguage(int languageId) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.delete(
        ApiEndpoints.deleteTeacherLanguage(languageId),
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data;
      Logger.log("Delete teacher language response: $data");

      if (data['success'] != true) {
        throw Exception("فشل حذف اللغة");
      }
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Failed to delete teacher language: $msg");
      throw Exception("فشل حذف اللغة: ${e.response?.data?['message'] ?? e.message}");
    } catch (e) {
      Logger.log("Failed to delete teacher language: $e");
      throw Exception("فشل حذف اللغة: $e");
    }
  }

  Future<List<Language>> getAllLanguages() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getAllLanguages,
        Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      final data = response.data;
      Logger.log("All languages response: $data");

      if (data['success'] == true && data['data'] != null) {
        final languagesData = data['data'] as List;
        final languages = languagesData
            .where((item) => item != null && item['language'] != null)
            .map((item) {
              final languageJson = item['language'] as Map<String, dynamic>;
              return Language.fromJson(languageJson);
            })
            .toList();
        return languages;
      } else {
        throw Exception("استجابة غير صحيحة من الخادم");
      }
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Failed to load all languages: $msg");
      throw Exception("فشل تحميل اللغات: ${e.response?.data?['message'] ?? e.message}");
    } catch (e) {
      Logger.log("Failed to load all languages: $e");
      throw Exception("فشل تحميل اللغات: $e");
    }
  }
}

