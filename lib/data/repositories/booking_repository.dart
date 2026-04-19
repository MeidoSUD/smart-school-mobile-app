// booking_repository.dart
import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/booking_model.dart';
import 'package:geniuses_school/data/models/books_model.dart';
import 'package:geniuses_school/data/models/pagination_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookingRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> getBookings({int page = 1}) async {
    try {
      final token = await storage.read(key: 'token');
      final url = '${ApiEndpoints.getStudentBookings}?page=$page';
      final response = await _api.get(
        url,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final responseData = response.data['data'] as Map<String, dynamic>?;
      final List<dynamic> bookingsData = responseData?['data'] ?? [];
      final paginationData = responseData?['pagination'] as Map<String, dynamic>? ?? {};

      Logger.log("Response Data: $bookingsData");
      final List<BooksModel> returnedData = bookingsData.map((json) {
        Logger.log("Parsing booking JSON: $json");
        return BooksModel.fromJson(json);
      }).toList();

      final pagination = PaginationInfo.fromJson(paginationData);

      Logger.log(
        "Parsed Bookings: ${returnedData.map((b) => b.toJson()).toList()}",
      );
      Logger.log("Pagination: currentPage=${pagination.currentPage}, lastPage=${pagination.lastPage}, hasMore=${pagination.hasMore}");

      return {
        'bookings': returnedData,
        'pagination': pagination,
      };
    } on DioException catch (e) {
      Logger.log("Error fetching bookings: ${e.response?.data ?? e.message}");
      throw Exception("فشل تحميل الحجوزات: ${e.response?.data?['message'] ?? e.message}");
    } catch (e) {
      Logger.log("Error fetching bookings: $e");
      throw Exception("فشل تحميل الحجوزات: $e");
    }
  }

  Future<Map<String, dynamic>> addBooking(BookingModel booking) async {
    Logger.log("Adding booking: ${booking.toJson()}");
    final response = await _api.post(
      ApiEndpoints.booking,
      booking.toJson(),
      Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${await storage.read(key: 'token')}',
        },
      ),
    );
    final Map<String, dynamic> data = response.data['data'];
    final bool success = response.data['success'];
    final String message = response.data['message'];
    final int? bookingId = data['booking']?['id'];

    Logger.log("Booking added response data: $data");
    return {
      'success': success,
      'message': message,
      'booking_id': bookingId,
      'data': data,
    };
  }

  Future<BookingModel> editBooking(BookingModel booking) async {
    await Future.delayed(const Duration(seconds: 1));
    return booking;
  }

  Future<Map<String, dynamic>> cancelBooking(int bookingId) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.put(
        ApiEndpoints.cancelBooking(bookingId),
        {},
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final bool success = response.data['success'] ?? false;
      final String message = response.data['message'] ?? 
          (success ? 'تم إلغاء الحجز بنجاح' : 'فشل إلغاء الحجز');

      Logger.log("Cancel booking response: ${response.data}");
      return {
        'success': success,
        'message': message,
      };
    } on DioException catch (e) {
      Logger.log("Error canceling booking: ${e.response?.data ?? e.message}");
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'فشل إلغاء الحجز',
      };
    } catch (e) {
      Logger.log("Error canceling booking: $e");
      return {
        'success': false,
        'message': 'حدث خطأ أثناء إلغاء الحجز',
      };
    }
  }
}
