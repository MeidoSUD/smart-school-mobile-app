import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/payment_request.dart';
import 'package:geniuses_school/data/models/payment_response_models.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MoyasarRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  /// Create a payment session
  Future<CheckoutResponse> createPayment(PaymentRequest request) async {
    try {
      final token = await storage.read(key: 'token');

      Logger.log('📤 Sending payment request: ${request.toJson()}');

      final response = await _api.post(
        ApiEndpoints.moyasarCheckout,
        request.toJson(),
        Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];

        Logger.log('✅ Raw payment response: $data');

        Logger.log('✅ Valid payment response received');
        Logger.log('   Payment ID: ${data['payment_id']}');
        Logger.log('   Amount: ${data['amount']} ${data['currency']}');

        return CheckoutResponse.fromJson(data);
      }
      throw PaymentException(
        response.data['message'] ?? 'Failed to create payment',
      );
    } catch (e) {
      Logger.log("❌ Moyasar createPayment error: $e");
      rethrow;
    }
  }

  /// Check payment status after completion
  Future<PaymentStatusResponse> checkPaymentStatus({
    required String paymentId,
    required bool saveCard,
    String? cardBrand,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      final response = await _api.post(
        ApiEndpoints.moyasarStatus,
        {
          'payment_id': paymentId,
          'save_card': saveCard,
          if (cardBrand != null) 'card_brand': cardBrand,
        },
        Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data['success'] == true) {
        return PaymentStatusResponse.fromJson(response.data['data']);
      }
      throw PaymentException(
        response.data['message'] ?? 'Failed to check payment status',
      );
    } catch (e) {
      Logger.log("Moyasar checkPaymentStatus error: $e");
      rethrow;
    }
  }

  /// Get user's saved cards
  Future<List<SavedCard>> getSavedCards() async {
    try {
      final token = await storage.read(key: 'token');

      final response = await _api.get(
        ApiEndpoints.moyasarSavedCards,
        Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data['success'] == true) {
        final savedCards = response.data['data']['saved_cards'] as List;
        return savedCards.map((c) => SavedCard.fromJson(c)).toList();
      }
      throw PaymentException(
        response.data['message'] ?? 'Failed to get saved cards',
      );
    } catch (e) {
      Logger.log("Moyasar getSavedCards error: $e");
      rethrow;
    }
  }

  /// Delete a saved card
  Future<void> deleteSavedCard(int cardId) async {
    try {
      final token = await storage.read(key: 'token');

      final response = await _api.delete(
        ApiEndpoints.moyasarDeleteCard(cardId),
        Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data['success'] != true) {
        throw PaymentException(
          response.data['message'] ?? 'Failed to delete card',
        );
      }
    } catch (e) {
      Logger.log("Moyasar deleteSavedCard error: $e");
      rethrow;
    }
  }

  /// Set default card
  Future<void> setDefaultCard(int cardId) async {
    try {
      final token = await storage.read(key: 'token');

      final response = await _api.post(
        ApiEndpoints.moyasarSetDefaultCard(cardId),
        {},
        Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data['success'] != true) {
        throw PaymentException(
          response.data['message'] ?? 'Failed to set default card',
        );
      }
    } catch (e) {
      Logger.log("Moyasar setDefaultCard error: $e");
      rethrow;
    }
  }
}

class PaymentException implements Exception {
  final String message;
  PaymentException(this.message);
  @override
  String toString() => message;
}
