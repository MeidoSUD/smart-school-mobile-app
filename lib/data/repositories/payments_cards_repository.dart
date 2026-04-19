import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/bank_model.dart';
import 'package:geniuses_school/data/models/payment_card_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentsCardsRepository {
  final ApiService _api = ApiService();
  final storage = const FlutterSecureStorage();

  Future<List<BankModel>> getBanks() async {
    try {
      final token = await storage.read(key: 'token');
      Logger.log(
        "PaymentsCardsRepository: getBanks called with token: ${token?.substring(0, 10)}...",
      );

      final response = await _api.get(
        ApiEndpoints.getBanks,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      Logger.log("PaymentsCardsRepository: Banks Response: ${response.data}");
      Logger.log(
        "PaymentsCardsRepository: Response Status Code: ${response.statusCode}",
      );

      final data = (response.data is Map && response.data['data'] != null)
          ? response.data['data'] as List
          : response.data as List;

      Logger.log("PaymentsCardsRepository: Extracted banks data: $data");
      final banks = data
          .map((e) => BankModel.fromJson(e as Map<String, dynamic>))
          .toList();
      Logger.log("PaymentsCardsRepository: Parsed ${banks.length} banks");
      return banks;
    } on DioException catch (e) {
      Logger.log(
        "PaymentsCardsRepository: DioException loading banks: ${e.message}",
      );
      Logger.log("PaymentsCardsRepository: Response: ${e.response?.data}");
      Logger.log(
        "PaymentsCardsRepository: Status Code: ${e.response?.statusCode}",
      );
      throw Exception("Failed to load banks: ${e.message}");
    } catch (e) {
      Logger.log("PaymentsCardsRepository: Exception loading banks: $e");
      throw Exception("Failed to load banks: $e");
    }
  }

  Future<List<PaymentCard>> getPaymentCards({int? roleId}) async {
    try {
      Logger.log(
        "PaymentsCardsRepository: getPaymentCards called with roleId: $roleId",
      );
      final token = await storage.read(key: 'token');
      final endpoint = _getEndpoint(roleId);
      Logger.log("PaymentsCardsRepository: Fetching from endpoint: $endpoint");
      final response = await _api.get(
        endpoint,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final dynamic data = response.data['data'];
      dynamic rawCards = data;

      if (data is Map && data.containsKey('saved_cards')) {
        rawCards = data['saved_cards'];
      }

      if (rawCards is! List) {
        Logger.log("Expected list of payment cards but got: $rawCards");
        return [];
      }
      Logger.log("Fetched payment cards: $rawCards");
      return rawCards
          .map((e) => PaymentCard.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to load payment cards: $msg");
    } catch (e) {
      throw Exception("Failed to load payment cards: $e");
    }
  }

  Future<PaymentCard> addPaymentCard(PaymentCard card, {int? roleId}) async {
    try {
      Logger.log("Adding payment card: ${card.toJson()}");

      final token = await storage.read(key: 'token');
      final endpoint = _getEndpoint(roleId);
      final response = await _api.post(
        endpoint,
        card.toJson(),
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      Logger.log("Add Payment Card Response: ${response.data}");
      final data = response.data['data'];
      if (data != null && data['id'] != null) {
        return PaymentCard.fromJson(data as Map<String, dynamic>);
      }
      return card.copyWith(id: DateTime.now().millisecondsSinceEpoch);
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      Logger.log("Failed to add payment card: $msg");
      throw Exception("Failed to add payment card: $msg");
    } catch (e) {
      Logger.log("Failed to add payment card: $e");
      throw Exception("Failed to add payment card: $e");
    }
  }

  Future<PaymentCard> updateSinglePaymentCard(
    PaymentCard card, {
    int? roleId,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      final endpoint = _getEndpoint(roleId);
      await _api.put(
        endpoint,
        card.toJson(),
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      Logger.log("Updated payment card: ${card.id}");
      return card;
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to update payment card: $msg");
    } catch (e) {
      throw Exception("Failed to update payment card: $e");
    }
  }

  Future<void> deletePaymentCard(int cardId, {int? roleId}) async {
    try {
      final token = await storage.read(key: 'token');
      final endpoint = roleId == 3
          ? "${ApiEndpoints.teacherPaymentMethods}/$cardId"
          : ApiEndpoints.moyasarDeleteCard(cardId);

      final response = await _api.delete(
        endpoint,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      Logger.log("Delete Payment Card Response: ${response.data}");
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to delete payment card: $msg");
    } catch (e) {
      throw Exception("Failed to delete payment card: $e");
    }
  }

  Future<void> setDefaultCard(int cardId, {int? roleId}) async {
    try {
      final token = await storage.read(key: 'token');
      final endpoint = roleId == 3
          ? "${ApiEndpoints.teacherPaymentMethods}/set-default/$cardId"
          : ApiEndpoints.moyasarSetDefaultCard(cardId);

      await _api.post(
        endpoint,
        {},
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      Logger.log("Set default card: $cardId");
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Failed to set default payment card: $msg");
    } catch (e) {
      throw Exception("Failed to set default payment card: $e");
    }
  }

  String _getEndpoint(int? roleId) {
    Logger.log(
      "PaymentsCardsRepository: _getEndpoint called with roleId: $roleId",
    );
    if (roleId == 3) {
      Logger.log("PaymentsCardsRepository: Using teacher endpoint");
      return ApiEndpoints.teacherPaymentMethods;
    }
    Logger.log(
      "PaymentsCardsRepository: Using student endpoint (roleId=$roleId)",
    );
    return ApiEndpoints.moyasarSavedCards;
  }

  @Deprecated('Use updateSinglePaymentCard instead')
  Future<void> updatePaymentCard(paymentCard) async {
    try {
      Logger.log("Updating payment card (legacy): $paymentCard");
      await Future.delayed(const Duration(milliseconds: 500));
    } on DioException catch (e) {
      final msg = e.response?.data ?? e.message;
      throw Exception("Update payment card failed: $msg");
    }
  }
}
