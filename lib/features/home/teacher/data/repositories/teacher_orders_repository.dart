import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../data/services/api_service.dart';
import '../models/teacher_order_model.dart';

final teacherOrdersRepositoryProvider = Provider<TeacherOrdersRepository>((
  ref,
) {
  return TeacherOrdersRepository();
});

class TeacherOrdersRepository {
  final ApiService _api = ApiService();
  final _storage = const FlutterSecureStorage();

  Future<List<TeacherOrderModel>> getOrders() async {
    final token = await _storage.read(key: 'token');
    try {
      final response = await _api.get(
        ApiEndpoints.getTeacherOrders,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => TeacherOrderModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }

    // Simulate network delay for testing
    await Future.delayed(const Duration(seconds: 5));

    return [
      TeacherOrderModel(
        id: 22,
        userId: 4,
        subjectId: 1,
        type: "single",
        minPrice: 0,
        maxPrice: 150,
        status: "pending",
        notes: "Looking for a good teacher",
        createdAt: DateTime.now(),
        subject: OrderSubject(id: 1, nameEn: "Arabic", nameAr: "اللغة العربية"),
        student: OrderStudent(id: 4, firstName: "محمود", lastName: "أحمد"),
        availableSlots: [
          OrderSlot(
            id: 66,
            date: DateTime.now().toString(),
            startTime: "12:00",
            endTime: "13:00",
            duration: 60,
          ),
        ],
      ),
      TeacherOrderModel(
        id: 21,
        userId: 18,
        subjectId: 1,
        type: "single",
        minPrice: 10,
        maxPrice: 200,
        status: "pending",
        notes: "Need help with grammar",
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        subject: OrderSubject(
          id: 1,
          nameEn: "English",
          nameAr: "اللغة الإنجليزية",
        ),
        student: OrderStudent(id: 18, firstName: "John", lastName: "Doe"),
        availableSlots: [
          OrderSlot(
            id: 65,
            date: DateTime.now().add(const Duration(days: 1)).toString(),
            startTime: "10:30",
            endTime: "12:30",
            duration: 120,
          ),
        ],
      ),
      TeacherOrderModel(
        id: 23,
        userId: 5,
        subjectId: 2,
        type: "single",
        minPrice: 50,
        maxPrice: 250,
        status: "pending",
        notes: "Math test preparation",
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        subject: OrderSubject(id: 2, nameEn: "Math", nameAr: "الرياضيات"),
        student: OrderStudent(id: 5, firstName: "Ali", lastName: "Hassan"),
        availableSlots: [
          OrderSlot(
            id: 67,
            date: DateTime.now().add(const Duration(days: 2)).toString(),
            startTime: "14:00",
            endTime: "15:00",
            duration: 60,
          ),
        ],
      ),
      TeacherOrderModel(
        id: 24,
        userId: 19,
        subjectId: 3,
        type: "single",
        minPrice: 30,
        maxPrice: 180,
        status: "pending",
        notes: "Science project help",
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        subject: OrderSubject(id: 3, nameEn: "Science", nameAr: "العلوم"),
        student: OrderStudent(id: 19, firstName: "Sara", lastName: "Smith"),
        availableSlots: [
          OrderSlot(
            id: 68,
            date: DateTime.now().add(const Duration(days: 3)).toString(),
            startTime: "09:00",
            endTime: "10:30",
            duration: 90,
          ),
        ],
      ),
      TeacherOrderModel(
        id: 25,
        userId: 6,
        subjectId: 4,
        type: "single",
        minPrice: 40,
        maxPrice: 220,
        status: "pending",
        notes: "History lessons needed",
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        subject: OrderSubject(id: 4, nameEn: "History", nameAr: "التاريخ"),
        student: OrderStudent(id: 6, firstName: "Omar", lastName: "Khaled"),
        availableSlots: [
          OrderSlot(
            id: 69,
            date: DateTime.now().add(const Duration(days: 4)).toString(),
            startTime: "16:00",
            endTime: "17:00",
            duration: 60,
          ),
        ],
      ),
      TeacherOrderModel(
        id: 26,
        userId: 20,
        subjectId: 5,
        type: "single",
        minPrice: 60,
        maxPrice: 300,
        status: "pending",
        notes: "Physics tutoring",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        subject: OrderSubject(id: 5, nameEn: "Physics", nameAr: "الفيزياء"),
        student: OrderStudent(id: 20, firstName: "Mike", lastName: "Ross"),
        availableSlots: [
          OrderSlot(
            id: 70,
            date: DateTime.now().add(const Duration(days: 5)).toString(),
            startTime: "11:00",
            endTime: "12:30",
            duration: 90,
          ),
        ],
      ),

      TeacherOrderModel(
        id: 26,
        userId: 20,
        subjectId: 5,
        type: "single",
        minPrice: 60,
        maxPrice: 300,
        status: "pending",
        notes: "Physics tutoring",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        subject: OrderSubject(id: 5, nameEn: "Physics", nameAr: "الفيزياء"),
        student: OrderStudent(id: 20, firstName: "Mike", lastName: "Ross"),
        availableSlots: [
          OrderSlot(
            id: 70,
            date: DateTime.now().add(const Duration(days: 5)).toString(),
            startTime: "11:00",
            endTime: "12:30",
            duration: 90,
          ),
        ],
      ),

      TeacherOrderModel(
        id: 26,
        userId: 20,
        subjectId: 5,
        type: "single",
        minPrice: 60,
        maxPrice: 300,
        status: "pending",
        notes: "Physics tutoring",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        subject: OrderSubject(id: 5, nameEn: "Physics", nameAr: "الفيزياء"),
        student: OrderStudent(id: 20, firstName: "Mike", lastName: "Ross"),
        availableSlots: [
          OrderSlot(
            id: 70,
            date: DateTime.now().add(const Duration(days: 5)).toString(),
            startTime: "11:00",
            endTime: "12:30",
            duration: 90,
          ),
        ],
      ),

      TeacherOrderModel(
        id: 26,
        userId: 20,
        subjectId: 5,
        type: "single",
        minPrice: 60,
        maxPrice: 300,
        status: "pending",
        notes: "Physics tutoring",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        subject: OrderSubject(id: 5, nameEn: "Physics", nameAr: "الفيزياء"),
        student: OrderStudent(id: 20, firstName: "Mike", lastName: "Ross"),
        availableSlots: [
          OrderSlot(
            id: 70,
            date: DateTime.now().add(const Duration(days: 5)).toString(),
            startTime: "11:00",
            endTime: "12:30",
            duration: 90,
          ),
        ],
      ),

      TeacherOrderModel(
        id: 26,
        userId: 20,
        subjectId: 5,
        type: "single",
        minPrice: 60,
        maxPrice: 300,
        status: "pending",
        notes: "Physics tutoring",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        subject: OrderSubject(id: 5, nameEn: "Physics", nameAr: "الفيزياء"),
        student: OrderStudent(id: 20, firstName: "Mike", lastName: "Ross"),
        availableSlots: [
          OrderSlot(
            id: 70,
            date: DateTime.now().add(const Duration(days: 5)).toString(),
            startTime: "11:00",
            endTime: "12:30",
            duration: 90,
          ),
        ],
      ),

      TeacherOrderModel(
        id: 26,
        userId: 20,
        subjectId: 5,
        type: "single",
        minPrice: 60,
        maxPrice: 300,
        status: "pending",
        notes: "Physics tutoring",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        subject: OrderSubject(id: 5, nameEn: "Physics", nameAr: "الفيزياء"),
        student: OrderStudent(id: 20, firstName: "Mike", lastName: "Ross"),
        availableSlots: [
          OrderSlot(
            id: 70,
            date: DateTime.now().add(const Duration(days: 5)).toString(),
            startTime: "11:00",
            endTime: "12:30",
            duration: 90,
          ),
        ],
      ),

      TeacherOrderModel(
        id: 26,
        userId: 20,
        subjectId: 5,
        type: "single",
        minPrice: 60,
        maxPrice: 300,
        status: "pending",
        notes: "Physics tutoring",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        subject: OrderSubject(id: 5, nameEn: "Physics", nameAr: "الفيزياء"),
        student: OrderStudent(id: 20, firstName: "Mike", lastName: "Ross"),
        availableSlots: [
          OrderSlot(
            id: 70,
            date: DateTime.now().add(const Duration(days: 5)).toString(),
            startTime: "11:00",
            endTime: "12:30",
            duration: 90,
          ),
        ],
      ),

      TeacherOrderModel(
        id: 26,
        userId: 20,
        subjectId: 5,
        type: "single",
        minPrice: 60,
        maxPrice: 300,
        status: "pending",
        notes: "Physics tutoring",
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        subject: OrderSubject(id: 5, nameEn: "Physics", nameAr: "الفيزياء"),
        student: OrderStudent(id: 20, firstName: "Mike", lastName: "Ross"),
        availableSlots: [
          OrderSlot(
            id: 70,
            date: DateTime.now().add(const Duration(days: 5)).toString(),
            startTime: "11:00",
            endTime: "12:30",
            duration: 90,
          ),
        ],
      ),
    ];
  }

  Future<void> applyForOrder(int orderId, {String? message}) async {
    final token = await _storage.read(key: 'token');
    try {
      final payload = <String, dynamic>{};
      final trimmedMessage = message?.trim();
      if (trimmedMessage != null && trimmedMessage.isNotEmpty) {
        payload['message'] = trimmedMessage;
      }

      final response = await _api.post(
        ApiEndpoints.applyForOrder.replaceAll('{id}', orderId.toString()),
        payload,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200 || response.data['success'] != true) {
        throw Exception(
          response.data['message'] ?? 'Failed to apply for order',
        );
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final backendMessage = data['message'];
        if (backendMessage is String && backendMessage.trim().isNotEmpty) {
          throw Exception(backendMessage);
        }
      }
      throw Exception('Failed to apply for order');
    } catch (e) {
      throw Exception('Failed to apply for order');
    }
  }
}
