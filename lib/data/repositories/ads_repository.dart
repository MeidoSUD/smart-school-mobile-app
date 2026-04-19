import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/api_endpoints.dart';
import '../../core/utils/logger.dart';
import '../models/ad_model.dart';
import '../services/api_service.dart';

class AdsRepository {
  final ApiService _api = ApiService();
  final _storage = const FlutterSecureStorage();

  /// Fetches ads from [ApiEndpoints.getAds].
  /// Returns an empty list (instead of throwing) so callers can show
  /// the default fallback image without crashing.
  Future<List<AdModel>> getAds() async {
    try {
      final token = await _storage.read(key: 'token');

      final response = await _api.get(
        ApiEndpoints.getAds,
        Options(
          headers: {
            'Accept': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      final body = response.data;
      if (body == null || body['success'] != true) return [];

      final data = body['data'];
      if (data == null) return [];

      final adsList = data['ads'];
      if (adsList == null || adsList is! List) return [];

      return adsList
          .whereType<Map<String, dynamic>>()
          .map(AdModel.fromJson)
          .where((ad) => ad.imageUrl.isNotEmpty)
          .toList();
    } catch (e) {
      Logger.log('AdsRepository.getAds failed: $e');
      return []; // ← always fall back gracefully
    }
  }
}
