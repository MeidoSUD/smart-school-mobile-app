import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/course_model.dart';
import 'package:geniuses_school/data/models/course_category_model.dart';
import 'package:geniuses_school/data/models/level_model.dart';
import 'package:geniuses_school/data/models/subject_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CourseRepository {
  final ApiService _api = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<List<CourseCategory>> getCourseCategories() async {
    try {
      Logger.log(
        "Fetching course categories from: ${ApiEndpoints.getCourseCategories}",
      );
      final response = await _api.get(
        ApiEndpoints.getCourseCategories,
        Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data;
      if (data is Map<String, dynamic> && data['success'] == true) {
        final categoriesData = data['data'] as List?;
        return categoriesData
                ?.map(
                  (json) =>
                      CourseCategory.fromJson(json as Map<String, dynamic>),
                )
                .toList() ??
            [];
      }
      return [];
    } catch (e) {
      Logger.log("GetCourseCategories error: $e");
      return [];
    }
  }

  Future<List<SubjectModel>> getSubjects() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getCommonSubjects,
        Options(headers: {'Accept': 'application/json'}),
      );
      final data = response.data;
      // API response expected: { success: true, data: [...] } or just [...] depending on controller
      // Based on other endpoints, it's likely { success: true, data: [...] } OR directly list if it's a simple helper
      // But backend route says: Route::get('/common-subjects', [ServicesController::class, 'getAllSubjects']);

      List<dynamic> subjectsData = [];
      if (data is Map<String, dynamic> && data['success'] == true) {
        subjectsData = data['data'] ?? [];
      } else if (data is List) {
        // Handle the specific backend case where it returns [ [subjects...] ]
        if (data.isNotEmpty && data.first is List) {
          subjectsData = data.first;
        } else {
          subjectsData = data;
        }
      } else if (data is Map && data['data'] is List) {
        subjectsData = data['data'];
      }

      return subjectsData.map<SubjectModel>((json) {
        // Safe mapping to SubjectModel, handling potential nulls
        return SubjectModel(
          id: json['id'] is int
              ? json['id']
              : int.tryParse(json['id'].toString()) ?? 0,
          name: json['name_ar'] ?? json['name'] ?? '',
          classId: json['class_id'] != null
              ? (json['class_id'] is int
                    ? json['class_id']
                    : int.tryParse(json['class_id'].toString()) ?? 0)
              : 0,
          levelId: json['education_level_id'] != null
              ? (json['education_level_id'] is int
                    ? json['education_level_id']
                    : int.tryParse(json['education_level_id'].toString()) ?? 0)
              : 0,
        );
      }).toList();
    } catch (e) {
      Logger.log("GetSubjects error: $e");
      return [];
    }
  }

  Future<List<LevelModel>> getEducationLevels() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getLevels,
        Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final levelsData = data['education_levels'] as List?;
        return levelsData
                ?.map(
                  (json) => LevelModel.fromJson(json as Map<String, dynamic>),
                )
                .toList() ??
            [];
      }
      return [];
    } catch (e) {
      Logger.log("GetEducationLevels error: $e");
      return [];
    }
  }

  Future<List<Course>> getCourses({
    int? categoryId,
    int? levelId,
    double? price,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {};
      if (categoryId != null) queryParameters['category_id'] = categoryId;
      if (levelId != null) queryParameters['level'] = levelId;
      if (price != null) queryParameters['max_price'] = price;

      final response = await _api.get(
        ApiEndpoints.getCourses,
        Options(headers: {'Accept': 'application/json'}),
        queryParameters: queryParameters,
      );

      final data = response.data;
      if (data is Map<String, dynamic> && data['success'] == true) {
        final coursesData = data['data'] as List?;
        return coursesData?.map((json) => Course.fromJson(json)).toList() ?? [];
      }
      return [];
    } catch (e) {
      Logger.log("GetCourses error: $e");
      return [];
    }
  }

  Future<Course?> getCourseDetails(int id) async {
    try {
      final response = await _api.get(
        "${ApiEndpoints.getCourses}/$id",
        Options(headers: {'Accept': 'application/json'}),
      );

      final data = response.data;
      if (data is Map<String, dynamic> && data['success'] == true) {
        return Course.fromJson(data['data']['course']);
      }
      return null;
    } catch (e) {
      Logger.log("GetCourseDetails error: $e");
      return null;
    }
  }

  Future<List<Course>> getMyCourses() async {
    final token = await storage.read(key: 'token');
    try {
      Logger.log(
        "Fetching teacher courses from: ${ApiEndpoints.teacherCourses}",
      );
      final response = await _api.get(
        ApiEndpoints.teacherCourses,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data;
      if (data is Map<String, dynamic> && data['success'] == true) {
        final coursesData = data['data'] as List?;
        return coursesData?.map((json) => Course.fromJson(json)).toList() ?? [];
      }
      throw Exception("Failed to load courses");
    } catch (e) {
      Logger.log("GetMyCourses error: $e");
      throw Exception("فشل تحميل دوراتي: $e");
    }
  }

  Future<Course> createCourse(FormData formData) async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.post(
        ApiEndpoints.teacherCourses,
        formData,
        Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == true) {
        return Course.fromJson(response.data['data']);
      }
      throw Exception(response.data['message'] ?? "Failed to create course");
    } catch (e) {
      Logger.log("CreateCourse error: $e");
      throw Exception("فشل إنشاء الدورة: $e");
    }
  }

  Future<void> updateCourse(int id, dynamic data) async {
    final token = await storage.read(key: 'token');
    try {
      // If data is Map and contains files, or we want to support multipart PUT in Laravel
      // we usually send as POST with _method=PUT
      if (data is Map<String, dynamic>) {
        data['_method'] = 'PUT';
      }

      await _api.post(
        ApiEndpoints.teacherCourse(id),
        data,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      Logger.log("UpdateCourse error: $e");
      throw Exception("فشل تحديث الدورة: $e");
    }
  }

  Future<void> deleteCourse(int id) async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.delete(
        ApiEndpoints.teacherCourse(id),
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.data['success'] == false) {
        throw Exception(response.data['message'] ?? "Failed to delete");
      }
    } catch (e) {
      Logger.log("DeleteCourse error: $e");
      throw Exception("فشل حذف الدورة: $e");
    }
  }

  Future<Map<String, dynamic>> enrollInCourse(
    int courseId, {
    int? teacherId,
    int? availabilitySlotId,
    String? note,
  }) async {
    final token = await storage.read(key: 'token');
    try {
      final Map<String, dynamic> data = {
        'course_id': courseId,
        'teacher_id': teacherId,
        'type': 'single', // القيمة الافتراضية المطلوبة من الكنترولر
      };

      if (availabilitySlotId != null) {
        data['availability_slot_id'] = availabilitySlotId;
      }

      if (note != null) {
        data['note'] = note;
      }

      final response = await _api.post(
        ApiEndpoints.enrollInCourse,
        data,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == true) {
        return response.data;
      }
      throw Exception(response.data['message'] ?? "Enrollment failed");
    } catch (e) {
      Logger.log("EnrollInCourse error: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> requestEnrollment(
    int courseId, {
    String? note,
  }) async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.post(
        ApiEndpoints.requestEnrollment(courseId),
        {'note': note},
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == true) {
        return response.data;
      }
      throw Exception(response.data['message'] ?? "Request failed");
    } catch (e) {
      Logger.log("RequestEnrollment error: $e");
      rethrow;
    }
  }
}
