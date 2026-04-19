import 'package:dio/dio.dart';
import 'package:geniuses_school/core/constants/api_endpoints.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/wallet_model.dart';
import 'package:geniuses_school/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfitRepository {
  final ApiService _api = ApiService();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<WalletModel> getWallet() async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.get(
        ApiEndpoints.getWallet,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data != null && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null && data is Map<String, dynamic>) {
          return WalletModel.fromJson(data);
        }
      }
      throw Exception("Failed to load wallet data");
    } catch (e) {
      Logger.log("GetWallet error: $e");
      throw Exception("فشل تحميل بيانات المحفظة: $e");
    }
  }

  Future<void> requestWithdrawal(double amount, int paymentMethodId) async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.post(
        ApiEndpoints.requestWithdrawal,
        {"amount": amount, "payment_method_id": paymentMethodId},
        Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == false) {
        throw Exception(response.data['message'] ?? "Withdrawal failed");
      }
    } catch (e) {
      Logger.log("RequestWithdrawal error: $e");
      throw Exception("فشل طلب السحب: $e");
    }
  }

  Future<List<WithdrawalModel>> getWithdrawals({
    String? status,
    int page = 1,
  }) async {
    final token = await storage.read(key: 'token');
    try {
      final Map<String, dynamic> query = {"page": page};
      if (status != null) query["status"] = status;

      final response = await _api.get(
        ApiEndpoints.listWithdrawals,
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        queryParameters: query,
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        if (data is Map<String, dynamic>) {
          final list = data['data'] as List?;
          return list?.map((e) => WithdrawalModel.fromJson(e)).toList() ?? [];
        } else if (data is List) {
          return data.map((e) => WithdrawalModel.fromJson(e)).toList();
        }
      }
      return [];
    } catch (e) {
      Logger.log("GetWithdrawals error: $e");
      return [];
    }
  }

  Future<void> cancelWithdrawal(int id) async {
    final token = await storage.read(key: 'token');
    try {
      final response = await _api.delete(
        ApiEndpoints.cancelWithdrawal(id),
        Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.data['success'] == false) {
        throw Exception(response.data['message'] ?? "Cancel failed");
      }
    } catch (e) {
      Logger.log("CancelWithdrawal error: $e");
      throw Exception("فشل إلغاء طلب السحب: $e");
    }
  }
}
