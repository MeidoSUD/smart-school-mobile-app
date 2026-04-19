import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/payment_info_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<List<PaymentInfoModel>> getPayments() async {
    final token = await storage.read(key: 'token');
    final response = await _api.get(
      ApiEndpoints.payments,
      Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final responseData = response.data['data'] as List;
    Logger.log("Fetched payments: $responseData");
    return responseData.map((e) => PaymentInfoModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> pay(PaymentInfoModel info) async {
    try {
      Logger.log("Data for pay => ${info.toJson()}");
      final token = await storage.read(key: 'token');

      final response = await _api.post(
        ApiEndpoints.payments,
        info.toJson(),
        Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final responseData = response.data['data'];
      final bool success = response.data['success'] ?? false;
      final bool requires3ds = response.data['requires_3ds'] ?? false;
      final String message =
          response.data['message'] ??
          (success ? 'تم الدفع بنجاح' : 'فشل الدفع');

      Logger.log("After pay response is => ${response.data}");
      return {
        "data": responseData,
        "success": success,
        "message": message,
        "requires_3ds": requires3ds
      };
    } catch (e) {
      Logger.log("Payment error: $e");
      return {"data": null, "success": false, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> checkPaymentStatus(int paymentId) async {
    try {
      Logger.log("Checking payment status for payment_id: $paymentId");
      final token = await storage.read(key: 'token');

      final response = await _api.get(
        "${ApiEndpoints.baseUrl}/payments/$paymentId/status",
        Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final responseData = response.data['data'];
      final bool success = response.data['success'] ?? false;
      final String message =
          response.data['message'] ?? (success ? 'تم الدفع بنجاح' : 'فشل الدفع');

      Logger.log("Payment status response: ${response.data}");

      final paymentStatus = responseData?['status'] as String?;
      final isPaid = paymentStatus == 'paid' || paymentStatus == 'confirmed';

      return {
        "success": success && isPaid,
        "message": message,
        "status": paymentStatus,
        "data": responseData,
      };
    } catch (e) {
      Logger.log("Payment status check error: $e");
      return {
        "success": false,
        "message": e.toString(),
        "status": null,
        "data": null,
      };
    }
  }

  Future<Map<String, dynamic>> checkPaymentResult({
    required String resourcePath,
    String? id,
  }) async {
    try {
      Logger.log("PaymentRepository: Checking payment result with resourcePath: $resourcePath");
      final token = await storage.read(key: 'token');

      final queryParams = <String, String>{
        'resourcePath': resourcePath,
      };
      
      if (id != null) {
        queryParams['id'] = id;
      }

      final response = await _api.get(
        "${ApiEndpoints.baseUrl}/payments/result",
        Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: queryParams,
      );

      Logger.log("PaymentRepository: Payment result response status: ${response.statusCode}");
      Logger.log("PaymentRepository: Payment result response: ${response.data}");

      final responseData = response.data;
      
      if (response.statusCode == 200) {
        if (responseData is Map<String, dynamic>) {
          final success = responseData['success'] ?? false;
          final message = responseData['message'] ?? (success ? 'تم الدفع بنجاح' : 'فشل الدفع');
          final paymentId = responseData['payment_id'];
          final bookingId = responseData['booking_id'];
          final status = responseData['status'];
          final errorCode = responseData['error_code'];
          
          return {
            "success": success,
            "message": message,
            "payment_id": paymentId,
            "booking_id": bookingId,
            "status": status,
            "error_code": errorCode,
            "data": responseData,
          };
        } else {
          return {
            "success": false,
            "message": "استجابة غير صحيحة من الخادم",
            "error_type": "invalid_response_format",
            "data": null,
          };
        }
      } else if (response.statusCode == 400) {
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'] ?? 'فشل الدفع';
          final error = responseData['error'];
          final errorType = responseData['error_type'];
          
          String errorMessage = message;
          if (error != null) {
            errorMessage = '$message\n$error';
          }
          
          return {
            "success": false,
            "message": errorMessage,
            "error": error,
            "error_type": errorType ?? "payment_failed",
            "payment_id": responseData['payment_id'],
            "booking_id": responseData['booking_id'],
            "status": responseData['status'],
            "error_code": responseData['error_code'],
            "data": responseData,
          };
        }
        return {
          "success": false,
          "message": "فشل التحقق من حالة الدفع",
          "error_type": "unknown_error",
          "data": null,
        };
      } else if (response.statusCode == 404) {
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'] ?? 'لم يتم العثور على سجل الدفع';
          return {
            "success": false,
            "message": message,
            "error_type": "payment_not_found",
            "data": responseData,
          };
        }
        return {
          "success": false,
          "message": "لم يتم العثور على سجل الدفع",
          "error_type": "payment_not_found",
          "data": null,
        };
      } else {
        return {
          "success": false,
          "message": "حدث خطأ غير متوقع: ${response.statusCode}",
          "error_type": "unexpected_error",
          "status_code": response.statusCode,
          "data": responseData,
        };
      }
    } catch (e) {
      Logger.log("PaymentRepository: Payment result check error: $e");
      return {
        "success": false,
        "message": e.toString(),
        "data": null,
      };
    }
  }
}
