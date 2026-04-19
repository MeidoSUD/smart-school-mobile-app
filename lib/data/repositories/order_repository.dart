import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OrderRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  int _toIntId(dynamic id) {
    if (id is int) return id;
    if (id is String) return int.tryParse(id) ?? 0;
    return 0;
  }

  Future<List<Map<String, dynamic>>> getEducationLevels() async {
    try {
      final response = await _api.get(
        ApiEndpoints.getLevels,
        Options(headers: {'Accept': 'application/json'}),
      );

      final educationLevels = response.data['education_levels'] as List? ?? [];
      Logger.log("Fetched education levels: ${educationLevels.length}");
      final levels = educationLevels.map((level) {
        final levelMap = Map<String, dynamic>.from(level);
        if (levelMap['id'] != null) {
          levelMap['id'] = _toIntId(levelMap['id']);
        }
        return levelMap;
      }).toList();
      Logger.log("Education levels with converted IDs: $levels");
      return levels;
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Error fetching education levels: $msg");
      throw Exception(
        "فشل تحميل المراحل التعليمية: ${e.response?.data?['message'] ?? e.message}",
      );
    } catch (e) {
      Logger.log("Unexpected error fetching education levels: $e");
      throw Exception("فشل تحميل المراحل التعليمية: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getClassesByLevel(
    int educationLevelId,
  ) async {
    try {
      final response = await _api.get(
        ApiEndpoints.getClassesByLevel(educationLevelId),
        Options(headers: {'Accept': 'application/json'}),
      );

      final classes = response.data['classes'] as List? ?? [];
      Logger.log(
        "Fetched classes for level $educationLevelId: ${classes.length}",
      );
      Logger.log("Raw classes data: $classes");
      final classesList = classes.map((classItem) {
        final classMap = Map<String, dynamic>.from(classItem);
        if (classMap['id'] != null) {
          classMap['id'] = _toIntId(classMap['id']);
        }
        return classMap;
      }).toList();
      Logger.log("Classes with converted IDs: $classesList");
      return classesList;
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Error fetching classes: $msg");
      throw Exception(
        "فشل تحميل الصفوف: ${e.response?.data?['message'] ?? e.message}",
      );
    } catch (e) {
      Logger.log("Unexpected error fetching classes: $e");
      throw Exception("فشل تحميل الصفوف: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getSubjectsByClass(int classId) async {
    try {
      final response = await _api.get(
        ApiEndpoints.getSubjectsByClass(classId),
        Options(headers: {'Accept': 'application/json'}),
      );

      final subjects = response.data['subject'] as List? ?? [];
      Logger.log("Fetched subjects for class $classId: ${subjects.length}");
      Logger.log("Raw subjects data: $subjects");
      final subjectsList = subjects.map((subject) {
        final subjectMap = Map<String, dynamic>.from(subject);
        if (subjectMap['id'] != null) {
          subjectMap['id'] = _toIntId(subjectMap['id']);
        }
        return subjectMap;
      }).toList();
      Logger.log("Subjects with converted IDs: $subjectsList");
      return subjectsList;
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Error fetching subjects: $msg");
      throw Exception(
        "فشل تحميل المواد: ${e.response?.data?['message'] ?? e.message}",
      );
    } catch (e) {
      Logger.log("Unexpected error fetching subjects: $e");
      throw Exception("فشل تحميل المواد: $e");
    }
  }

  Future<Map<String, dynamic>> createOrder({
    required int subjectId,
    int? classId,
    int? educationLevelId,
    String? orderType,
    int? minPrice,
    int? maxPrice,
    String? notes,
    required List<Map<String, dynamic>> availabilitySlots,
  }) async {
    try {
      final token = await storage.read(key: 'token');

      final requestData = <String, dynamic>{
        'subject_id': subjectId,
        'available_slots': availabilitySlots,
      };

      if (classId != null) {
        requestData['class_id'] = classId;
      }
      if (educationLevelId != null) {
        requestData['education_level_id'] = educationLevelId;
      }
      if (orderType != null) {
        requestData['order_type'] = orderType;
      }
      if (maxPrice != null) {
        requestData['max_price'] = maxPrice;
        if (minPrice != null) {
          requestData['min_price'] = minPrice;
        } else {
          requestData['min_price'] = 0;
        }
      } else if (minPrice != null) {
        requestData['min_price'] = minPrice;
      }
      if (notes != null && notes.isNotEmpty) {
        requestData['notes'] = notes;
      }

      Logger.log("Creating order with data: $requestData");

      final response = await _api.post(
        ApiEndpoints.createOrder,
        requestData,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final success = response.data['success'] ?? false;
      final message = response.data['message'] ?? 'تم إنشاء الطلب بنجاح';
      final data = response.data['data'];

      Logger.log("Order created: success=$success, message=$message");

      return {'success': success, 'message': message, 'data': data};
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ??
          e.response?.data?['error'] ??
          'فشل إنشاء الطلب';
      Logger.log("Error creating order: $errorMessage");
      throw Exception(errorMessage);
    } catch (e) {
      Logger.log("Unexpected error creating order: $e");
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }

  Future<List<dynamic>> getOrders() async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.get(
        ApiEndpoints.getOrders,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final success = response.data['success'] ?? false;
      final orders = response.data['data'] ?? [];

      return orders;
    } on DioException catch (e) {
      Logger.log("Error fetching orders: ${e.response?.data ?? e.message}");
      throw Exception(
        "فشل تحميل الطلبات: ${e.response?.data?['message'] ?? e.message}",
      );
    } catch (e) {
      Logger.log("Error fetching orders: $e");
      throw Exception("فشل تحميل الطلبات: $e");
    }
  }

  Future<Map<String, dynamic>> getOrder(int orderId) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.get(
        ApiEndpoints.getOrder(orderId),
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      Logger.log("Error fetching order: ${e.response?.data ?? e.message}");
      throw Exception(
        "فشل تحميل الطلب: ${e.response?.data?['message'] ?? e.message}",
      );
    } catch (e) {
      Logger.log("Error fetching order: $e");
      throw Exception("فشل تحميل الطلب: $e");
    }
  }
}
