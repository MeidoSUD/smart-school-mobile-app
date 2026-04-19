import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/dummy_data.dart';
import 'package:geniuses_school/data/models/notification_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  // Get all notifications
  Future<List<NotificationModel>> getNotifications() async {
    try {
      // Simulate API call delay
      // await Future.delayed(const Duration(seconds: 2));

      // // Use dummy data
      // final response = dummyNotifications;
      // Logger.log("Fetched notifications: $response");

      // return response.map((e) => NotificationModel.fromJson(e)).toList();
      final response = await _api.get(ApiEndpoints.getNotifications, Options(
        headers: {
          'Authorization': 'Bearer ${await storage.read(key: 'token')}',
        },
      ));
      Logger.log("Fetched notifications: $response");
      final responsaData = response.data;
      return (responsaData['data'] as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();

    } catch (e) {
      Logger.log("Failed to load notifications: $e");
      throw Exception("Failed to load notifications: $e");
    }
  }

  // Set notification as read (formerly setIsRead for "card"?)
  Future<void> setIsRead(int notificationId) async {
    try {
      // Simulate API call delay
      // await Future.delayed(const Duration(seconds: 1));
      await _api.post(
        ApiEndpoints.markNotificationAsRead(notificationId),
        {},
        Options(
          headers: {
            'Authorization': 'Bearer ${await storage.read(key: 'token')}',
            'accept': 'application/json',
          },
        ),
      );
      Logger.log("Notification $notificationId marked as read");


      // Replace with actual API integration when ready
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Failed to set notification as read: $msg");
      throw Exception("Failed to set notification as read: $msg");
    } catch (e) {
      Logger.log("Failed to set notification as read: $e");
      throw Exception("Failed to set notification as read: $e");
    }
  }

  // Delete a notification
  Future<void> deleteNotification(int notificationId) async {
    try {
      await _api.delete(
        ApiEndpoints.deleteNotification(notificationId),
        Options(
          headers: {
            'Authorization': 'Bearer ${await storage.read(key: 'token')}',
            'accept': 'application/json',
          },
        ),
      );
      Logger.log("Notification $notificationId deleted");
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Failed to delete notification: $msg");
      throw Exception("Failed to delete notification: $msg");
    } catch (e) {
      Logger.log("Failed to delete notification: $e");
      throw Exception("Failed to delete notification: $e");
    }
  }
  // Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await _api.post(
        ApiEndpoints.markAllNotificationsAsRead,
        {},
        Options(
          headers: {
            'Authorization': 'Bearer ${await storage.read(key: 'token')}',
          },
        ),
      );
      Logger.log("All notifications marked as read");
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Failed to mark all notifications as read: $msg");
      throw Exception("Failed to mark all notifications as read: $msg");
    } catch (e) {
      Logger.log("Failed to mark all notifications as read: $e");
      throw Exception("Failed to mark all notifications as read: $e");
    }

}
}


/* 
Expected API Structure:

1. GET /api/payment-cards
   Response: 
   [
     {
       "id": 1,
       "card_number": "4562123456789010",
       "card_holder_name": "John Doe",
       "expiry_date": "12/25",
       "cvv": "123",
       "card_type": "visa",
       "is_default": 1
     },
     ...
   ]

2. POST /api/payment-cards
   Body:
   {
     "card_number": "4562123456789010",
     "card_holder_name": "John Doe",
     "expiry_date": "12/25",
     "cvv": "123",
     "card_type": "visa",
     "is_default": 0
   }
   Response: Same as GET with new ID

3. PUT /api/payment-cards/{id}
   Body: Same as POST
   Response: Updated card object

4. DELETE /api/payment-cards/{id}
   Response: 204 No Content or success message

5. PATCH /api/payment-cards/{id}/set-default
   Body (optional): { "is_default": true }
   Response: Success message or updated card
   Note: This should automatically unset other cards as default

Security Note:
- CVV should ideally NOT be stored on the server
- Card numbers should be tokenized/encrypted
- Only store last 4 digits for display
- Consider using payment gateway tokens instead
*/